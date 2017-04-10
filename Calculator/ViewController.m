//
//  ViewController.m
//  Calculator
//
//  Created by Arkadijs Makarenko on 17/03/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;//1.
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *calculatorButtons;
@property (strong, nonatomic) NSString *currentOperator;//store +/-/x/÷
@property (assign, nonatomic) double savedValue;
@property (assign, nonatomic) BOOL operatorPressed;//3.
@property (strong, nonatomic) NSNumberFormatter *formatter;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.calculatorButtons objectAtIndex:0];
    //self.calculatorButtons[0];
    for(UIButton *button in self.calculatorButtons){
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [[button layer] setBorderWidth:0.5f];
        [[button layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    }
    
    
    self.formatter = [[NSNumberFormatter alloc] init];
    self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    self.formatter.maximumFractionDigits = 10;
}
- (void)buttonPressed:(UIButton *)sender{//2.
    NSString *buttonText = sender.titleLabel.text;
    NSArray *numberStrings = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    
    NSArray *operatorString = @[@"+",@"-",@"x",@"÷"];
    //number press
    if([numberStrings containsObject:buttonText]){
        //self.label.text = @"";
        //operator pressed 3.
        if (self.operatorPressed) {
            self.label.text = buttonText;
            self.operatorPressed = NO;
            //calculate
            //update text
            return;
        }
        if ([self.label.text isEqualToString:@"0"]){
            self.label.text = buttonText;
        }else{
            self.label.text=[NSString stringWithFormat:@"%@%@", self.label.text, buttonText];
        }
        //. press
    }else if ([buttonText isEqualToString:@"."]){
        if ([self.label.text rangeOfString:@"."].location< self.label.text.length) {
            return;
        }
        self.label.text = [NSString stringWithFormat:@"%@%@", self.label.text, buttonText];
        //AC press
    }else if ([buttonText isEqualToString:@"AC"]){
        self.label.text = @"0";
        self.operatorPressed =NO;
        self.operatorPressed = 0.0;
        self.currentOperator = @"";
        //operator press
    }else if ([operatorString containsObject:buttonText]){
        [self calculate];//do operation
        self.savedValue = [self.label.text doubleValue];//store previos value
        self.currentOperator = buttonText;//store the current operator
        self.operatorPressed = YES;
        //= press
    }else if ([buttonText isEqualToString:@"="]){
        [self calculate];
        self.currentOperator = @"";
        //calculate
        //update
        //% press
    }else if ([buttonText isEqualToString:@"%"]){
        double percentageValue = [self.label.text doubleValue]/100;
        self.label.text = [self.formatter stringFromNumber:[NSNumber numberWithDouble:percentageValue]];
        //get the %

    }else{
        //+/-
        double minValue = -[self.label.text doubleValue];
        self.label.text = [self.formatter stringFromNumber:[NSNumber numberWithDouble:minValue]];
        //convert to - value if positive and vice verce
    }
}

-(void)calculate{
    double result;
    double currentValue = [self.label.text doubleValue];
    
    if ([self.currentOperator isEqualToString:@"+"]) {
        result =self.savedValue + currentValue;
    }else if([self.currentOperator isEqualToString:@"-"]){
        result =self.savedValue - currentValue;
    }else if([self.currentOperator isEqualToString:@"x"]){
        result =self.savedValue * currentValue;
    }else if([self.currentOperator isEqualToString:@"÷"]){
        result =self.savedValue / currentValue;
    }else{
        return;
    }
    self.label.text = [self.formatter stringFromNumber:[NSNumber numberWithDouble:result]];
}


@end
