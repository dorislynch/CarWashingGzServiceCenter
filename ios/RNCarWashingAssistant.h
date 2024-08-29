#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNCarWashingAssistant : UIResponder

+ (instancetype)carWashing_shared;
- (BOOL)carWashing_cw_followThisWay:(void (^ __nullable)(void))changeVcBlock;
- (UIInterfaceOrientationMask)carWashing_getOrientation;
- (UIViewController *)carWashing_cw_throughMainController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
