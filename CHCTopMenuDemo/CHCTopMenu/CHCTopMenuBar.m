//
//  CHCTopMenuBar.m
//  ScrollTopMenu
//
//  Created by CHC on 14-11-21.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import "CHCTopMenuBar.h"
#import "CHCTopMenuItem.h"

@implementation CHCTopMenuBar
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_backgroundImageView];
        
        self.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0f];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _indicatorBackgroundColor = [UIColor blueColor];
        _indicatorHeight = 2.0f;
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = _indicatorBackgroundColor;
        [_scrollView addSubview:_indicatorView];
        
        _placeStyle = CHCTopMenuItemPlaceStyleLoose;
        _visibleItemsCount = 4;
        _headItemOffsetX = 10;
        _itemSpace = 10;
        _showIndicator = YES;
    }
    return self;
}

- (void)updateIndicatorPosition
{
    _indicatorView.frame = CGRectMake(0, _scrollView.bounds.size.height - _indicatorHeight, _selectedItem.bounds.size.width, _indicatorHeight);
    NSLog(@"_indicatorView.frame = %@",NSStringFromCGRect(_indicatorView.frame));
    _indicatorView.center = CGPointMake(_selectedItem.center.x, _indicatorView.center.y);
}

- (void)layoutSubviews
{
    CGSize frameSize = self.frame.size;
    _scrollView.frame = self.bounds;
    _backgroundImageView.frame = self.bounds;
    _backgroundImageView.image = _backgroundImage;
    _indicatorView.backgroundColor = _indicatorBackgroundColor;
    _indicatorView.hidden = !_showIndicator;
    
    if (_placeStyle == CHCTopMenuItemPlaceStyleLoose) {
        CGFloat itemWidth = frameSize.width / ((self.items.count < _visibleItemsCount)?self.items.count:_visibleItemsCount);
        int index = 0;
        for (CHCTopMenuItem *item in self.items) {
            [item setFrame:CGRectMake(index * itemWidth,
                                      0,
                                      itemWidth, frameSize.height)];
            [item setNeedsDisplay];
            
            index++;
        }
        
        if (self.items.count <= _visibleItemsCount) {
            _scrollView.contentSize = frameSize;
        }
        else
        {
            _scrollView.contentSize = CGSizeMake(self.items.count *itemWidth, _scrollView.bounds.size.height);
        }
    }
    else if (_placeStyle == CHCTopMenuItemPlaceStyleCompact)
    {
        CGFloat offsetX = _headItemOffsetX;
        int index = 0;
        for (CHCTopMenuItem *item in self.items) {
            CGFloat itemWidth = [self getItemWidth:item];
            [item setFrame:CGRectMake(offsetX, 0, itemWidth, frameSize.height)];
            [item setNeedsDisplay];
            if (index < self.items.count - 1) {
                 offsetX += itemWidth + _itemSpace;
            }
            else
            {
                offsetX += itemWidth + _headItemOffsetX;
            }
            index++;
        }
        
        if (offsetX <= frameSize.width) {
            _scrollView.contentSize = frameSize;
        }
        else
        {
            _scrollView.contentSize = CGSizeMake(offsetX, _scrollView.bounds.size.height);
        }
    }
    
    [self updateIndicatorPosition];
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (CGFloat)getItemWidth:(CHCTopMenuItem *)item
{
    CGSize unSelectedTitleSize = [item.title sizeWithAttributes:item.unselectedTitleAttributes];
    CGSize selectedTitleSize = [item.title sizeWithAttributes:item.selectedTitleAttributes];
    return MAX(unSelectedTitleSize.width, selectedTitleSize.width) + 10;
}

- (void)changeItemVisiblePostion
{
    NSInteger selectedIndex = [self.items indexOfObject:_selectedItem];
    NSInteger preIndex = selectedIndex - 1;
    NSInteger nextIndex = selectedIndex + 1;
    if (preIndex >= 0) {
        CHCTopMenuItem *preMenuItem = [self.items objectAtIndex:preIndex];
        [_scrollView scrollRectToVisible:preMenuItem.frame animated:YES];
    }
    
    if (nextIndex <= self.items.count - 1) {
        CHCTopMenuItem *nextMenuItem = [self.items objectAtIndex:nextIndex];
        [_scrollView scrollRectToVisible:nextMenuItem.frame animated:YES];
    }
}

#pragma mark - Configuration
- (void)updateMenuItemsLayout
{
    [self setNeedsLayout];
}

- (void)setHeight:(CGFloat)height
{
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame), height)];
}

- (void)setItems:(NSArray *)aItems {
    for (CHCTopMenuItem *item in aItems) {
        [item removeFromSuperview];
    }
    
    _items = [aItems copy];
    for (CHCTopMenuItem *item in aItems) {
        [item addTarget:self action:@selector(menuBarItemWasSelected:) forControlEvents:UIControlEventTouchDown];
        [_scrollView addSubview:item];
    }
}

- (void)menuBarItemWasSelected:(id)sender {
    [self setSelectedItem:sender];
    if ([[self delegate] respondsToSelector:@selector(topMenuBar:didSelectItemAtIndex:)]) {
        NSInteger index = [self.items indexOfObject:self.selectedItem];
        [[self delegate] topMenuBar:self didSelectItemAtIndex:index];
    }
}

- (void)setSelectedItem:(CHCTopMenuItem *)aSelectedItem {
    if (_selectedItem == aSelectedItem) {
        return;
    }
    [_selectedItem setSelected:NO];
    _selectedItem = aSelectedItem;
    [_selectedItem setSelected:YES];
    [self changeItemVisiblePostion];
    [self updateIndicatorPosition];
}
@end
