// Lead PT-BR companion for official Lead 2.0.2. No Lead network hooks are replaced.
// Translation tables are the existing tested translation from the pt-br branch.
// Inject this dylib in the MAIN app beside the original Lead.dylib, not in extensions.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <dispatch/dispatch.h>

#import "../../Sources/tgapi/UI/LeadPTBRFeatureStrings.h"
#import "../../Sources/tgapi/UI/LeadPTBRUIStrings.h"

static NSString *const kPTBRPreference = @"LeadPTBRAddonEnabled";
static NSString *const kOriginalLeadPreference = @"LeadLanguage";
static NSString *const kPTBRLanguage = @"pt-BR";

static BOOL PTBREnabled(void) {
    id configured = [[NSUserDefaults standardUserDefaults] objectForKey:kPTBRPreference];
    return configured == nil ? YES : [configured boolValue];
}

static NSDictionary<NSString *, NSString *> *PTBRDictionary(void) {
    static NSDictionary<NSString *, NSString *> *translations = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *merged = [LeadPTBRUIStrings() mutableCopy];
        [merged addEntriesFromDictionary:LeadPTBRFeatureStrings()];
        translations = [merged copy];
    });
    return translations;
}

static NSString *(*originalLocalizedString)(id, SEL, NSString *) = NULL;

static NSString *PTBRLocalizedString(id receiver, SEL selector, NSString *key) {
    if (PTBREnabled() && [key isKindOfClass:[NSString class]]) {
        NSString *translated = PTBRDictionary()[key];
        if (translated) return translated;
    }
    // Untranslated and new Lead 2.0.2 keys retain the official implementation.
    if (originalLocalizedString) return originalLocalizedString(receiver, selector, key);
    return key;
}

static void (*originalViewDidLoad)(id, SEL) = NULL;
static void (*originalDidSelectRow)(id, SEL, UITableView *, NSIndexPath *) = NULL;

static NSArray *PTBRLanguages(id controller) {
    @try {
        id value = [controller valueForKey:@"languages"];
        return [value isKindOfClass:[NSArray class]] ? value : nil;
    } @catch (__unused NSException *exception) {
        return nil;
    }
}

static BOOL PTBRSetValue(id controller, NSString *key, id value) {
    @try {
        [controller setValue:value forKey:key];
        return YES;
    } @catch (__unused NSException *exception) {
        return NO;
    }
}

static void PTBRReloadLanguageTable(id controller) {
    @try {
        id view = [controller valueForKey:@"tableView"];
        if ([view isKindOfClass:[UITableView class]]) [(UITableView *)view reloadData];
    } @catch (__unused NSException *exception) {
    }
}

static void PTBRViewDidLoad(id controller, SEL selector) {
    if (originalViewDidLoad) originalViewDidLoad(controller, selector);
    NSArray *languages = PTBRLanguages(controller);
    if (!languages) return; // Lead changed its UI: skip without breaking it.

    BOOL found = NO;
    for (id item in languages) {
        if ([item isKindOfClass:[NSDictionary class]] &&
            [item[@"code"] isEqualToString:kPTBRLanguage]) {
            found = YES;
            break;
        }
    }
    if (!found) {
        NSMutableArray *updated = [languages mutableCopy];
        NSDictionary *portuguese = @{
            @"code": kPTBRLanguage,
            @"name": @"Português (Brasil)",
            @"flag": @"🇧🇷"
        };
        NSUInteger englishIndex = [updated indexOfObjectPassingTest:
            ^BOOL(id item, NSUInteger idx, BOOL *stop) {
                (void)idx; (void)stop;
                return [item isKindOfClass:[NSDictionary class]] &&
                       [item[@"code"] isEqualToString:@"en"];
            }];
        NSUInteger insertAt = englishIndex == NSNotFound ? 0 :
            MIN(englishIndex + 1, updated.count);
        [updated insertObject:portuguese atIndex:insertAt];
        if (!PTBRSetValue(controller, @"languages", [updated copy])) return;
    }
    if (PTBREnabled()) PTBRSetValue(controller, @"currentCode", kPTBRLanguage);
    PTBRReloadLanguageTable(controller);
}

