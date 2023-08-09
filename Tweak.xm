%hook SBLockScreenActionContext
- (_Bool)requiresAuthentication
{
	if([[self identifier] isEqualToString:@"MFMailBBDeleteActionIdentifier"])
		return NO;

	return %orig;
}
%end
