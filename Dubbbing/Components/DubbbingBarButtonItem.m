//
//  DishByMeBarButtonItem.m
//  I'm Traveling
//
//  Created by 전 수열 on 12. 3. 18..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "DubbbingBarButtonItem.h"

@implementation DubbbingBarButtonItem

- (id)initWithType:(NSInteger)type title:(NSString *)title target:(id)target action:(SEL)action
{
	_button = [UIButton buttonWithType:UIButtonTypeCustom];
	_button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
	_button.titleLabel.shadowOffset = CGSizeMake( 0, -1 );
	[_button setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.3] forState:UIControlStateNormal];
	[_button setTitle:title forState:UIControlStateNormal];
	
	UIImage *bg;
	switch( type )
	{
		case DubbbingBarButtonItemTypeNormal:
			bg = [[UIImage imageNamed:@"navigation_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake( 4, 4, 4, 4 )];
			_button.frame = CGRectMake( 0, 0, 60, 30 );
			_button.titleEdgeInsets = UIEdgeInsetsMake( -1, 0, 0, 0 );
			_button.imageEdgeInsets = UIEdgeInsetsMake( 0, 2, 0, 0 );
			break;
			
		case DubbbingBarButtonItemTypeBack:
			bg = [UIImage imageNamed:@"navigation_bar_button_back.png"];
			_button.frame = CGRectMake( 0, 0, 60, 30 );
			_button.titleEdgeInsets = UIEdgeInsetsMake( -1, 8, 0, 0 );
			break;
	}
	
	[_button setBackgroundImage:bg forState:UIControlStateNormal];
	[_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	
	return [super initWithCustomView:_button];
}


#pragma mark -
#pragma mark Getter/Setter

- (NSString *)title
{
	return [_button titleForState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title
{
	[_button setTitle:title forState:UIControlStateNormal];
}


- (UIImage *)imageForState:(UIControlState)state
{
	return [_button imageForState:state];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
	[_button setImage:image forState:state];
}


- (CGRect)frame
{
	return _button.frame;
}

- (void)setFrame:(CGRect)frame
{
	_button.frame = frame;
}

@end
