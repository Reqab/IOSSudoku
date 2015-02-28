//
//  PuzzleView.m
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 2/25/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "PuzzleView.h"

@implementation PuzzleView

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
}

@end
