//
//  SendMorseViewController.m
//  Smorse
//
//  Created by Tim Hise on 1/20/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "SendMorseViewController.h"
#import "NSString+MorseCode.h"
@import AVFoundation;
#import "HISTorchController.h"

@interface SendMorseViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (strong, nonatomic) NSString *messageToMorse;
@property (weak, nonatomic) IBOutlet UITextView *textViewOutlet;
@property (strong, nonatomic) HISTorchController *torchController;

@end

@implementation SendMorseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.sendButton setEnabled:NO];
    self.torchController = [HISTorchController new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction


- (IBAction)sendButton:(id)sender {
    NSArray *tempArray = [NSString morseArrayFromString:self.messageToMorse];
    [self.torchController textToTorchFromArray:tempArray];
    self.textViewOutlet.text = [NSString stringWithFormat:@"Input: %@ \nMorse: %@", self.messageToMorse, tempArray];
    self.sendButton.enabled = NO;
}

- (IBAction)editingChanged:(id)sender {
    if ([self.messageField.text length]) {
        self.sendButton.enabled = YES;
    }
    else {
        self.sendButton.enabled = NO;
    }
}


#pragma mark - UITextFieldDelagate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.messageToMorse = self.messageField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
