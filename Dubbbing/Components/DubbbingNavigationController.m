//
//  DishByMeNavigationController.m
//  Dish by.me
//
//  Created by 전 수열 on 12. 9. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "DubbbingNavigationController.h"


@implementation DubbbingNavigationController

- (id)initWithRootViewController:rootViewController
{
	self = [super initWithRootViewController:rootViewController];
	
	[self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
	[self.navigationBar setBackgroundImage:[[UIImage imageNamed:@"navigation_bar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake( 0, 5, 0, 5 )] forBarMetrics:UIBarMetricsLandscapePhone];
	
	return self;
}

@end
