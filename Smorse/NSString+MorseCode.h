//
//  NSString+MorseCode.h
//  Smorse
//
//  Created by Tim Hise on 1/20/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MorseCode)

+ (NSDictionary *)dictionaryWithMorseSymbols;

+ (NSArray *)morseArrayFromString:(NSString *)string;

+ (NSString *)createStringIdenticalToMorse:(NSString *)string;

@end
