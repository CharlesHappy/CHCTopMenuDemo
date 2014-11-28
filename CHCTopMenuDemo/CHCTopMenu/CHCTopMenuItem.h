//
//  CHCTopMenuItem.h
//  ScrollTopMenu
//
//  Created by CHC on 14-11-21.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCTopMenuItem : UIButton
@property (nonatomic,copy) NSString *title;    // the title displayed by the top menu item
@property (copy) NSDictionary *unselectedTitleAttributes; //The title attributes dictionary used for top menu item's unselected state.
@property (copy) NSDictionary *selectedTitleAttributes; //The title attributes dictionary used for top menu item's selected state.
@end
