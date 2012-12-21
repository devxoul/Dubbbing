//
//  JLHTTPLoader.h
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLHTTPRequest.h"
#import "JLHTTPGETRequest.h"
#import "JLHTTPFormEncodedRequest.h"
#import "JLHTTPMultipartRequest.h"
#import "JLHTTPResponse.h"

@protocol JLHTTPLoaderDelegate;

@interface JLHTTPLoader : NSObject
{
	id<JLHTTPLoaderDelegate> delegate;
	NSMutableArray *queue;
	BOOL loading;
	
	NSInteger statusCode;
	NSDictionary *responseHeader;
	NSMutableData *responseData;
}

@property (retain, nonatomic) id<JLHTTPLoaderDelegate> delegate;
@property (retain, nonatomic, getter = currentRequest) JLHTTPRequest *currentRequest;

- (void)addRequest:(JLHTTPRequest *)request;
- (void)startLoading;
- (BOOL)hasRequestId:(NSInteger)requestId;

- (JLHTTPRequest *)currentRequest;

+ (void)loadAsyncFromURL:(NSString *)url completion:(void (^)(NSData *data))completion;

@end



@protocol JLHTTPLoaderDelegate

//@optional
//- (BOOL)shouldLoadWithToken:(JLHTTPRequest *)token;

@required
- (void)loaderDidFinishLoading:(JLHTTPResponse *)response;

@end