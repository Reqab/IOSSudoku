//
//  SudokuPuzzle.m
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 3/2/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "SudokuPuzzle.h"

typedef struct{
    char number;
    BOOL isFixed;
    short pencilMark;
} Cell;

@implementation SudokuPuzzle

Cell cells[9][9];

-(instancetype)init{
    if(self = [super init]){
        for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
                cells[row][col].isFixed = NO;
                cells[row][col].number = 0;
                cells[row][col].pencilMark = 0;
            }
        }
    }
    return self;
}

-(instancetype)initWithContentsOfFile:(NSString*)path{
    
    return nil;
}

-(void)writeToFile:(NSString*)path{
    
}
-(void)freshGame:(NSString*)puzzleString{
    int n = 0;
    for (int row = 0; row < 9; row++) {
        for (int col = 0; col < 9; col++) {
            const unichar c = [puzzleString characterAtIndex:n++];
            if('1' <= c && c <= '9'){
                cells[row][col].number = c;
                cells[row][col].isFixed = YES;
            }else{
                cells[row][col].number = 0;
                cells[row][col].isFixed = NO;
            }
            cells[row][col].pencilMark = 0;
        }
    }
}

-(int)numberAtRow:(int)r Column:(int)c{
    return cells[r][c].number;
}

-(void)setNumber:(int)n AtRow:(int)r Column:(int)c{
    cells[r][c].number = n;
}

-(BOOL)numberIsFixedAtRow:(int)r Column:(int)c{
    return cells[r][c].isFixed;
}

-(BOOL)isConflictingEntryAtRow:(int)r Column:(int)c{
    if (cells[r][c].isFixed == NO)
        return NO;
    
    const int number = cells[r][c].number;
    
    if(number == 0)
        return NO;
    
    for (int row = 0; row < 9; row++) {
        if (row == r) continue;
        if (cells[row][c].number == number)
            return YES;
    }
    
    for (int col = 0; col < 9; col++) {
        if (col == c) continue;
        if (cells[r][col].number == number)
            return YES;
    }
    
    const int blockRow = (r/3)*3;
    const int blockCol = (c/3)*3;
    for (int j = 0; j < 3; j++) {
        for (int i = 0; i < 3; i++) {
            const int row = blockRow + j;
            const int col = blockCol + i;
            if (row == r && col == c) continue;
            if (cells[row][col].number == number)
                return YES;
        }
    }
    return NO;
}

-(BOOL)anyPencilsSetAtRow:(int)r Column:(int)c{
    return cells[r][c].pencilMark != 0;
}

-(int)numberOfPencilsSetAtRow:(int)r Column:(int)c{
    const int mask = cells[r][c].pencilMark;
    int count = 0;
    for(int bit = 0; bit < 9; bit++)
        if((1 << bit) & mask)
            count++;
    return count;
}

-(BOOL)isSetPencil:(int)n AtRow:(int)r Column:(int)c{
    return (cells[r][c].pencilMark & (1 << (n-1))) != 0;
}

-(void)setPencil:(int)n AtRow:(int)r Column:(int)c{
    cells[r][c].pencilMark |= 1 << (n-1);
}

-(void)clearPencil:(int)n AtRow:(int)r Column:(int)c{
    cells[r][c].pencilMark &= ~(1 << (n-1));
}

-(void)clearAllPencilsAtRow:(int)r Column:(int)c{
    cells[r][c].pencilMark = 0;
}

@end
