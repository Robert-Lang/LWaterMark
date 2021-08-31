//
//  ViewController.m
//  LWaterMark
//
//  Created by lang on 2021/8/31.
//

#import "ViewController.h"
#import "UIView+WaterMark.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton * addBtn = UIButton.new;
    addBtn.tag = 10000;
    addBtn.translatesAutoresizingMaskIntoConstraints=NO;
    [addBtn setBackgroundColor:UIColor.lightGrayColor];
    [addBtn setTitle:@"添加水印" forState:UIControlStateNormal];
    [addBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [addBtn addTarget:self action:@selector(changeWaterMark:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];

    
    UIButton * removeBtn = UIButton.new;
    removeBtn.tag = 10001;
    removeBtn.translatesAutoresizingMaskIntoConstraints=NO;
    [removeBtn setBackgroundColor:UIColor.lightGrayColor];
    [removeBtn setTitle:@"移除水印" forState:UIControlStateNormal];
    [removeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    removeBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [removeBtn addTarget:self action:@selector(changeWaterMark:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeBtn];
    
    NSDictionary*bindings =NSDictionaryOfVariableBindings(addBtn,removeBtn);
    //使用VFL语言生成view1的约束
    NSDictionary *metrics = @{@"height":@(44),@"padding":@(16)};

    NSArray * constraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-padding-[addBtn]-8-[removeBtn(==addBtn)]-padding-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:bindings];

    NSArray* constraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[addBtn(height)]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:NSDictionaryOfVariableBindings(addBtn)];

    NSArray * constraints3 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-padding-[removeBtn(height)]"
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:NSDictionaryOfVariableBindings(removeBtn)];

    [self.view addConstraints:constraints];

    [self.view addConstraints:constraints2];

    [self.view addConstraints:constraints3];


    
    // Do any additional setup after loading the view.
}

- (void)changeWaterMark:(UIButton *)btn {
    
    UIWindow * window = UIApplication.sharedApplication.keyWindow;
    
    if (btn.tag == 10000) {
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        NSString *name = [info objectForKey:@"CFBundleDisplayName"];
        NSString *version = [info objectForKey:@"CFBundleShortVersionString"];

        NSString * text = [NSString stringWithFormat:@"%@ %@",name,version];
        [window addWaterMarkWithText:text textColor:UIColor.purpleColor font:[UIFont systemFontOfSize:8 weight:UIFontWeightRegular]];
    }
    
    if (btn.tag == 10001) {
        [window removeTextLayers];
    }
}
@end
