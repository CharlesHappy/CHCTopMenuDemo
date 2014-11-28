//
//  CHCTopMenuBar.h
//  ScrollTopMenu
//
//  Created by CHC on 14-11-21.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHCTopMenuItemPlaceStyle) {
    CHCTopMenuItemPlaceStyleCompact,    //these items place One By One while the count of items is too less
    CHCTopMenuItemPlaceStyleLoose       //these items can Disperse according to menu bar`s width while the count of items                          is too less
};

@class CHCTopMenuBar,CHCTopMenuItem;

@protocol CHCTopMenuBarDelegate <NSObject>
- (void)topMenuBar:(CHCTopMenuBar *)menuBar didSelectItemAtIndex:(NSInteger)index; //Tells the delegate that the specified  item is now selected.
@end

@interface CHCTopMenuBar : UIView
{
    UIScrollView *_scrollView;
    UIImageView *_backgroundImageView;
    UIView *_indicatorView;
}
@property (assign) id <CHCTopMenuBarDelegate>     delegate;              //The tab menu bar delegate object.
@property (nonatomic, copy) NSArray               *items;                //The items displayed on the menu bar.
@property (nonatomic, strong) UIImage             *backgroundImage;      //set the menu bar`s backgroundImage
@property (nonatomic) CHCTopMenuItemPlaceStyle    placeStyle;            //set the all items `s place style on the menu bar. default  placeStyle == CHCTopMenuItemPlaceStyleLoose
@property (assign) CGFloat                        visibleItemsCount;     //display the count of visible items,defalut is 4. (the property can use only placeStyle == CHCTopMenuItemPlaceStyleLoose)
@property (assign) CGFloat                        itemSpace;             //the space between items(the property can use only placeStyle == CHCTopMenuItemPlaceStyleCompact). default is 10
@property (assign) CGFloat                        headItemOffsetX;       // the offset x of the first item (the property can use only placeStyle == CHCTopMenuItemPlaceStyleCompact). default is 10
@property (nonatomic, weak) CHCTopMenuItem        *selectedItem;         //The currently selected item on the tab bar.
@property (nonatomic, assign) BOOL                showIndicator;         //default YES. show indicator which place on the bottom of item
@property (nonatomic,strong) UIColor              *indicatorBackgroundColor;
@property (nonatomic,assign) CGFloat              indicatorHeight;      //default 2.0f
- (void)setHeight:(CGFloat)height;                                       //set the height of bar
- (void)updateMenuItemsLayout;                                           //update item layout while item attrributes change
@end
