//
//  HISTorchController.m
//  Smorse
//
//  Created by Tim Hise on 1/21/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "HISTorchController.h"
#import "NSString+MorseCode.h"

@interface HISTorchController ()
@property NSUInteger torchDuration;
@property (strong, nonatomic) NSOperationQueue *operationQueue;
@end

@implementation HISTorchController

#pragma mark - Torch


- (void)textToTorchFromArray:(NSArray *)tempArray
{
    self.operationQueue = [NSOperationQueue new];
    self.operationQueue.maxConcurrentOperationCount = 1;
    for (int i = 0; i < [tempArray count]; i++) {
        NSString *tempString = tempArray[i];
        for (int s = 0; s < tempString.length; s++) {
            if ([[tempString substringWithRange:NSMakeRange(s, 1)] isEqualToString:@"."]) {
                [self shortFlash];
            } else if ([[tempString substringWithRange:NSMakeRange(s, 1)] isEqualToString:@"-"]) {
                [self longFlash];
            } else {
                [self waitBetweenWords];
            }
        }
        NSLog(@"%@", tempString);
    }
}

- (void)torchOn:(AVCaptureDevice *)device
{
    if ([device hasFlash] && [device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchModeOnWithLevel:.5f error:nil];
        device.torchMode = AVCaptureTorchModeOn;
        device.flashMode = AVCaptureFlashModeOn;
        [device unlockForConfiguration];
    }
}

- (void)torchOff:(AVCaptureDevice *)device
{
    if ([device hasTorch] && [device hasFlash]) {
        [device lockForConfiguration:nil];
        device.torchMode = AVCaptureTorchModeOff;
        device.torchMode = AVCaptureFlashModeOff;
        [device unlockForConfiguration];
    }
}

- (void)longFlash
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    __block HISTorchController *weakSelf = self;
    [self.operationQueue addOperationWithBlock:^{
        [weakSelf torchOn:device];
        usleep(600000);
        [weakSelf torchOff:device];
        usleep(200000);
    }];
}

- (void)shortFlash
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    __block HISTorchController *weakSelf = self;
    [self.operationQueue addOperationWithBlock:^{
        [weakSelf torchOn:device];
        usleep(200000);
        [weakSelf torchOff:device];
        usleep(200000);
    }];
}

- (void)waitBetweenWords
{
    [self.operationQueue addOperationWithBlock:^{
        usleep(1000000);
    }];
}

@end
