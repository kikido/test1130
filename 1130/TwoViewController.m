//
//  TwoViewController.m
//  1130
//
//  Created by dqh on 2018/11/1.
//  Copyright © 2018 juesheng. All rights reserved.
//

#import "TwoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <YYModel.h>


#define SY_DocumentVideo_Path [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/jsvideo"]

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(130, 130, 100, 100)];
    back.backgroundColor = [UIColor greenColor];
    [back addTarget:self action:@selector(begin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    // Do any additional setup after loading the view.
    
    NSDictionary *dict = @{
                           @"name" : @"ceshi",
                           @"age"  : @"2.3.4",
                           @"count" : @2.2
                           };
    NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    People *pp = [People yy_modelWithJSON:json];
    
    NSLog(@"kk");
}

- (void)test
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *a = @[];
        NSLog(@"%@",a[3]);
    });
}

- (void)begin
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self one];
}

+ (void)load
{
    BOOL isDic;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:SY_DocumentVideo_Path isDirectory:&isDic]) {
        [fileManager createDirectoryAtPath:SY_DocumentVideo_Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)one
{
    
//    NSURL *fromUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/20181031163040.mp4"]];
    NSURL *fromUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"20181031163040" ofType:@"mp4"]];
    AVAsset *asset = [AVAsset assetWithURL:fromUrl];
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    
    // 创建导出的url
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
    NSURL *toUrl = [NSURL fileURLWithPath:[SY_DocumentVideo_Path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",now]]];
    
    session.outputURL = toUrl;
    // 必须配置输出属性
    session.outputFileType = AVFileTypeMPEG4;
    session.shouldOptimizeForNetworkUse = YES;
    //对视频的方向进行调整
    session.videoComposition = [self getVideoComposition:asset];
    
    NSLog(@"保存地址 %@", toUrl);
    NSLog(@"正在导出视频...");
    
    // 导出视频
    [session exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (session.status == AVAssetExportSessionStatusCompleted) {
                // 转换成功
                NSLog(@"视频导出完成");
                
                long long size = [self getFileSize:toUrl.path];
                NSLog(@"size = %lld",size);
            } else {
                // 转换不成功
                NSLog(@"压缩保存失败");
            }
        });
    }];
}

- (AVMutableVideoComposition *)getVideoComposition:(AVAsset *)asset {
    NSArray *array = [asset tracksWithMediaType:AVMediaTypeVideo];
    if (array.count == 0) {
        return nil;
    }
    
    AVAssetTrack *videoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    AVMutableComposition *composition = [AVMutableComposition composition];
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    CGSize videoSize = videoTrack.naturalSize;
    
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        if((t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0) ||
           (t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0)){
            videoSize = CGSizeMake(videoSize.height, videoSize.width);
        }
    }
    composition.naturalSize    = videoSize;
    videoComposition.renderSize = videoSize;
    videoComposition.frameDuration = CMTimeMakeWithSeconds( 1 / videoTrack.nominalFrameRate, 600);
    
    AVMutableCompositionTrack *compositionVideoTrack;
    compositionVideoTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration) ofTrack:videoTrack atTime:kCMTimeZero error:nil];
    AVMutableVideoCompositionLayerInstruction *layerInst;
    layerInst = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    [layerInst setTransform:videoTrack.preferredTransform atTime:kCMTimeZero];
    AVMutableVideoCompositionInstruction *inst = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    inst.timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
    inst.layerInstructions = [NSArray arrayWithObject:layerInst];
    videoComposition.instructions = [NSArray arrayWithObject:inst];
    return videoComposition;
}

- (long long)getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init] ;
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = fileDic.fileSize;
        filesize = 1*size;
    }
    return filesize;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation People
@end
