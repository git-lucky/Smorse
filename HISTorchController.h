//
//  HISTorchController.h
//  Smorse
//
//  Created by Tim Hise on 1/21/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@protocol TorchControllerDelegate <NSObject>

- (void)letterBeingTorched:(NSString *)letter;
- (void)morseBeingTorched:(NSString *)morse;
//- (void)totalMessageLength:(NSUInteger)num;
//- (void)incrementMessageLength:(NSUInteger)num;

@end

@interface HISTorchController : NSObject

- (void)torchOn:(AVCaptureDevice *)device;
- (void)textToTorchFromArray:(NSArray *)morseArray withStringEquivalent:(NSString *)string;

@property (unsafe_unretained) id <TorchControllerDelegate> delegate;

@end
