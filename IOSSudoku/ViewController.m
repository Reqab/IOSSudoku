//
//  ViewController.m
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 2/25/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "SudokuPuzzle.h"
#import "PuzzleView.h"
#import "ButtonView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ButtonView *buttonView;
@property (weak, nonatomic) IBOutlet PuzzleView *puzzleView;

@end

@implementation ViewController

- (IBAction)pencilPressed:(UIButton*)sender {
    _pencilEnabled = sender.selected = !_pencilEnabled;
    sender.highlighted = NO;
}

- (IBAction)numberButton:(UIButton *)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    SudokuPuzzle* puzzle = appDelegate.sudokuPuzzle;
    
    if(1 <= sender.tag && sender.tag <= 9 && self.puzzleView.selectedRow >=0 && self.puzzleView.selectedCol >= 0){
        if (self.pencilEnabled) {
            if ([puzzle isSetPencil:(int)sender.tag AtRow:(int)self.puzzleView.selectedRow Column:(int)self.puzzleView.selectedCol]) {
                [puzzle clearPencil:(int)sender.tag AtRow:(int)self.puzzleView.selectedRow Column:(int)self.puzzleView.selectedCol];
                [self.puzzleView setNeedsDisplay];
            }else{
                [puzzle setPencil:(int)sender.tag AtRow:(int)self.puzzleView.selectedRow Column:(int)self.puzzleView.selectedCol];
                [self.puzzleView setNeedsDisplay];
            }
        }else{
            if ([puzzle numberAtRow:(int)self.puzzleView.selectedRow Column:(int)self.puzzleView.selectedCol] == (int)sender.tag) {
                [puzzle setNumber:0 AtRow:(int)self.puzzleView.selectedRow Column:(int)self.puzzleView.selectedCol];
                [self.puzzleView setNeedsDisplay];
            }else{
                [puzzle setNumber:(int)sender.tag AtRow:(int)self.puzzleView.selectedRow Column:(int)self.puzzleView.selectedCol];
                [self.puzzleView setNeedsDisplay];
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.buttonView setNeedsLayout];
}

@end
