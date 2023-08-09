#import "Headers.h"

static NSDictionary *validIdentifiers = @{
	@"com.microsoft.Office.Outlook" : @"DeleteActionIdentifier",
	@"com.apple.mobilemail" : @"MFMailBBDeleteActionIdentifier",
	@"com.google.Gmail" : @"2" // 2? Really, Google? *2*?!
};

%hook SBLockScreenActionContext
- (_Bool)requiresAuthentication
{
	NSString *bulletinSection = [[self bulletin] section];
	NSString *actionIdentifier = [self identifier];

	if(bulletinSection && actionIdentifier)
	{
		NSLog(@"[KMP/Debug]: %@ : %@", bulletinSection, actionIdentifier);
		if([actionIdentifier isEqualToString:[validIdentifiers valueForKey:bulletinSection]])
		{
			NSLog(@"[KMP/Action]: Removing authentication requirement for %@.", bulletinSection);
			return NO;
		}
	}

	return %orig;
}
%end
