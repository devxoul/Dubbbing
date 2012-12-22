//
//  AudioVideoMixer.h
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioInfo.h"

@protocol AudioVideoMixerDelegate

- (void)mixerDidFinishMixingWithURL:(NSURL *)url;

@end


@interface AudioVideoMixer : NSObject
{
	id<AudioVideoMixerDelegate> delegate;
}

@property (nonatomic, retain) id<AudioVideoMixerDelegate> delegate;
@property (nonatomic, strong) AVMutableComposition* composition;


-(void) mixVideoURL:(NSURL*)videoURL audioInfoList:(NSMutableArray*)audioInfoList;

-(void)exportAudioFile;

@end