static void PTBRDidSelectRow(id controller, SEL selector,
                             UITableView *tableView, NSIndexPath *indexPath) {
    NSArray *languages = PTBRLanguages(controller);
    if (!languages || indexPath.row < 0 || (NSUInteger)indexPath.row >= languages.count) {
        if (originalDidSelectRow) originalDidSelectRow(controller, selector, tableView, indexPath);
        return;
    }
    id item = languages[(NSUInteger)indexPath.row];
    NSString *code = [item isKindOfClass:[NSDictionary class]] ? item[@"code"] : nil;
    if (![code isKindOfClass:[NSString class]]) {
        if (originalDidSelectRow) originalDidSelectRow(controller, selector, tableView, indexPath);
        return;
    }

    // Without PT-BR active, delegate selection of original languages to Lead.
    if (!PTBREnabled() && ![code isEqualToString:kPTBRLanguage]) {
        if (originalDidSelectRow) originalDidSelectRow(controller, selector, tableView, indexPath);
        return;
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (PTBREnabled() && [code isEqualToString:kPTBRLanguage]) return;

    NSString *name = [item[@"name"] isKindOfClass:[NSString class]] ?
        item[@"name"] : code;
    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:name
                        message:@"O idioma será aplicado após fechar e abrir o aplicativo."
                 preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"Cancelar"
                                             style:UIAlertActionStyleCancel
                                           handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Aplicar"
                                             style:UIAlertActionStyleDefault
                                           handler:^(__unused UIAlertAction *action) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        BOOL wantsPortuguese = [code isEqualToString:kPTBRLanguage];
        [prefs setBool:wantsPortuguese forKey:kPTBRPreference];
        // Lead 2.0.2 does not recognize pt-BR in its embedded language table.
        // Keep its internal language valid and translate through the companion.
        if (wantsPortuguese) {
            [prefs setObject:@"en" forKey:kOriginalLeadPreference];
        } else {
            [prefs setObject:code forKey:kOriginalLeadPreference];
        }
        [prefs synchronize];
        PTBRSetValue(controller, @"currentCode", code);
        PTBRReloadLanguageTable(controller);
    }]];
    [(UIViewController *)controller presentViewController:alert animated:YES completion:nil];
}

__attribute__((constructor))
static void LeadPTBRInstall(void) {
    @autoreleasepool {
        Class localization = objc_getClass("LeadLocalization");
        Method localeMethod = localization ?
            class_getClassMethod(localization, @selector(localizedStringForKey:)) : NULL;
        if (!localeMethod) {
            NSLog(@"[LeadPTBR] LeadLocalization missing; leaving official Lead unchanged");
            return;
        }
        originalLocalizedString = (NSString *(*)(id, SEL, NSString *))
            method_setImplementation(localeMethod, (IMP)PTBRLocalizedString);

        Class selectorClass = objc_getClass("LanguageSelector");
        if (selectorClass) {
            Method viewMethod = class_getInstanceMethod(selectorClass, @selector(viewDidLoad));
            Method selectionMethod = class_getInstanceMethod(
                selectorClass, @selector(tableView:didSelectRowAtIndexPath:));
            if (viewMethod && selectionMethod) {
                originalViewDidLoad = (void (*)(id, SEL))
                    method_setImplementation(viewMethod, (IMP)PTBRViewDidLoad);
                originalDidSelectRow = (void (*)(id, SEL, UITableView *, NSIndexPath *))
                    method_setImplementation(selectionMethod, (IMP)PTBRDidSelectRow);
            }
        }
        NSLog(@"[LeadPTBR] Companion loaded; %lu translations; enabled=%@",
              (unsigned long)PTBRDictionary().count, PTBREnabled() ? @"YES" : @"NO");
    }
}
