//
//  ViewController.m
//  ControlFun
//
//  Created by Leo Peng on 6/1/16.
//  Copyright © 2016 Leo Peng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UIButton *doSomethingButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sliderLabel.text = @"50";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

- (IBAction)sliderChanged:(UISlider *)sender {
    int progress = (int)lroundf(sender.value * 100);
    //NSLog(@"%d", progress);
    self.sliderLabel.text = [NSString stringWithFormat:@"%d", progress];
}

- (IBAction)switchChanged:(UISwitch *)sender {
    BOOL setting = sender.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}

- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.leftSwitch.hidden = NO;
        self.rightSwitch.hidden = NO;
        self.doSomethingButton.hidden = YES;
    } else {
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
        self.doSomethingButton.hidden = NO;
    }
}

- (IBAction)buttonPressed:(UIButton *)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes, I'm sure!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *msg;
        if ([self.nameField.text length] > 0) {
            msg = [NSString stringWithFormat:@"You can breathe easy, %@, everything went OK.", self.nameField.text];
        } else {
            msg = @"You can breathe easy, everything went OK.";
        }
        
        UIAlertController *controller2 = [UIAlertController alertControllerWithTitle:@"Something Was Done" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Phew!" style:UIAlertActionStyleCancel handler:nil];
        [controller2 addAction:cancelAction];
        [self presentViewController:controller2 animated:YES completion:nil];
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No way!" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:yesAction];
    [controller addAction:noAction];
    
    UIPopoverPresentationController *ppc = controller.popoverPresentationController;
    if (ppc != nil) {
        ppc.sourceView = sender;
        ppc.sourceRect = sender.bounds;
    }
    [self presentViewController:controller animated:YES completion:nil];
}

@end
