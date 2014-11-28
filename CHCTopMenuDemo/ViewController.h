//
//  ViewController.h
//  CHCTopMenuDemo
//
//  Created by CHC on 14-11-24.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CHCTopMenuViewController.h"
@interface ViewController : UIViewController<CHCTopMenuViewControllerDelegate>
@property (nonatomic,strong) CHCTopMenuViewController *topMenuViewController;
@end

