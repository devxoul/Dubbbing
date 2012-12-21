//
//  Post.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "Post.h"
#import "Const.h"

@implementation Post

@synthesize thumbnail, title, thumbnailURL, videoURL;

+ (Post *)postFromDictionary:(NSDictionary *)dictionary
{
	Post *post = [[Post alloc] init];
	post.videoURL = [NSString stringWithFormat:@"%@%@", URL_MEDIA_ROOT, [dictionary objectForKey:@"video_url"]];
	post.thumbnailURL = [NSString stringWithFormat:@"%@%@", URL_MEDIA_ROOT, [dictionary objectForKey:@"thumbnail_url"]];
	post.title = [dictionary objectForKey:@"title"];
	return post;
}

@end
