//
//  NSString+MorseCode.m
//  Smorse
//
//  Created by Tim Hise on 1/20/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "NSString+MorseCode.h"

@implementation NSString (MorseCode)

+ (NSArray *)morseArrayFromString:(NSString *)string
{
    NSMutableArray *morseArray = [NSMutableArray new];
    
    NSArray *oldArray = [string removeInvalidCharsFromUppercaseString];
    for (int i = 0 ; i < [oldArray count] ; i++) {
        [morseArray addObject:[NSString replaceLetterWithMorse:oldArray[i]]];
    };
    
    return [NSArray arrayWithArray:morseArray];
}

- (NSArray *)removeInvalidCharsFromUppercaseString
{
    NSMutableArray *finalArray = [NSMutableArray new];
    
    NSString *upperCase = [self makeUppercase:self];
    NSArray *dictionaryKeysArray = [[NSString dictionaryWithMorseSymbols] allKeys];

    
    for (int i = 0; i < upperCase.length; i++) {
        NSString *tempString = [upperCase substringWithRange:NSMakeRange(i, 1)];
        
        if ([dictionaryKeysArray containsObject:tempString]) {
            [finalArray addObject:[upperCase substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    return [NSArray arrayWithArray:finalArray];
}

+ (NSString *)createStringIdenticalToMorse:(NSString *)string
{
    NSString *upperCaseString = [NSString stringWithString:[string makeUppercase:string]];
    NSArray *dictionaryKeysArray = [[NSString dictionaryWithMorseSymbols] allKeys];
    
    NSString *identToMorse = [NSString stringWithFormat:@""];
    
    
    for (int i = 0; i < upperCaseString.length; i++) {
        
        NSString *tempLetter = [upperCaseString substringWithRange:NSMakeRange(i, 1)];
        
        if ([dictionaryKeysArray containsObject:tempLetter]) {
            identToMorse = [identToMorse stringByAppendingString:tempLetter];
        }
    }
    
    NSLog(@"parsed string %@", identToMorse);
    
    return identToMorse;
}

- (NSString *)makeUppercase:(NSString *)string
{
    string = [string uppercaseString];
    return string;
}

+ (NSString *)replaceLetterWithMorse:(NSString *)letter
{
    NSDictionary *dict = [NSString dictionaryWithMorseSymbols];
    NSString *symbol = [dict objectForKey:letter];
    
    return symbol;
}

+ (NSDictionary *)dictionaryWithMorseSymbols
{
    NSDictionary *morseDictionary = [NSDictionary new];
    morseDictionary = @{@" ": @" ",
                        @"A": @".-",
                        @"B": @"-...",
                        @"C": @"-.-.",
                        @"D": @"-..",
                        @"E": @".",
                        @"F": @"..-.",
                        @"G": @"--.",
                        @"H": @"....",
                        @"I": @"..",
                        @"J": @".---",
                        @"K": @"-.-",
                        @"L": @".-..",
                        @"M": @"--",
                        @"N": @"-.",
                        @"O": @"---",
                        @"P": @".--.",
                        @"Q": @"--.-",
                        @"R": @".-.",
                        @"S": @"...",
                        @"T": @"-",
                        @"U": @"..-",
                        @"V": @"...-",
                        @"W": @".--",
                        @"X": @"-..-",
                        @"Y": @"-.--",
                        @"Z": @"--..",
                        @"0": @"-----",
                        @"1": @".----",
                        @"2": @"..---",
                        @"3": @"...--",
                        @"4": @"....-",
                        @"5": @".....",
                        @"6": @"-....",
                        @"7": @"--...",
                        @"8": @"---..",
                        @"9": @"----.",};
    
    return morseDictionary;
}

@end
