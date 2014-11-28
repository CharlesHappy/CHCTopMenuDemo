//
//  CHCTopMenuViewController.h
//  ScrollTopMenu
//
//  Created by CHC on 14-11-21.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHCTopMenuBar.h"

@class CHCTopMenuViewController;
@protocol CHCTopMenuViewControllerDelegate <NSObject>
- (void)topMenuBarController:(CHCTopMenuViewController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end

@interface CHCTopMenuViewController : UIViewController<CHCTopMenuBarDelegate,UIScrollViewDelegate>
@property (nonatomic, weak) id<CHCTopMenuViewControllerDelegate> delegate;  //The menu bar controller’s delegate object.
@property (nonatomic,assign) CGRect contentRect;          //self.view.frame
@property (nonatomic, copy) NSArray *viewControllers;    //An array of the root view controllers displayed by the menu bar interface.
@property (nonatomic, readonly) CHCTopMenuBar *topMenuBar;   //The tab bar view associated with this controller. (read-only)
@property (nonatomic, weak) UIViewController *selectedViewController;  //The view controller associated with the currently selected menu item.
@property (nonatomic) NSUInteger selectedIndex;    //The index of the view controller associated with the currently selected menu item.
@end
