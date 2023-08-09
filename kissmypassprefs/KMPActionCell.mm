#import "PSTableCell.h"
#import "PSSpecifier.h"

#define kIdentifier CFSTR("com.fortysixandtwo.kissmypass")

static NSString *action()
{
    CFStringRef actionIdentifier = CFStringCreateWithFormat(NULL, NULL, CFSTR("%@-latestaction"), kIdentifier);
    return !CFPreferencesCopyAppValue(CFSTR("action"), actionIdentifier) ? @"" : (id)CFPreferencesCopyAppValue(CFSTR("action"), actionIdentifier);
}

static NSString *bundle()
{
    CFStringRef actionIdentifier = CFStringCreateWithFormat(NULL, NULL, CFSTR("%@-latestaction"), kIdentifier);
    return !CFPreferencesCopyAppValue(CFSTR("bundle"), actionIdentifier) ? @"" : (id)CFPreferencesCopyAppValue(CFSTR("bundle"), actionIdentifier);
}

static BOOL debug()
{
    id _debug = (id)CFPreferencesCopyAppValue(CFSTR("debug"), kIdentifier);
    return _debug ? [_debug boolValue] : NO;
}

@interface KMPActionCell : PSTableCell {
    UILabel *_label;
}
@end

@implementation KMPActionCell
- (id)initWithSpecifier:(PSSpecifier *)specifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if(self)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];

        if(debug())
        {
            cell.textLabel.text = bundle() ? bundle() : @"No action logged.";
            cell.detailTextLabel.text = bundle() ? action() : @"";
        }
        else
        {
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
        }

        [self addSubview:cell];
        [cell release];
    }

    return self;
}

- (float)preferredHeightForWidth:(float)width
{
    return 60.f;
}
@end


// #import "PSTableCell.h"
// #import "PSSpecifier.h"
// #import <objc/runtime.h>

// #define kIdentifier CFSTR("com.fortysixandtwo.kissmypass-latestaction")

// static NSString *action()
// {
//     return !CFPreferencesCopyAppValue(CFSTR("action"), kIdentifier) ? @"" : (id)CFPreferencesCopyAppValue(CFSTR("action"), kIdentifier);
// }

// static NSString *bundle()
// {
//     return !CFPreferencesCopyAppValue(CFSTR("bundle"), kIdentifier) ? @"" : (id)CFPreferencesCopyAppValue(CFSTR("bundle"), kIdentifier);
// }

// @interface PSViewController : UIViewController
// {
//     UIViewController *_parentController;
//     id *_rootController;
//     PSSpecifier *_specifier;
// }

// - (void)statusBarWillAnimateByHeight:(double)arg1;
// - (_Bool)canBeShownFromSuspendedState;
// - (void)formSheetViewDidDisappear;
// - (void)formSheetViewWillDisappear;
// - (void)popupViewDidDisappear;
// - (void)popupViewWillDisappear;
// - (void)handleURL:(id)arg1;
// - (void)pushController:(id)arg1;
// - (void)didWake;
// - (void)didUnlock;
// - (void)willUnlock;
// - (void)didLock;
// - (void)suspend;
// - (void)willBecomeActive;
// - (void)willResignActive;
// - (id)readPreferenceValue:(id)arg1;
// - (void)setPreferenceValue:(id)arg1 specifier:(id)arg2;
// - (id)specifier;
// - (void)setSpecifier:(id)arg1;
// - (void)dealloc;
// - (id)rootController;
// - (void)setRootController:(id)arg1;
// - (id)parentController;
// - (void)setParentController:(id)arg1;

// @end

// @interface KMPActionCell : PSTableCell
// @end

// @implementation KMPActionCell

// - (id)initWithStyle:(long long)style reuseIdentifier:(id)identifier specifier:(PSSpecifier *)specifier
// {
//     self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier specifier:specifier];
//     return self;
// }

// - (void)didMoveToSuperview
// {
//     [super didMoveToSuperview];

//     UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//     textLabel.text = !bundle() ? @"No action logged." : [NSString stringWithFormat:@"%@/%@", bundle(), action()];
    
//     [textLabel sizeToFit];
        
//     [self setAccessoryView:textLabel];
//     [textLabel release];
    
//     [_specifier setTarget:self];
// }

// - (void)dealloc
// {
//     [super dealloc];
// }

// @end
