#import "Headers.h"
#import "LeadUIStrings.h"
#import "LeadPTBRFeatureStrings.h"
#import "LeadPTBRUIStrings.h"

%hook LeadLocalization

- (void)loadDefault {
  NSString *lang =
      [[NSUserDefaults standardUserDefaults] stringForKey:@"LeadLanguage"]
          ?: @"en";

  if (![lang isEqualToString:@"pt-BR"]) {
    %orig;
    return;
  }

  NSMutableDictionary *merged = [LeadUIStrings(@"en") mutableCopy];
  [merged addEntriesFromDictionary:LeadPTBRUIStrings()];
  [merged addEntriesFromDictionary:LeadPTBRFeatureStrings()];

  // `strings` is private in LeadLocalization.m; KVC keeps this PT-BR layer
  // isolated from the upstream implementation and easier to rebase.
  [self setValue:merged forKey:@"strings"];

  self.localization =
      [[objc_getClass("TGLocalization") alloc] initWithVersion:96929692
                                                          code:@"pt-BR"
                                                          dict:merged
                                                      isActive:NO];
}

%end

%hook LanguageSelector

- (void)viewDidLoad {
  %orig;

  NSArray *current = [self valueForKey:@"languages"];
  if (![current isKindOfClass:[NSArray class]]) {
    return;
  }

  for (NSDictionary *language in current) {
    if ([language[@"code"] isEqualToString:@"pt-BR"]) {
      return;
    }
  }

  NSMutableArray *languages = [current mutableCopy];
  NSDictionary *portuguese = @{
    @"code" : @"pt-BR",
    @"name" : @"Português (Brasil)",
    @"flag" : @"🇧🇷"
  };

  NSUInteger englishIndex =
      [languages indexOfObjectPassingTest:^BOOL(NSDictionary *language,
                                                NSUInteger idx,
                                                BOOL *stop) {
        return [language[@"code"] isEqualToString:@"en"];
      }];

  NSUInteger insertIndex =
      englishIndex == NSNotFound ? 0 : MIN(englishIndex + 1, languages.count);
  [languages insertObject:portuguese atIndex:insertIndex];
  [self setValue:[languages copy] forKey:@"languages"];

  UITableView *tableView = [self valueForKey:@"tableView"];
  [tableView reloadData];
}

%end
