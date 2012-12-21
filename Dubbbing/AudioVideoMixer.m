//
//  AudioVideoMixer.m
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import "AudioVideoMixer.h"

@implementation AudioVideoMixer
@synthesize composition;

-(void) mixVideoURL:(NSURL*)videoURL audioInfoList:(NSMutableArray*)audioInfoList
{
    composition = [AVMutableComposition composition];
    
    AVURLAsset* movieAsset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVMutableCompositionTrack* movieTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                      preferredTrackID:kCMPersistentTrackID_Invalid];
    
    NSLog(@"duration:%lld ", movieAsset.duration.value);
    
    NSError* error;
    if(![movieTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, movieAsset.duration)
                            ofTrack:[[movieAsset tracksWithMediaType:AVMediaTypeVideo]objectAtIndex:0]
                             atTime:kCMTimeZero
                              error:&error])
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    // Insert the audio tracks into our composition
    for (AudioInfo* trackInfo in audioInfoList)
    {
        AVURLAsset* audioAsset = [[AVURLAsset alloc] initWithURL:trackInfo.audioURL options:nil];
        
        AVMutableCompositionTrack* audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                          preferredTrackID:kCMPersistentTrackID_Invalid];
        NSLog(@"timescale%d",trackInfo.audioStartTime.timescale);
        NSError* error;
        
        if(![audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration)
                                ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio]objectAtIndex:0]
                                 atTime:CMTimeConvertScale(trackInfo.audioStartTime, audioAsset.duration.timescale, kCMTimeRoundingMethod_Default)
                                  error:&error])
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

@end
