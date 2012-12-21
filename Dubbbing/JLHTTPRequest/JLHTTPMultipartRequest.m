//
//  JLHTTPMultipartRequest.m
//  Fanpple-iPhone
//
//  Created by 전수열 on 12. 12. 14..
//  Copyright (c) 2012년 전수열. All rights reserved.
//

#import "JLHTTPMultipartRequest.h"

@implementation JLHTTPMultipartRequest

- (NSURLRequest *)URLRequest
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:method];
	
	NSMutableData *body = [NSMutableData data];
	
	NSString *boundary = @"---------------------------14737809831466499882746641449";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
	
	for( id key in params )
	{
		id object = [params objectForKey:key];
		
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
		
		if( [object isKindOfClass:[NSString class]] )
		{
			[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@", key, object] dataUsingEncoding:NSUTF8StringEncoding]];
		}
		else if( [object isKindOfClass:[NSNumber class]] )
		{
			[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:[[NSString stringWithFormat:@"%@", object] dataUsingEncoding:NSUTF8StringEncoding]];
		}
		else if( [object isKindOfClass:[UIImage class]] )
		{
			[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n", key, key] dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:UIImageJPEGRepresentation( object, 1.0 )];
		}
		else
		{
			NSLog( @"[JLHTTPMultipartRequest URLRequest] other class : %@=%@", key, [object class] );
		}
	}
	
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
    [request setHTTPBody:body];
	
	return request;
}

@end
