//
//  PuzzleView.m
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 2/25/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "PuzzleView.h"
#import "AppDelegate.h"
#import "SudokuPuzzle.h"

@interface PuzzleView();

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer * tapGestureRecognizer;

@end

@implementation PuzzleView


- (IBAction)handleFingerTap:(UIGestureRecognizer*)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    SudokuPuzzle *puzzle = appDelegate.sudokuPuzzle;
    const CGPoint tapPoint = [sender locationInView:sender.view];
    const CGRect boardSquare = [self boardRect];
    const CGFloat squareSize = boardSquare.size.width/9;
    const int row = (tapPoint.y - boardSquare.origin.y)/squareSize;
    const int col = (tapPoint.x - boardSquare .origin.x)/squareSize;
    if(0 <= row && row < 9 && 0 <= col && col < 9){
        if(row != _selectedRow || col != _selectedCol){
            //if(puzzle != nil && ![puzzle numberIsFixedAtRow:row Column:col]){
                _selectedRow = row;
                _selectedCol = col;
                [self setNeedsDisplay];
            //}
        }
    }
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    NSLog(@"initWithCoder:");
    if(self = [super initWithCoder:aDecoder]){
        _selectedCol = _selectedRow = -1;
    }
    return self;
}

-(CGRect)boardRect {
    const CGRect bounds = self.bounds;
    const CGFloat size = ((bounds.size.width < bounds.size.height) ? bounds.size.width : bounds.size.height) - 5;
    const CGPoint center = CGPointMake(bounds.size.width/2, bounds.size.height/2);
    const CGPoint origin = CGPointMake(center.x-size/2, center.y-size/2);
    return CGRectMake(origin.x, origin.y, size, size);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const CGRect boardSquare = [self boardRect];
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 5);
    CGContextStrokeRect(context, boardSquare);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    
    const CGFloat squareSize = boardSquare.size.width/3;
    for(int row = 0; row < 3; row++){
        for(int col = 0; col < 3; col++){
            CGContextStrokeRect(context, CGRectMake(boardSquare.origin.x + col*squareSize, boardSquare.origin.y + row*squareSize, squareSize, squareSize));
            

        }
    }
    
    CGContextSetLineWidth(context, 1);
    
    const CGFloat smallSquareSize = boardSquare.size.width/9;
    for(int row = 0; row < 9; row++){
        for(int col = 0; col < 9; col++){
            CGContextStrokeRect(context, CGRectMake(boardSquare.origin.x + col*smallSquareSize, boardSquare.origin.y + row*smallSquareSize, smallSquareSize, smallSquareSize));
            
            
        }
    }
    if(_selectedCol >= 0 && _selectedRow >= 0){
        CGContextSetRGBFillColor(context, 0.9, 0.9, 0.9, 0.5);
        CGContextFillRect(context, CGRectMake(boardSquare.origin.x + _selectedCol*smallSquareSize, boardSquare.origin.y + _selectedRow*smallSquareSize, smallSquareSize, smallSquareSize));
    }
}

@end
