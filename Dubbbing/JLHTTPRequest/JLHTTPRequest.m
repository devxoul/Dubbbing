//
//  JLHTTPRequest.m
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "JLHTTPRequest.h"

@implementation JLHTTPRequest

@synthesize requestId, url, method;

- (id)init
{
	self = [super init];
	
	
	
	return self;
}

- (void)setParam:(id)value forKey:(id<NSCopying>)key
{
	if( !params )
		params = [[NSMutableDictionary alloc] init];
	[params setObject:value forKey:key];
}

- (NSURLRequest *)URLRequest
{
	return nil;
}

@end
