//
//  AppDelegate.m
//  LWaterMark
//
//  Created by lang on 2021/8/31.
//

#import "AppDelegate.h"
#import "UIView+WaterMark.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
//    [self.window addObserver:self forKeyPath:@"rootViewController" options:NSKeyValueObservingOptionNew context:nil];
    
    self.window.rootViewController = ViewController.new;
    return YES;
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    
//    if([keyPath isEqualToString:@"rootViewController"]) {
//        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
//        NSString *name = [info objectForKey:@"CFBundleDisplayName"];
//        NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
//
//        NSString * text = [NSString stringWithFormat:@"%@ %@",name,version];
//        
//        [UIApplication.sharedApplication.keyWindow removeTextLayersWithSting:text];
//        
//        [UIApplication.sharedApplication.keyWindow addWaterMarkWithText:text textColor:UIColor.purpleColor font:[UIFont systemFontOfSize:8 weight:UIFontWeightRegular]];
//    }
//}


@end
