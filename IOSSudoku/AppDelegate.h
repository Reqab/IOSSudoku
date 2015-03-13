//
//  AppDelegate.h
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 2/25/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SudokuPuzzle.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SudokuPuzzle *sudokuPuzzle;

- (NSString*)randomSimpleGame;
- (NSString*)randomHardGame;
-(NSString*)sandBoxFileName;

@end

