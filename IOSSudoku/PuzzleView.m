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
    const CGPoint tapPoint = [sender locationInView:self];
    const CGRect boardSquare = [self boardRect];
    const CGFloat squareSize = boardSquare.size.width/9;
    const int row = (tapPoint.y - boardSquare.origin.y)/squareSize;
    const int col = (tapPoint.x - boardSquare .origin.x)/squareSize;
    if(0 <= row && row < 9 && 0 <= col && col < 9){
        if(row != _selectedRow || col != _selectedCol){
            if(puzzle != nil && ![puzzle numberIsFixedAtRow:row Column:col]){
                _selectedRow = row;
                _selectedCol = col;
                [self setNeedsDisplay];
            }
        }
    }
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
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
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    SudokuPuzzle *puzzle = appDelegate.sudokuPuzzle;
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const CGRect boardSquare = [self boardRect];
    
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 5);
    CGContextStrokeRect(context, boardSquare);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    
    const CGFloat smallSquareSize = boardSquare.size.width/9;
    const CGFloat squareSize = boardSquare.size.width/3;
    
    if(_selectedCol >= 0 && _selectedRow >= 0){
        CGContextSetRGBFillColor(context, 0.0, 90/255.0, 1.0, 0.75);
        CGContextFillRect(context, CGRectMake(boardSquare.origin.x + _selectedCol*smallSquareSize, boardSquare.origin.y + _selectedRow*smallSquareSize, smallSquareSize, smallSquareSize));
    }
    

    for(int row = 0; row < 3; row++){
        for(int col = 0; col < 3; col++){
            CGContextStrokeRect(context, CGRectMake(boardSquare.origin.x + col*squareSize, boardSquare.origin.y + row*squareSize, squareSize, squareSize));
        }
    }
    
    CGContextSetLineWidth(context, 1);

    for(int row = 0; row < 9; row++){
        for(int col = 0; col < 9; col++){
            CGContextStrokeRect(context, CGRectMake(boardSquare.origin.x + col*smallSquareSize, boardSquare.origin.y + row*smallSquareSize, smallSquareSize, smallSquareSize));
        }
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30], NSForegroundColorAttributeName: [UIColor blackColor]};
    NSDictionary *conAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30], NSForegroundColorAttributeName: [UIColor redColor]};
    NSDictionary *fixAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30], NSForegroundColorAttributeName: [UIColor colorWithRed:0.0 green:90/255.0 blue:1 alpha:1]};
    NSDictionary *penAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor blackColor]};
    
    for(int row = 0; row < 9; row++){
        for(int col = 0; col < 9; col++){
            const NSString *text;
            const int number = [puzzle numberAtRow:row Column:col];
            if (number > 0){
                text = [NSString stringWithFormat:@"%d", [puzzle numberAtRow:row Column:col]];
                const CGSize textSize = [text sizeWithAttributes:attributes];
                const CGFloat x = boardSquare.origin.x + col*smallSquareSize + 0.5*(smallSquareSize - textSize.width);
                const CGFloat y = boardSquare.origin.y + row*smallSquareSize + 0.5*(smallSquareSize - textSize.height);
                const CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
                if ([puzzle isConflictingEntryAtRow:row Column:col])
                    [text drawInRect:textRect withAttributes:conAttributes];
                else if([puzzle numberIsFixedAtRow:row Column:col])
                    [text drawInRect:textRect withAttributes:fixAttributes];
                else
                    [text drawInRect:textRect withAttributes:attributes];
            }
            else if([puzzle anyPencilsSetAtRow:row Column:col]){
                for(int penRow = 0; penRow < 3; penRow++) {
                    for (int penCol = 0; penCol < 3; penCol++) {
                        const int pencilValue = penCol + 3*penRow + 1;
                        if ([puzzle isSetPencil:pencilValue AtRow:row Column:col]) {
                            text = [NSString stringWithFormat:@"%d", pencilValue];
                            const CGSize textSize = [text sizeWithAttributes:penAttributes];
                            const CGFloat x = boardSquare.origin.x + col*smallSquareSize +penCol*smallSquareSize/3 + 0.5*(smallSquareSize/3 - textSize.width);
                            const CGFloat y = boardSquare.origin.y + row*smallSquareSize +penRow*smallSquareSize/3 + 0.5*(smallSquareSize/3 - textSize.height);
                            const CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
                            [text drawInRect:textRect withAttributes:penAttributes];
                        }
                    }
                }
            }
        }
    }
}

@end
