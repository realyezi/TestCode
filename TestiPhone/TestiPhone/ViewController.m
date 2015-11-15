//
//  ViewController.m
//  TestiPhone
//
//  Created by realyezi on 15/11/14.
//  Copyright © 2015年 李 玥瑶. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
@end
