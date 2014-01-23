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


- (void)textToTorchFromArray:(NSArray *)morseArray withStringEquivalent:(NSString *)string
{
    self.operationQueue = [NSOperationQueue new];
    self.operationQueue.maxConcurrentOperationCount = 1;
    
    //Parse array of morse words, grabbing one letter (e.g. ..--) at a time
    for (int i = 0; i < [morseArray count]; i++) {
        
        __block HISTorchController *weakSelf = self;
        [self.operationQueue addOperationWithBlock:^{
            
            NSString *morseString = morseArray[i];
            
            //Gets the letter from the morse code for UI display
            NSString *morseAlphaNumEquiv = [string substringWithRange:NSMakeRange(i, 1)];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [weakSelf.delegate morseBeingTorched:morseString];
                [weakSelf.delegate letterBeingTorched:morseAlphaNumEquiv];
//                [weakSelf.delegate incrementMessageLength:1];
            }];
            //takes each morse letter and seperates into individual . - or spaces
            for (int s = 0; s < morseString.length; s++) {
                if ([[morseString substringWithRange:NSMakeRange(s, 1)] isEqualToString:@"."]) {
                    [weakSelf shortFlash];
                } else if ([[morseString substringWithRange:NSMakeRange(s, 1)] isEqualToString:@"-"]) {
                    [weakSelf longFlash];
                } else {
                    [weakSelf waitBetweenWords];
                }
            }
        }];
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
    [self torchOn:device];
    usleep(600000);
    [self torchOff:device];
    usleep(200000);
}

- (void)shortFlash
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [self torchOn:device];
    usleep(200000);
    [self torchOff:device];
    usleep(200000);
}

- (void)waitBetweenWords
{
    [self.operationQueue addOperationWithBlock:^{
        usleep(1000000);
    }];
}

@end
