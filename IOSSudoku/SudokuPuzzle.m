//
//  SudokuPuzzle.m
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 3/2/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "SudokuPuzzle.h"

@implementation SudokuPuzzle

-(instancetype)init{
    return nil;
}

-(instancetype)initWithContentsOfFile:(NSString*)path{
    return nil;
}

-(void)writeToFile:(NSString*)path{
    
}
-(void)freshGame:(NSString*)puzzleString{
    
}

-(int)numberAtRow:(int)r Column:(int)c{
    return 0;
}

-(void)setNumber:(int)n AtRow:(int)r Column:(int)c{
    
}

-(BOOL)numberIsFixedAtRow:(int)r Column:(int)c{
    return false;
}

-(BOOL)isConflictingEntryAtRow:(int)r Column:(int)c{
    return false;
}

-(BOOL)anyPencilsSetAtRow:(int)r Column:(int)c{
    return false;
}

-(int)numberOfPencilsSetAtRow:(int)r Column:(int)c{
    return 0;
}

-(BOOL)isSetPencil:(int)n AtRow:(int)r Column:(int)c{
    return false;
}

-(void)setPencil:(int)n AtRow:(int)r Column:(int)c{
    
}

-(void)clearPencil:(int)n AtRow:(int)r Column:(int)c{
    
}

-(void)clearAllPencilsAtRow:(int)r Column:(int)c{
    
}

@end
