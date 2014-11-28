//
//  ViewController.m
//  CHCTopMenuDemo
//
//  Created by CHC on 14-11-24.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import "ViewController.h"
#import "CHCTopMenuItem.h"
#import "SLViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)customMenuBar
{
    for (CHCTopMenuItem *item in _topMenuViewController.topMenuBar.items) {
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:15],
                                           NSForegroundColorAttributeName: [UIColor greenColor],
                                           };
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:17],
                                         NSForegroundColorAttributeName: [UIColor redColor],
                                         };
    }
    
    [_topMenuViewController.topMenuBar updateMenuItemsLayout];
    _topMenuViewController.topMenuBar.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0  blue:220/255.0  alpha:1.0f];
    [_topMenuViewController.topMenuBar setHeight:50];
    _topMenuViewController.topMenuBar.indicatorBackgroundColor = [UIColor blueColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _topMenuViewController = [[CHCTopMenuViewController alloc] init];
    _topMenuViewController.delegate = self;
    _topMenuViewController.contentRect = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20);
    NSArray *titleArray = [NSArray arrayWithObjects:@"推荐",@"本地",@"苹果公司",@"IT名企",@"教师",@"程序员",@"科学技术",nil];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [titleArray count]; i++) {
        SLViewController *viewController = [[SLViewController alloc] init];
        viewController.title = [titleArray objectAtIndex:i];
        [array addObject:viewController];
        if (i%2 == 0) {
            viewController.view.backgroundColor = [UIColor purpleColor];
        }
        else
        {
            viewController.view.backgroundColor = [UIColor orangeColor];
        }
    }
    _topMenuViewController.viewControllers = array;
    [self.view addSubview:_topMenuViewController.view];
    [self addChildViewController:_topMenuViewController];
    [self customMenuBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CHCTopMenuViewControllerDelegate
- (void)topMenuBarController:(CHCTopMenuViewController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"viewController.title = %@",viewController.title);
}

@end
