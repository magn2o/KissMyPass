#import <Preferences/Preferences.h>

@interface KissMyPassPrefsListController: PSListController {
}
@end

@implementation KissMyPassPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"KissMyPassPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
