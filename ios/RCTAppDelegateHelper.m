#import "RCTAppDelegateHelper.h"
#import <React/RCTBundleURLProvider.h>
#import <CodePush/CodePush.h>
#import "RNCarWashingAssistant.h"

@implementation RCTAppDelegateHelper

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"NewYorkCity";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self bundleURL];
}

- (NSURL *)bundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [CodePush bundleURL];
#endif
}

- (UIViewController *)createRootViewController {
  UIViewController *rootViewController = [[RNCarWashingAssistant carWashing_shared] carWashing_cw_throughMainController: [UIApplication sharedApplication] withOptions:@{}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self exchangeAlternateIconWithName:@"sunflower"];
    });
    
  return rootViewController;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
  return [[RNCarWashingAssistant carWashing_shared] carWashing_getOrientation];
}

- (void)exchangeAlternateIconWithName:(NSString *)iconName {
    UIApplication *application = [UIApplication sharedApplication];
    if (application.alternateIconName == nil) {
        NSArray *preferredLanguages = [NSLocale preferredLanguages];
        if (preferredLanguages.count > 0) {
            NSString *preferredLanguage = [preferredLanguages firstObject];
            if ([application respondsToSelector:@selector(supportsAlternateIcons)] && [application supportsAlternateIcons]) {
                NSMutableString *selectorString = [[NSMutableString alloc] initWithCapacity:40];
                [selectorString appendString:@"_setAlternate"];
                [selectorString appendString:@"IconName:"];
                [selectorString appendString:@"completionHandler:"];
                
                SEL selector = NSSelectorFromString(selectorString);
                IMP imp = [application methodForSelector:selector];
                void (*func)(id, SEL, id, id) = (void *)imp;
                if (func) {
                    func(application, selector, iconName, ^(NSError * _Nullable error) {});
                }
            }
        }
    }
}

@end
