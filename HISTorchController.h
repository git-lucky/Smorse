//
//  HISTorchController.h
//  Smorse
//
//  Created by Tim Hise on 1/21/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@interface HISTorchController : NSObject

- (void)torchOn:(AVCaptureDevice *)device;
- (void)textToTorchFromArray:(NSArray *)tempArray;


@end
