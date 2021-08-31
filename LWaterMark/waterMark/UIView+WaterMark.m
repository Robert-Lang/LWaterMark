//
//  UIView+WaterMark.m
//  WaterMark
//
//  Created by lang on 2021/8/30.
//

#import "UIView+WaterMark.h"
#import <objc/runtime.h>

@interface UIView ()
@property (nonatomic,  strong) NSMutableArray * listLayer;
@end

@implementation UIView (WaterMark)
static char kAssociatedObjectKey_listLayer;

-(void)setListLayer:(NSMutableArray *)listLayer
{
    objc_setAssociatedObject(self, &kAssociatedObjectKey_listLayer, listLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSMutableArray *)listLayer
{
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_listLayer);
}

- (void)removeTextLayers{
    NSArray *arr =  [NSArray arrayWithArray:self.listLayer];
    for (CATextLayer *layer in arr) {
        [layer removeFromSuperlayer];
    }
}

- (void)addWaterMarkWithText:(NSString*)waterText textColor:(UIColor*)color font:(UIFont*)font {
    self.listLayer = NSMutableArray.array;
    //计算水印文字的宽高
    NSString *waterMark = waterText;
    CGSize textSize = [waterMark sizeWithAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    CGFloat height =  [UIScreen mainScreen].bounds.size.height;
    CGFloat width =  [UIScreen mainScreen].bounds.size.width;
    NSInteger line = height*3.5/80; //多少行
    NSInteger row = 20;
    
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
            [self.layer addSublayer:textLayer];
            [self.listLayer addObject:textLayer];
        }
    }
    
    NSArray * list = self.listLayer;
    NSLog(@"");
}

@end
