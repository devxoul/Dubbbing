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
	
	UIImage *thumbnail;
	NSString *title;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIImage *thumbnail;

@property (nonatomic, retain) NSString *thumbnailURL;
@property (nonatomic, retain) NSString *videoURL;

+ (Post *)postFromDictionary:(NSDictionary *)dictionary;

@end
