//
//  SendMorseViewController.m
//  Smorse
//
//  Created by Tim Hise on 1/20/14.
//  Copyright (c) 2014 GelRock. All rights reserved.
//

#import "SendMorseViewController.h"
#import "NSString+MorseCode.h"
#import "HISTorchController.h"
#import <M13ProgressSuite/M13ProgressViewBorderedBar.h>
@import AVFoundation;

@interface SendMorseViewController () <UITextFieldDelegate,TorchControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *alphaNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *morseLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (strong, nonatomic) NSString *messageToMorse;
@property (strong, nonatomic) HISTorchController *torchController;
@property (strong, nonatomic) M13ProgressViewBorderedBar *progressBar;
@property (nonatomic) CGFloat totalMessageLength;
@property (nonatomic) CGFloat currentMessageLength;

@end

@implementation SendMorseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.sendButton setEnabled:NO];
    
    self.torchController = [HISTorchController new];
    self.torchController.delegate = self;
    
    self.progressBar = [[M13ProgressViewBorderedBar alloc] initWithFrame:CGRectMake(0, 0, 250, 50)];
    self.progressBar.cornerType = M13ProgressViewBorderedBarCornerTypeCircle;
    self.progressBar.center = self.view.center;
    [self.view addSubview:self.progressBar];
    [self.progressBar setHidden:YES];
    
    self.currentMessageLength = 0.f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction


- (IBAction)sendButton:(id)sender {
    
    self.messageToMorse = self.messageField.text;
    
    [self.messageField resignFirstResponder];
    
    [self.progressBar setHidden:NO];
    
    NSArray *morseArray = [NSString morseArrayFromString:self.messageToMorse];
    NSString *morseArrayEquiv = [NSString createStringIdenticalToMorse:self.messageToMorse];
    NSLog(@"message length %lu", (unsigned long)morseArrayEquiv.length);
    
    self.totalMessageLength = (CGFloat)morseArrayEquiv.length;
    
    [self.torchController textToTorchFromArray:morseArray withStringEquivalent:morseArrayEquiv];
    
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

#pragma mark - Torch Delegate

// Use this method to populate label on the view showing the letter being torched
- (void)letterBeingTorched:(NSString *)letter
{
    self.alphaNumLabel.text = letter;
    self.currentMessageLength += 1.f;
    CGFloat num = (self.currentMessageLength/self.totalMessageLength);
    NSLog(@"num %f", num);
    [self.progressBar setProgress:num animated:YES];
}

- (void)morseBeingTorched:(NSString *)morse
{
    self.morseLabel.text = morse;
}

//- (void)incrementMessageLength:(NSUInteger)num
//{
//    self.currentMessageLength = (self.currentMessageLength + num);
//}

@end
