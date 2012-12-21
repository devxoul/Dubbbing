//
//  AudioInfo.m
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import "AudioInfo.h"

@implementation AudioInfo
@synthesize audioURL;
@synthesize audioStartTime;

-(id) initWithAudioURL:(NSURL*)url startTime:(CMTime)startTime
{
    self = [super init];
    if( self )
    {
        audioURL = [url retain];
        audioStartTime = startTime;
    }
    
    return self;
}

@end
