//
//  CHCTopMenuItem.m
//  ScrollTopMenu
//
//  Created by CHC on 14-11-21.
//  Copyright (c) 2014年 charles. All rights reserved.
//

#import "CHCTopMenuItem.h"

@implementation CHCTopMenuItem
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Setup defaults
        
        _title = @"";
        if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
            _unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:15],
                                           NSForegroundColorAttributeName: [UIColor blackColor],
                                           };
            _selectedTitleAttributes = @{
                                            NSFontAttributeName: [UIFont systemFontOfSize:15],
                                            NSForegroundColorAttributeName: [UIColor redColor],
                                                                       };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            _unselectedTitleAttributes = @{
                                           UITextAttributeFont: [UIFont systemFontOfSize:15],
                                           UITextAttributeTextColor: [UIColor blackColor],
                                           };
            _selectedTitleAttributes = @{
                                           UITextAttributeFont: [UIFont systemFontOfSize:15],
                                           UITextAttributeTextColor: [UIColor redColor],
                                           };
#endif
        }
    
        [self setTitle:_title];
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (void)drawRect:(CGRect)rect
{
    CGSize frameSize = self.frame.size;
    CGSize titleSize = CGSizeZero;
    NSDictionary *titleAttributes = nil;
    
    if ([self isSelected]) {
        titleAttributes = [self selectedTitleAttributes];
        
        if (!titleAttributes) {
            titleAttributes = [self unselectedTitleAttributes];
        }
    } else {
        titleAttributes = [self unselectedTitleAttributes];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    // Draw title
        
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        titleSize = [_title boundingRectWithSize:CGSizeMake(frameSize.width, 20)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName: titleAttributes[NSFontAttributeName]}
                                         context:nil].size;
        
        CGContextSetFillColorWithColor(context, [titleAttributes[NSForegroundColorAttributeName] CGColor]);
        
        [_title drawInRect:CGRectMake(roundf(frameSize.width / 2 - titleSize.width / 2),
                                      roundf(frameSize.height / 2 - titleSize.height / 2),
                                      titleSize.width, titleSize.height)
            withAttributes:titleAttributes];
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        titleSize = [_title sizeWithFont:titleAttributes[UITextAttributeFont]
                       constrainedToSize:CGSizeMake(frameSize.width, 20)];
        CGContextSetFillColorWithColor(context, [titleAttributes[UITextAttributeTextColor] CGColor]);
        
        [_title drawInRect:CGRectMake(roundf(frameSize.width / 2 - titleSize.width / 2),
                                      roundf(frameSize.height / 2 - titleSize.height / 2),
                                      titleSize.width, titleSize.height)
                  withFont:titleAttributes[UITextAttributeFont]
             lineBreakMode:NSLineBreakByTruncatingTail];
#endif
    }
    
    CGContextRestoreGState(context);
}

@end
