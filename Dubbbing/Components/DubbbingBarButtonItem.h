//
//  DishByMeBarButtonItem.h
//  I'm Traveling
//
//  Created by 전 수열 on 12. 3. 18..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DubbbingBarButtonItem : UIBarButtonItem
{
	UIButton *_button;
}

typedef enum {
	DubbbingBarButtonItemTypeNormal = 0,
	DubbbingBarButtonItemTypeBack = 1
} DubbbingBarButtonItemType;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) CGRect frame;

- (id)initWithType:(NSInteger)type title:(NSString *)title target:(id)target action:(SEL)action;

- (UIImage *)imageForState:(UIControlState)state;
- (void)setImage:(UIImage *)image forState:(UIControlState)state;

@end
