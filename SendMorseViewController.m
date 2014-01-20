//
//  SendMorseViewController.m
//  Smorse
//
//  Created by Tim Hise on 1/20/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "SendMorseViewController.h"
#import "NSString+MorseCode.h"

@interface SendMorseViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (strong, nonatomic) NSString *messageToMorse;
@end

@implementation SendMorseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelagate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.messageToMorse = self.messageField.text;
    NSArray *tempArray = [NSString morseFromString:self.messageToMorse];
    NSLog(@"%@", tempArray);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
