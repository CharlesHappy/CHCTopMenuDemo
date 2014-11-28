//
//  SLViewController.m
//  CHCTopMenuDemo
//
//  Created by CHC on 14-11-24.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import "SLViewController.h"

@interface SLViewController ()

@end

@implementation SLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    textLabel.font = [UIFont systemFontOfSize:30];
    textLabel.textColor = [UIColor blackColor];
    textLabel.text = self.title;
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textLabel];
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
