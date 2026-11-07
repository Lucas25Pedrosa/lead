// Lead PT-BR companion for official Lead 2.0.2. No Lead network hooks are replaced.
// Translation tables are the existing tested translation from the pt-br branch.
// Inject this dylib in the MAIN app beside the original Lead.dylib, not in extensions.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <dispatch/dispatch.h>

#import "../../Sources/tgapi/UI/LeadPTBRFeatureStrings.h"
#import "../../Sources/tgapi/UI/LeadPTBRUIStrings.h"
#import "LeadPTBR202Strings.h"

// Use the native LeadLanguage preference, so the official menu and other
// languages remain synchronized. The old version used a separate bool and
// accidentally translated every language into Portuguese.
static NSString *const kOriginalLeadPreference = @"LeadLanguage";
static NSString *const kPTBRLanguage = @"pt-BR";
static NSString *const kLegacyAddonKey = @"LeadPTBRAddonEnabled";
static NSString *const kMigrationKey = @"LeadPTBRAddonMigratedV2";

static BOOL PTBRActive(void) {
    NSString *language = [[NSUserDefaults standardUserDefaults]
        stringForKey:kOriginalLeadPreference];
    return [language isEqualToString:kPTBRLanguage];
}

// One-time migration of the previous, forced-Portuguese add-on. Do not
// override an already-selected non-English language.
static void PTBRMigrateOldPreference(void) {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs boolForKey:kMigrationKey]) return;
    NSString *code = [prefs stringForKey:kOriginalLeadPreference] ?: @"en";
    id legacy = [prefs objectForKey:kLegacyAddonKey];
    BOOL usedToForcePortuguese = legacy == nil || [legacy boolValue];
    if (usedToForcePortuguese && [code isEqualToString:@"en"]) {
        [prefs setObject:kPTBRLanguage forKey:kOriginalLeadPreference];
    }
    [prefs setBool:YES forKey:kMigrationKey];
    [prefs synchronize];
}

static NSDictionary<NSString *, NSString *> *PTBRDictionary(void) {
    static NSDictionary<NSString *, NSString *> *translations = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *merged = [LeadPTBRUIStrings() mutableCopy];
        [merged addEntriesFromDictionary:LeadPTBRFeatureStrings()];
        [merged addEntriesFromDictionary:LeadPTBR202Strings()];
        translations = [merged copy];
    });
    return translations;
}

static NSString *(*originalLocalizedString)(id, SEL, NSString *) = NULL;

static NSString *PTBRLocalizedString(id receiver, SEL selector, NSString *key) {
    if (PTBRActive() && [key isKindOfClass:[NSString class]]) {
        NSString *translated = PTBRDictionary()[key];
        if (translated) return translated;
    }
    // Untranslated and new Lead 2.0.2 keys retain the official implementation.
    if (originalLocalizedString) return originalLocalizedString(receiver, selector, key);
    return key;
}

// In Lead 2.0.2, -loadDefault resets unknown language codes to "en".
// We bootstrap the official English dictionary, then restore the native
// preference to pt-BR. Only the localizedStringForKey: wrapper translates;
// all functional hooks remain untouched.
static void (*originalLoadDefault)(id, SEL) = NULL;

static void PTBRLoadDefault(id receiver, SEL selector) {
    if (!originalLoadDefault) return;
    if (!PTBRActive()) {
        originalLoadDefault(receiver, selector);
        return;
    }
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"en" forKey:kOriginalLeadPreference];
    @try {
        originalLoadDefault(receiver, selector);
    } @finally {
        [prefs setObject:kPTBRLanguage forKey:kOriginalLeadPreference];
    }
}

// Lead's home screen has a private "LeadLanguageNames" map without pt-BR.
// Intercept only the value rendered as the language name; leave other rows
// and all other languages exactly as Lead originally displays them.
static void (*originalCellShowValue)(id, SEL, NSString *, BOOL) = NULL;
static void PTBRCellShowValue(id receiver, SEL selector, NSString *value,
                              BOOL chevron) {
    if (PTBRActive() && [value isEqualToString:kPTBRLanguage]) {
        value = @"Português (Brasil)";
    }
    if (originalCellShowValue) originalCellShowValue(receiver, selector, value, chevron);
}

static void (*originalViewDidLoad)(id, SEL) = NULL;

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
    if (!languages) return;

    for (id item in languages) {
        if ([item isKindOfClass:[NSDictionary class]] &&
            [item[@"code"] isEqualToString:kPTBRLanguage]) {
            return;
        }
    }
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
    if (PTBRSetValue(controller, @"languages", [updated copy])) {
        // The original selector uses LeadLanguage to mark the selected item.
        PTBRReloadLanguageTable(controller);
    }
}

__attribute__((constructor))
static void LeadPTBRInstall(void) {
    @autoreleasepool {
        Class localization = objc_getClass("LeadLocalization");
        Method localeMethod = localization ?
            class_getClassMethod(localization, @selector(localizedStringForKey:)) : NULL;
        if (!localeMethod) {
            NSLog(@"[LeadPTBR] LeadLocalization unavailable; keeping original Lead");
            return;
        }
        originalLocalizedString = (NSString *(*)(id, SEL, NSString *))
            method_setImplementation(localeMethod, (IMP)PTBRLocalizedString);

        Method loadDefault = class_getInstanceMethod(localization, @selector(loadDefault));
        if (loadDefault) {
            originalLoadDefault = (void (*)(id, SEL))
                method_setImplementation(loadDefault, (IMP)PTBRLoadDefault);
        }

        Class selectorClass = objc_getClass("LanguageSelector");
        Method viewMethod = selectorClass ?
            class_getInstanceMethod(selectorClass, @selector(viewDidLoad)) : NULL;
        if (viewMethod) {
            originalViewDidLoad = (void (*)(id, SEL))
                method_setImplementation(viewMethod, (IMP)PTBRViewDidLoad);
        }

        Class cellClass = objc_getClass("LeadCell");
        Method valueMethod = cellClass ?
            class_getInstanceMethod(cellClass, @selector(showValue:chevron:)) : NULL;
        if (valueMethod) {
            originalCellShowValue = (void (*)(id, SEL, NSString *, BOOL))
                method_setImplementation(valueMethod, (IMP)PTBRCellShowValue);
        }

        PTBRMigrateOldPreference();
        NSLog(@"[LeadPTBR] Loaded, %lu translations; LeadLanguage=%@",
              (unsigned long)PTBRDictionary().count,
              [[NSUserDefaults standardUserDefaults] stringForKey:kOriginalLeadPreference]);
    }
}
