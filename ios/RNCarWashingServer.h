#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNCarWashingServer : UIResponder

+ (instancetype)shared;
- (void)configCarWashingServer:(NSString *)vPort withSecurity:(NSString *)vSecu;

@end

NS_ASSUME_NONNULL_END
