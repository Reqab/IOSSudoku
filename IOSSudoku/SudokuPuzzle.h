//
//  SudokuPuzzle.h
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 3/2/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuPuzzle : NSObject

-(instancetype)init;
-(instancetype)initWithContentsOfFile:(NSString*)path;
-(void)writeToFile:(NSString*)path;
-(void)freshGame:(NSString*)puzzleString;
-(int)numberAtRow:(int)r Column:(int)c;
-(void)setNumber:(int)n AtRow:(int)r Column:(int)c;
-(BOOL)numberIsFixedAtRow:(int)r Column:(int)c;
-(BOOL)isConflictingEntryAtRow:(int)r Column:(int)c;
-(BOOL)anyPencilsSetAtRow:(int)r Column:(int)c;
-(int)numberOfPencilsSetAtRow:(int)r Column:(int)c;
-(BOOL)isSetPencil:(int)n AtRow:(int)r Column:(int)c;
-(void)setPencil:(int)n AtRow:(int)r Column:(int)c;
-(void)clearPencil:(int)n AtRow:(int)r Column:(int)c;
-(void)clearAllPencilsAtRow:(int)r Column:(int)c;

@end
