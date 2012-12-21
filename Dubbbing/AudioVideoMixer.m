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


//Export function to export the combined audios as one.
-(void)exportAudioFile
{
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:self.composition
                                                                           presetName:AVAssetExportPresetPassthrough];
    NSArray *presets =[AVAssetExportSession exportPresetsCompatibleWithAsset:self.composition];
    NSLog(@"presets======%@",presets);
    NSLog (@"can export: %@", exportSession.supportedFileTypes);
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [dirs objectAtIndex:0];
    
    NSString* exportPath = [documentsDirectoryPath stringByAppendingPathComponent:@"CombinedNew.mov"];
    
    [[NSFileManager defaultManager] removeItemAtPath:exportPath error:nil];
    NSURL* exportURL = [NSURL fileURLWithPath:exportPath];
    
    exportSession.outputURL = exportURL;
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
    exportSession.shouldOptimizeForNetworkUse = YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        NSLog (@"i is in your block, exportin. status is %d", exportSession.status);
        switch (exportSession.status)
        {
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"AVAssetExportSessionStatusCompleted");
                NSLog(@"Completed export");
                
                
                NSLog(@"exportURL %@", exportURL);
                
                // Export URL으로 빠집니다.
                // 여기서 전달해 주면 될 듯 다음 뷰로.
                
                break;
            }

            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = exportSession.error;
                NSLog(@"AVAssetExportSessionStatusFailed: %@", exportError.description);
                break;
            }
            case AVAssetExportSessionStatusUnknown:
            {
                NSLog(@"AVAssetExportSessionStatusUnknown");
                break;
            }
            case AVAssetExportSessionStatusExporting:
            {
                NSLog(@"AVAssetExportSessionStatusExporting");
                break;
            }
            case AVAssetExportSessionStatusCancelled:
            {
                NSLog(@"AVAssetExportSessionStatusCancelled");
                break;
            }
            case AVAssetExportSessionStatusWaiting:
            {
                NSLog(@"AVAssetExportSessionStatusWaiting");
                break;
            }
            default:
            {
                NSLog(@"didn't get export status");
                break;
            }
                
        };
    }];
    [exportSession release];
}

@end
