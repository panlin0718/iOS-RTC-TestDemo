//
//  RootViewController.m
//  RTCTestPanlin
//
//  Created by panlin on 2018/9/19.
//  Copyright © 2018年 panlin. All rights reserved.
//

#import "RootViewController.h"
#import "SubViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {  
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"test**test";
    label.frame = CGRectMake(10, 50, 100, 100);
    label.textColor = UIColor.greenColor;
    label.font = [UIFont systemFontOfSize:20];
    label.tag = 11;
    

    [self.view addSubview:label];

    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"278" forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 200, 100, 100);
    button.backgroundColor = UIColor.blackColor;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:30];
    
    
    [button addTarget:self  action:@selector(clickButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    



    
    
    
    // Do any additional setup after loading the view.z
}


- (void)clickButton {
    SubViewController *vc = [[SubViewController alloc ] init];
    [vc  printString];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
