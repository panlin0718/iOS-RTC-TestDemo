//
//  SubViewController.m
//  RTCTestPanlin
//
//  Created by panlin on 2018/9/27.
//  Copyright © 2018年 panlin. All rights reserved.
//

#import "SubViewController.h"
#import "CameraViewController.h"
#import <QNRTCKit/QNRTCKit.h>


@interface SubViewController ()
@property (nonatomic, strong)QNRTCSession *session;
@property (nonatomic,assign) BOOL beautyFlag;
@property (nonatomic,assign) BOOL cameraFlag;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UILabel *valueLabel;
@property (nonatomic,strong) UIButton *CameraButton ;


@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIBarButtonItem *iterm = [[UIBarButtonItem alloc] initWithTitle:@"start" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickiterm)];
    self.navigationItem.rightBarButtonItem = iterm;
    
    //beauty button
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"BeautyOn" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 70, 100, 30);
    button.backgroundColor = UIColor.blueColor;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [button addTarget:self action:@selector(clickbutton:) forControlEvents:(UIControlEventTouchUpInside)];  //点击button的动作
    
    [self.view addSubview:button];
    
    //beauty slider
    UISlider *slider = [[UISlider alloc] init];
    slider.frame = CGRectMake(30, 120, 200, 40);
    slider.maximumValue = 100;
    slider.minimumValue = 0;
    slider.value = 30; //当前值
    [slider setContinuous:YES];// 在拖动滑块的任何时候，滑块的值都会改变。默认设置为YES
    
    slider.maximumTrackTintColor = [UIColor blueColor];
    slider.minimumTrackTintColor = [UIColor orangeColor];
    slider.thumbTintColor = [UIColor purpleColor];
    

    
    [slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    // 当前值label
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) / 2, slider.frame.origin.y + 30, 100, 20)];
    self.valueLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel.text = [NSString stringWithFormat:@"%.1f", slider.value];
    [self.view addSubview:self.valueLabel];
    
    // 最小值label
    UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(slider.frame.origin.x - 35, slider.frame.origin.y, 30, 20)];
    minLabel.textAlignment = NSTextAlignmentRight;
    minLabel.text = [NSString stringWithFormat:@"%.1f", slider.minimumValue];
    [self.view addSubview:minLabel];
    
    // 最大值label
    UILabel *maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(slider.frame.origin.x + slider.frame.size.width + 5, slider.frame.origin.y, 30, 20)];
    maxLabel.textAlignment = NSTextAlignmentLeft;
    maxLabel.text = [NSString stringWithFormat:@"%.1f", slider.maximumValue];
    [self.view addSubview:maxLabel];
    
    
    //Camera switching
    UIButton *CameraButton = [[UIButton alloc] init];
    [CameraButton setTitle:@"Camera Swich" forState:UIControlStateNormal];
    CameraButton.frame = CGRectMake(10, 160, 150, 30);
    CameraButton.backgroundColor = UIColor.purpleColor;
    [CameraButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CameraButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [CameraButton addTarget:self action:@selector(clickCameraButton:) forControlEvents:(UIControlEventTouchUpInside)];  //点击button的动作
    
    [self.view addSubview:CameraButton];
    

    
    // Do any additional setup after loading the view.
}


- (void)clickiterm{
    if (self.session == nil) {
        self.session = [[QNRTCSession alloc] init];
//        [self.view addSubview:self.session.previewView];  //该方法默认是将当前界面作为最上层，会覆盖之前添加在上面的button
        [self.view insertSubview:self.session.previewView  atIndex:0];    //使用该方法 atIndex后设置的参数0，表示将当前界面作为最底层，不会覆盖之前添加在上面的button
        [self.session startCapture];
        
//        CameraViewController *vs = [[CameraViewController alloc ] init];
//        [vs  print];
        
        
    }
}

- (void)clickbutton:(UIButton *)sender{

    if(self.beautyFlag == NO){
        self.beautyFlag = YES;
        [self.session setBeautifyModeOn:YES];
        [sender setTitle:@"beautyOn" forState:(UIControlStateNormal)];
        printf("**开启美颜**");
    } else{
        self.beautyFlag = NO;
        [self.session setBeautifyModeOn:NO];
        printf("**关闭美颜**");
        [sender setTitle:@"beautyOff" forState:(UIControlStateNormal)];


    }
}

- (void)valueChange:(UISlider *)sender {
    self.valueLabel.text = [NSString stringWithFormat:@"%.1f", sender.value];
    [self.session setBeautify:sender.value];
    printf("当前美颜程度为：" );
    printf("%.2f",sender.value);

}

- (BOOL)previewMirrorFrontFacing {
   
    return self.cameraFlag;
}

- (BOOL)previewMirrorRearFacing {
    return ~self.cameraFlag;
}   

- (void)clickCameraButton:(UIButton *)sender{
    
    if(self.cameraFlag == NO){
        self.cameraFlag = YES;
        [self.session setPreviewMirrorRearFacing:YES];
        [sender setTitle:@"Rear Camera" forState:(UIControlStateNormal)];
    } else{
        self.cameraFlag = NO;
        [self.session setEncodeMirrorFrontFacing:YES];
        [sender setTitle:@"Front Camera" forState:(UIControlStateNormal)];
        
        
    }
}


    


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.session startCapture];
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [self.session stopCapture];
    [super viewDidDisappear:animated];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)printString{
    printf("这里调用 print 方法");
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
