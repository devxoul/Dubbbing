//
//  Post.h
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
{
	NSString *thumbnailURL;
	NSString *videoURL;
	NSString *description;
	
	UIImage *thumbnail;
}

@property (nonatomic, retain) NSString *thumbnailURL;
@property (nonatomic, retain) NSString *videoURL;
@property (nonatomic, retain) NSString *description;

@property (nonatomic, retain) UIImage *thumbnail;

@end
