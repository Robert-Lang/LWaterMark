//
//  UIView+WaterMark.m
//  WaterMark
//
//  Created by lang on 2021/8/30.
//

#import "UIView+WaterMark.h"
#import <objc/runtime.h>

@interface UIView ()
@property (nonatomic,  strong) CALayer * bgLayer;
@end

@implementation UIView (WaterMark)

static char kAssociatedObjectKey_bgLayer;

- (void)setBgLayer:(CALayer *)bgLayer {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_bgLayer, bgLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CALayer *)bgLayer {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_bgLayer);
}

- (void)removeTextLayers{
    [self.bgLayer removeFromSuperlayer];
    self.bgLayer = nil;
}

- (void)addWaterMarkWithText:(NSString*)waterText textColor:(UIColor*)color font:(UIFont*)font {
    @synchronized (self) {
        
        //计算水印文字的宽高
        NSString *waterMark = waterText;
        CGSize textSize = [waterMark sizeWithAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
        CGFloat height =  [UIScreen mainScreen].bounds.size.height;
        NSInteger line = height*3.5/80; //多少行
        NSInteger row = 20;
        [self removeTextLayers];

        if (!self.bgLayer) {
            self.bgLayer = CALayer.new;
            self.bgLayer.backgroundColor = UIColor.clearColor.CGColor;
            [self.layer addSublayer: self.bgLayer];
        }
        @autoreleasepool {
            for (int i = 0; i < line; i ++) {
                for (int j = 0; j < row; j ++) {
                    
                    CATextLayer *textLayer = [[CATextLayer alloc]init];
                    textLayer.contentsScale = [UIScreen mainScreen].scale;//按当前屏幕分辨显示，否则会模糊
                    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
                    CGFontRef fontRef =CGFontCreateWithFontName(fontName);
                    textLayer.font = fontRef;
                    textLayer.fontSize = font.pointSize;
                    textLayer.foregroundColor = color.CGColor;
                    textLayer.string = waterMark;
                    textLayer.frame = CGRectMake(j*(textSize.width+30),  i*60, textSize.width, textSize.height+ 2);
                    //旋转文字
                    textLayer.transform = CATransform3DMakeRotation(-M_PI/5, 0,0,3);
                    [self.bgLayer addSublayer:textLayer];
                }
            }

        }
    }
 
}

@end
