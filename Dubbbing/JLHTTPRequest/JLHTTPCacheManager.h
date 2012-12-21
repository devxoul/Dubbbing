//
//  JLHTTPCacheManager.h
//  Fanpple-iPhone
//
//  Created by 전수열 on 12. 12. 18..
//  Copyright (c) 2012년 전수열. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLHTTPCacheManager : NSObject
{
	NSMutableDictionary *_caches;
}

+ (id)manager;
- (void)cacheObject:(id)object forKey:(id<NSCopying>)key;
- (id)cachedObjectForKey:(id<NSCopying>)key;

@end
