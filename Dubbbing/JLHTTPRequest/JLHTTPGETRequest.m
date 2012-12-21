//
//  JLHTTPGETRequest.m
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "JLHTTPGETRequest.h"

@implementation JLHTTPGETRequest

- (NSURLRequest *)URLRequest
{
	NSString *paramString = @"";
	if( params )
	{
		for( id key in params )
		{
			if( paramString.length > 0 )
				paramString = [paramString stringByAppendingFormat:@"&"];
			paramString = [paramString stringByAppendingFormat:@"%@=%@", key, [params objectForKey:key]];
		}
		
		paramString = [paramString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	
	return [[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingFormat:@"?%@", paramString]]] retain];
}

@end
