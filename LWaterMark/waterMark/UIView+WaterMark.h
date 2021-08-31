//
//  UIView+WaterMark.h
//  WaterMark
//
//  Created by lang on 2021/8/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WaterMark)

- (void)removeTextLayers;
- (void)addWaterMarkWithText:(NSString*)waterText textColor:(UIColor*)color font:(UIFont*)font;
@end

NS_ASSUME_NONNULL_END
