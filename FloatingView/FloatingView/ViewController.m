//
//  ViewController.m
//  FloatingView
//
//  Created by Stacy Cho on 2016-05-02.
//  Copyright © 2016 Stacy Cho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *cameraController;
@property (nonatomic) Boolean isEnlarged;

@end

@implementation ViewController

const int largeX = 150;
const int largeY = 200;
const int smallX = 90;
const int smallY = 120;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _cameraController = [[UIImagePickerController alloc] init];
        _cameraController.delegate = self;
        _cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _cameraController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        _cameraController.showsCameraControls = NO;
        _cameraController.toolbarHidden = YES;
        _cameraController.accessibilityElementsHidden = YES;
        _cameraController.navigationBarHidden = YES;
        _cameraController.edgesForExtendedLayout = UIRectEdgeNone;
        [_cameraController.view setBounds:CGRectMake(0, 0, smallX, smallY)];
        _isEnlarged = NO;
        
        [self.view addSubview:_cameraController.view];
        [_cameraController viewWillAppear:YES];
        [_cameraController viewDidAppear:YES];
    }
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    
    UIPinchGestureRecognizer *pinchIn = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchIn:)];
    UIPinchGestureRecognizer *pinchOut = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchOut:)];
    
    [_cameraController.view addGestureRecognizer:panGesture];
    [_cameraController.view addGestureRecognizer:swipeUp];
    [_cameraController.view addGestureRecognizer:swipeDown];
    [_cameraController.view addGestureRecognizer:swipeLeft];
    [_cameraController.view addGestureRecognizer:swipeRight];
    [_cameraController.view addGestureRecognizer:pinchIn];
    [_cameraController.view addGestureRecognizer:pinchOut];
}

- (void)panRecognizer:(UIPanGestureRecognizer *)gr {
    // need to smooth this part
    CGPoint p = [gr locationInView:_cameraController.view];
    
    CGFloat lowerThresholdX;
    CGFloat lowerThresholdY;
    CGFloat upperThresholdX;
    CGFloat upperThresholdY;
    
    if (_isEnlarged) {
        lowerThresholdX = 20 + largeX/2;
        lowerThresholdY = 20 + largeY/2;
        upperThresholdX = [[UIScreen mainScreen] bounds].size.width - 20 - largeX/2;
        upperThresholdY = [[UIScreen mainScreen] bounds].size.height - 20 - largeY/2;
        
    } else {
        lowerThresholdX = 20 + smallX/2;
        lowerThresholdY = 20 + smallY/2;
        upperThresholdX = [[UIScreen mainScreen] bounds].size.width - 20 - smallX/2;
        upperThresholdY = [[UIScreen mainScreen] bounds].size.height - 20 - smallY/2;
    }
    
    CGPoint center = CGPointMake([gr locationInView:self.view].x, [gr locationInView:self.view].y);
    
    if (center.x < lowerThresholdX) {
        center.x = lowerThresholdX;
    } else if (center.x > upperThresholdX) {
        center.x = upperThresholdX;
    }
    
    if (center.y < lowerThresholdY) {
        center.y = lowerThresholdY;
    } else if (center.y > upperThresholdY) {
        center.y = upperThresholdY;
    }
    
    [_cameraController.view setCenter:center];
}

- (void)swipeUp:(UISwipeGestureRecognizer *)gr {
    
}

- (void)swipeDown:(UISwipeGestureRecognizer *)gr {
    
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)gr {
    
}

- (void)swipeRight:(UISwipeGestureRecognizer *)gr {
    
}

- (void)pinchIn:(UIPinchGestureRecognizer *)gr {
    
}

- (void)pinchOut:(UIPinchGestureRecognizer *)gr {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
