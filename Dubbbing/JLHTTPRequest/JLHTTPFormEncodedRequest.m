//
//  JLHTTPPOSTRequest.m
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "JLHTTPFormEncodedRequest.h"

@implementation JLHTTPFormEncodedRequest

- (NSURLRequest *)URLRequest
{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:method];
	[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
	
	for( id key in params )
	{
		if( body.length > 0 )
			[body appendData:[@"&" dataUsingEncoding:NSUTF8StringEncoding]];
		
		NSString *value = [[params objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		value = [value stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
		[body appendData:[[NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], value] dataUsingEncoding:NSUTF8StringEncoding]];
	}
	
	[request setHTTPBody:body];
	
	return request;
}

@end
