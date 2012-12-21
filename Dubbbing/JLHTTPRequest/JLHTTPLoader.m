//
//  JLHTTPLoader.m
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "JLHTTPLoader.h"
#import "JLHTTPRequest.h"
#import "JLHTTPResponse.h"
#import "JLHTTPCacheManager.h"

@implementation JLHTTPLoader

@synthesize delegate;

- (id)init
{
	self = [super init];
	
	queue = [[NSMutableArray alloc] init];
	responseData = [[NSMutableData alloc] init];
	
	return self;
}

- (void)addRequest:(JLHTTPRequest *)request
{
	[queue addObject:request];
}

- (void)startLoading
{
	if( loading || queue.count == 0 ) return;

	JLHTTPRequest *request = [queue objectAtIndex:0];
	[[[NSURLConnection alloc] initWithRequest:request.URLRequest delegate:self] autorelease];
	[request release];
	loading = YES;
}

- (BOOL)hasRequestId:(NSInteger)requestId
{
	for( JLHTTPRequest *req in queue )
		if( req.requestId == requestId )
			return YES;
	return NO;
}

- (JLHTTPRequest *)currentRequest
{
	if( queue.count == 0 ) return nil;
	return [queue objectAtIndex:0];
}


#pragma mark -
#pragma mark NSURLConnection

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)useCredential:(NSURLCredential *)credential forAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}

- (void)continueWithoutCredentialForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}

- (void)cancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	statusCode = httpResponse.statusCode;
	responseHeader = [httpResponse.allHeaderFields retain];
	responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if( queue.count == 0 )
	{
		NSLog( @"Loading queue is empty!" );
		return;
	}
	
	loading = NO;
	
	JLHTTPRequest *request = [[queue objectAtIndex:0] retain];
	[queue removeObjectAtIndex:0];
	
	JLHTTPResponse *response = [[JLHTTPResponse alloc] init];
	response.requestId = request.requestId;
	response.statusCode = statusCode;
	response.headers = responseHeader;
	response.body = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[request release];
	
	statusCode = 0;
	responseHeader = nil;
	[responseHeader release];
	
	[delegate loaderDidFinishLoading:response];
	
	if( queue.count > 0 )
		[self startLoading];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog( @"Loading Error : %@", error );
//	loading = NO;
}


#pragma mark -
#pragma mark Async

+ (void)loadAsyncFromURL:(NSString *)url completion:(void (^)(NSData *data))completion
{
	dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0 ), ^{
		id cachedData = [[JLHTTPCacheManager manager] cachedObjectForKey:url];
		if( cachedData )
		{
			dispatch_async( dispatch_get_main_queue(), ^{
				completion( cachedData );
			} );
			return;
		}
		
		NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
		[[JLHTTPCacheManager manager] cacheObject:data forKey:url];
		
		dispatch_async( dispatch_get_main_queue(), ^{
			completion( data );
		} );
	} );
}

@end
