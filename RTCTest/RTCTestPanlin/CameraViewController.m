//
//  CameraViewController.m
//  RTCTestPanlin
//
//  Created by panlin on 2018/10/9.
//  Copyright © 2018年 panlin. All rights reserved.
//
#import "CameraViewController.h"
#import <Foundation/Foundation.h>
#import <QNRTCKit/QNRTCKit.h>


@interface CameraViewController ()
@property (nonatomic, strong)QNRTCSession *session;


@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"BeautyOn" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 50, 100, 60);
    button.backgroundColor = UIColor.blueColor;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    
    
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
}


- (void)clickbutton{
    if (self.session == nil) {
        self.session = [[QNRTCSession alloc] init];
        [self.session setBeautifyModeOn:1];
    }
}


- (void)print{
    printf("开启美颜");
}

@end
