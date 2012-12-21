//
//  AudioRecorder.m
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import "AudioInfo.h"
#import "AudioRecorder.h"

@implementation AudioRecorder

//@synthesize audioRecorder;
@synthesize audioRecorderList;
@synthesize audioInfoList;

- (id)init
{
    self = [super init];
    if( self ) {
        
        audioInfoList = [[NSMutableArray alloc] init];
        audioRecorderList = [[NSMutableArray alloc] init];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        NSError *err = nil;
        [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
        if(err){
            NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        }
        err = nil;
        [audioSession setActive:YES error:&err];
        if(err){
            NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        }
        
    }
    
    return self;
}

-(void) recordAudioWithStartTime:(CMTime)startTime
{
    NSArray *dirPaths;
    NSString *docsDir;
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString* soundFileName = [NSString stringWithFormat:@"sound%d.caf", self.audioRecorderList.count];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:soundFileName];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    AVAudioRecorder* audioRecorder = [[AVAudioRecorder alloc]
                                      initWithURL:soundFileURL
                                      settings:recordSettings
                                      error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
        
    } else {
        [audioRecorder prepareToRecord];
    }
    
    [self.audioRecorderList addObject:[audioRecorder retain]];

    
    AudioInfo* newAudioInfo = [[AudioInfo alloc] initWithAudioURL:soundFileURL startTime:startTime];
    [audioInfoList addObject:newAudioInfo];
    
    NSLog(@"index:%d", [audioInfoList indexOfObject:newAudioInfo]);
    
    if (!audioRecorder.recording)
    {
        BOOL result = [audioRecorder record];
        NSLog(@"recording result : %d", result);
        if( audioRecorder.recording )
        {
            NSLog(@"recording");
        }
    }
}

-(void)stop
{
    NSLog(@"%d", self.audioRecorderList.count-1);
    AVAudioRecorder* audioRecorder = [self.audioRecorderList objectAtIndex:self.audioRecorderList.count-1];
    
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
    }
}
                                      
-(void)audioRecorderDidFinishRecording:
(AVAudioRecorder *)recorder
                          successfully:(BOOL)flag
{
}

-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}

- (void)dealloc {
    [audioInfoList release];
    [audioRecorderList release];
    [super dealloc];
}


@end
