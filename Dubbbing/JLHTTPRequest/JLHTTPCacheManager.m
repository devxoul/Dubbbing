//
//  JLHTTPCacheManager.m
//  Fanpple-iPhone
//
//  Created by 전수열 on 12. 12. 18..
//  Copyright (c) 2012년 전수열. All rights reserved.
//

#import "JLHTTPCacheManager.h"

@implementation JLHTTPCacheManager

+ (id)manager
{
	static id manager;
	
	if( !manager )
	{
		manager = [[JLHTTPCacheManager alloc] init];
	}
	
	return manager;
}

- (id)init
{
	self = [super init];
	
	_caches = [[NSMutableDictionary alloc] init];
	
	return self;
}

- (void)cacheObject:(id)object forKey:(id<NSCopying>)key
{
	if( !object ) return;
	[_caches setObject:object forKey:key];
}

- (id)cachedObjectForKey:(id<NSCopying>)key
{
	return [_caches objectForKey:key];
}

@end
