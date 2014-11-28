//
//  CHCTopMenuViewController.m
//  ScrollTopMenu
//
//  Created by CHC on 14-11-21.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import "CHCTopMenuViewController.h"
#import "CHCTopMenuItem.h"

@interface CHCTopMenuViewController ()
{
    UIScrollView *_contentView;
}

@property (nonatomic, readwrite) CHCTopMenuBar *topMenuBar;

@end

@implementation CHCTopMenuViewController
#pragma mark - View lifecycle
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:_contentRect];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [view setBackgroundColor:[UIColor whiteColor]];
    self.view = view;
    
    [view addSubview:[self contentView]];
    [view addSubview:[self topMenuBar]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGSize viewSize = self.view.frame.size;
    CGFloat menuBarHeight = CGRectGetHeight([[self topMenuBar] frame]);
    if (!menuBarHeight) {
        menuBarHeight = 50;
    }
    
    [[self topMenuBar] setFrame:CGRectMake(0, 0 , viewSize.width, menuBarHeight)];
    [[self contentView] setFrame:CGRectMake(0, menuBarHeight, viewSize.width, viewSize.height - menuBarHeight)];
    [self contentView].contentSize = CGSizeMake(_viewControllers.count * [self contentView].bounds.size.width, [self contentView].bounds.size.height);
    [self updateAllSubViewControllerViewFrame];
    [self setSelectedIndex:[self selectedIndex]];
}

//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskAll;
//}
//
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
////    CGSize viewSize = self.view.frame.size;
////    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
////        [[self topMenuBar] setFrame:CGRectMake(0, 0 , viewSize.width, [self topMenuBar].bounds.size.height)];
////    }
////    else if((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight))
////    {
////        [[self topMenuBar] setFrame:CGRectMake(0, 0 , viewSize.height, [self topMenuBar].bounds.size.height)];
////    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.delegate = self;
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
         UIViewAutoresizingFlexibleHeight];
    }
    return _contentView;
}

- (CHCTopMenuBar *)topMenuBar
{
    if (!_topMenuBar) {
        _topMenuBar = [[CHCTopMenuBar alloc] init];
        [_topMenuBar setBackgroundColor:[UIColor clearColor]];
        [_topMenuBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
         UIViewAutoresizingFlexibleTopMargin];
        [_topMenuBar setDelegate:self];
    }
    return _topMenuBar;
}

#pragma mark - Methods
- (void)updateAllSubViewControllerViewFrame
{
    CGSize contentViewRect = [[self contentView] bounds].size;
    for (int i = 0; i < _viewControllers.count; i++) {
        UIViewController *viewController = [_viewControllers objectAtIndex:i];
        viewController.view.frame = CGRectMake(i * contentViewRect.width, 0, contentViewRect.width, contentViewRect.height);
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    self.selectedViewController = nil;
    _selectedIndex = selectedIndex;
    [self setSelectedViewController:[[self viewControllers] objectAtIndex:selectedIndex]];
    [[self topMenuBar] setSelectedItem:[[self topMenuBar] items][selectedIndex]];
    [_contentView setContentOffset:CGPointMake(_selectedIndex *[self contentView].bounds.size.width, 0) animated:NO];
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        _viewControllers = [viewControllers copy];
        
        NSMutableArray *menuBarItems = [[NSMutableArray alloc] init];
        
        for (UIViewController *viewController in viewControllers) {
            CHCTopMenuItem *menuBarItem = [[CHCTopMenuItem alloc] init];
            [menuBarItem setTitle:viewController.title];
            [menuBarItems addObject:menuBarItem];
            
            [self addChildViewController:viewController];
            viewController.view.frame = [[self contentView] bounds];
            [[self contentView] addSubview:viewController.view];
            [viewController didMoveToParentViewController:self];
        }
        
        [[self topMenuBar] setItems:menuBarItems];
    } else {
        _viewControllers = nil;
    }
}

- (void)changeSelectedViewControllerWithIndex:(NSInteger)index
{
    if (index < 0 || index >= [[self viewControllers] count]) {
        return;
    }
    
    [self setSelectedIndex:index];
    
    if ([[self delegate] respondsToSelector:@selector(topMenuBarController:didSelectViewController:)]) {
        [[self delegate] topMenuBarController:self didSelectViewController:[self viewControllers][index]];
    }
}

#pragma mark - RDVTabBarDelegate
- (void)topMenuBar:(CHCTopMenuBar *)menuBar didSelectItemAtIndex:(NSInteger)index
{
    [self changeSelectedViewControllerWithIndex:index];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = ceil(scrollView.contentOffset.x / scrollView.bounds.size.width);
    [self changeSelectedViewControllerWithIndex:index];
}

@end
