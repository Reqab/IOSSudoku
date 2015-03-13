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
    _pencilEnabled = !_pencilEnabled;
    if(self.pencilEnabled){
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"buttonbackgroundpressed"] forState:UIControlStateNormal];
    }else{
        [sender setTitleColor:[UIColor colorWithRed:0 green:90/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"buttonbackground"] forState:UIControlStateNormal];
    }
}

- (IBAction)numberButton:(UIButton *)sender {
    NSLog(@"numberButton: %d", (int)sender.tag);
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    SudokuPuzzle* puzzle = appDelegate.sudokuPuzzle;
    
    if(self.puzzleView.selectedRow >=0 && self.puzzleView.selectedCol >= 0){
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

-(IBAction)menuButton:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    SudokuPuzzle *puzzle = appDelegate.sudokuPuzzle;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Main Menu" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"New Easy Game" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){[puzzle freshGame:[appDelegate randomSimpleGame]];
                                                          [self.puzzleView setNeedsDisplay];
                                                          self.puzzleView.selectedRow = self.puzzleView.selectedCol = -1;}]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"New Hard Game" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){[puzzle freshGame:[appDelegate randomHardGame]];
                                                          [self.puzzleView setNeedsDisplay];
                                                          self.puzzleView.selectedRow = self.puzzleView.selectedCol = -1;}]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Clear Conflicting Cells" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
                                                          for (int row = 0; row < 9; row++) {
                                                              for (int col = 0; col < 9; col++) {
                                                                  if([puzzle isConflictingEntryAtRow:row Column:col])
                                                                      [puzzle setNumber:0 AtRow:row Column:col];
                                                              }
                                                          }
                                                          [self.puzzleView setNeedsDisplay];}]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Clear All Cells" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
                                                          for (int row = 0; row < 9; row++) {
                                                              for (int col = 0; col < 9; col++) {
                                                                  if (![puzzle numberIsFixedAtRow:row Column:col]){
                                                                      [puzzle setNumber:0 AtRow:row Column:col];
                                                                  }
                                                              }
                                                          }
                                                          [self.puzzleView setNeedsDisplay];}]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
        const NSInteger menuButtonTag = 12;
        UIButton *menuButton = (UIButton *)[self.buttonView viewWithTag:menuButtonTag];
        popPresenter.sourceView = menuButton;
        popPresenter.sourceRect = menuButton.bounds;
    }
    
    [self presentViewController:alertController animated:YES completion:^{}];
}

-(IBAction)deleteButton:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    SudokuPuzzle *puzzle = appDelegate.sudokuPuzzle;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Deleting all penciled in numbers" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
                                                          if([puzzle anyPencilsSetAtRow:(int)self.puzzleView.selectedRow Column:(int)self.puzzleView.selectedCol])
                                                                [puzzle clearAllPencilsAtRow:(int)self.puzzleView.selectedRow Column:(int)self.puzzleView.selectedCol];
                                                          [self.puzzleView setNeedsDisplay];}]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
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
