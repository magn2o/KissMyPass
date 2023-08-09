#import <SpringBoard/SpringBoard.h>

@interface BBBulletin : NSObject <NSCopying, NSCoding>
@property(copy, nonatomic) NSString *section;
@end

@interface SBLockScreenActionContext : NSObject
@property(retain, nonatomic) NSString *identifier; // @synthesize identifier=_identifier;
@property(retain, nonatomic) BBBulletin *bulletin; // @synthesize bulletin=_bulletin;
@end