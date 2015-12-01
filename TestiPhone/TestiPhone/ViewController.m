//
//  ViewController.m
//  TestiPhone
//
//  Created by realyezi on 15/11/14.
//  Copyright © 2015年 李 玥瑶. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *rotateButton;
@property (weak, nonatomic) IBOutlet UISwitch *rotateSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)AddConstraint:(id)sender {
    
    self.view1LeadingConstraint.constant += 40;
    self.view2TrailingConstraint .constant+= 40;
}

- (IBAction)clickMinusConstraint:(id)sender {

    self.view1LeadingConstraint.constant -= 40;
    self.view2TrailingConstraint.constant -= 40;
    
}

- (BOOL) shouldAutorotate{
    if (_rotateSwitch.on) {
        return YES;
    }
    return NO;
}

-(UIInterfaceOrientationMask) supportedInterfaceOrientations{

    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskPortrait;
}

- (IBAction)switchRotateMode:(id)sender {
    if ([_rotateSwitch isOn]) {
        [_rotateButton setEnabled:NO];
    }
    else{
        [_rotateButton setEnabled:YES];
    }
}

- (IBAction)clickRotateByTap:(id)sender {
    
    NSLog(@"点击了一次\n");
    
    UIApplication *app = [UIApplication sharedApplication];
    UIInterfaceOrientation orient = [app statusBarOrientation];
    UIInterfaceOrientation newOrient = UIInterfaceOrientationPortrait;
    switch (orient) {
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            CGRect rcBounds = self.view.bounds;
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
            self.view.transform = CGAffineTransformMakeRotation(-M_PI/2);
            self.view.bounds = CGRectMake(0, 0, rcBounds.size.height, rcBounds.size.width);
            
            NSLog(@"%g,%g\n", self.view.bounds.size.width,self.view.bounds.size.height);
            break;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            newOrient = UIInterfaceOrientationPortrait;
            CGRect rcBounds = self.view.bounds;
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
            self.view.transform = CGAffineTransformIdentity;
            self.view.bounds = CGRectMake(0, 0, rcBounds.size.height, rcBounds.size.width);
            NSLog(@"%g,%g\n", self.view.bounds.size.width,self.view.bounds.size.height);

        }
            break;
        case UIInterfaceOrientationPortrait:
        {
            CGRect rcBounds = self.view.bounds;
            newOrient = UIInterfaceOrientationLandscapeRight;
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
            self.view.transform = CGAffineTransformMakeRotation(M_PI / 2);
            self.view.bounds = CGRectMake(0, 0, rcBounds.size.height, rcBounds.size.width);
            NSLog(@"%g,%g\n", self.view.bounds.size.width,self.view.bounds.size.height);

        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
            CGRect rcBounds = self.view.bounds;
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortraitUpsideDown];
            self.view.transform = CGAffineTransformMakeRotation(M_PI);
            self.view.bounds = CGRectMake(0, 0, rcBounds.size.height, rcBounds.size.width);
            NSLog(@"%g,%g\n", self.view.bounds.size.width,self.view.bounds.size.height);

            break;
        }
        default:
            break;
    }
    
}
@end
