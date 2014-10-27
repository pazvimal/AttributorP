//
//  AttributorPViewController.m
//  AttributorP
//
//  Created by Paz Patel on 10/26/14.
//  Copyright (c) 2014 Paz Patel. All rights reserved.
//

#import "AttributorPViewController.h"

@interface AttributorPViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorPViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title =
        [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{NSStrokeWidthAttributeName:@3,
                           NSStrokeColorAttributeName: self.outlineButton.tintColor}
                   range:NSMakeRange(0, [title length])];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:<#animated#>];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

-(void)preferredFontChanged:(NSNotification *)notification{
    [self usePreferredFonts];
}

-(void)usePreferredFonts{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

-(void)viewWillDiappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor range:self.body.selectedRange];
}


- (IBAction)outlineBodySelection {
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName:@-3,
                                           NSStrokeColorAttributeName: [UIColor blueColor]} range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}






@end
