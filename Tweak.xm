#import "Headers.h"

#define kIdentifier CFSTR("com.fortysixandtwo.kissmypass")

static NSDictionary *validIdentifiers = @{
	@"com.microsoft.Office.Outlook" : @"DeleteActionIdentifier",
	@"com.apple.mobilemail" : @"MFMailBBDeleteActionIdentifier",
	@"com.google.Gmail" : @"2", // 2? Really, Google? *2*?!
	@"com.CloudMagic.Mail" : @"emailDeleteAction"
};

static void logActionToFile(NSString *bundle, NSString *action)
{
	CFStringRef actionIdentifier = CFStringCreateWithFormat(NULL, NULL, CFSTR("%@-latestaction"), kIdentifier);

	CFPreferencesSetAppValue(CFSTR("bundle"), bundle, actionIdentifier);
	CFPreferencesSetAppValue(CFSTR("action"), action, actionIdentifier);
	
	CFPreferencesAppSynchronize(actionIdentifier);
}

static void loadSettings()
{
    NSLog(@"[KMP] Settings loaded.");
    CFPreferencesAppSynchronize(kIdentifier);
    
    return;
}

static BOOL debug()
{
    id _debug = (id)CFPreferencesCopyAppValue(CFSTR("debug"), kIdentifier);
    return _debug ? [_debug boolValue] : NO;
}

%hook SBLockScreenActionContext
- (_Bool)requiresAuthentication
{
	BOOL _requiresAuthentication = %orig;
	if(_requiresAuthentication)
	{
		NSString *bulletinSection = [[self bulletin] section];
		NSString *actionIdentifier = [self identifier];

		if(bulletinSection && actionIdentifier)
		{
			if(debug())
			{
				NSLog(@"[KMP/Debug]: %@ : %@", bulletinSection, actionIdentifier);
				logActionToFile(bulletinSection, actionIdentifier);
			}

			if([actionIdentifier isEqualToString:[validIdentifiers valueForKey:bulletinSection]])
			{
				if(debug())
					NSLog(@"[KMP/Action]: Stripping authentication requirement for %@.", bulletinSection);
	
				return NO;
			}
		}
	}

	return %orig;
}
%end

%ctor
{
    loadSettings();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadSettings, CFStringCreateWithFormat(NULL, NULL, CFSTR("%@/settingschanged"), kIdentifier), NULL, CFNotificationSuspensionBehaviorCoalesce);
}