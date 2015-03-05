//
//  ButtonView.m
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 3/4/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

-(void)layoutSubviews{
    [super layoutSubviews];
    
    static const int buttonTagsPortrait[2][6] = {
        1, 2, 3, 4, 5, 11,
        6, 7, 8, 9, 10, 12
    };
    static const int buttonTagsPortraitTall[3][4] = {
        1, 2, 3, 10,
        4, 5, 6, 11,
        7, 8, 9, 12
    };
    static const int buttonTagsLandscape[6][2] = {
        1, 6,
        2, 7,
        3, 8,
        4, 9,
        5, 10,
        11, 12
    };
    static const int buttonTagsLandscapeTall[4][3] = {
        1, 4, 7,
        2, 5, 8,
        3, 6, 9,
        10, 11, 12
    };
    
    const CGFloat aspectRatiosForLayouts[4] = {
        3.0,        // 2 x 6
        4.0/3,      // 3 x 4
        1.0/3,      // 6 x 2
        3.0/4       // 4 x 3
    };
    
    //find closest
    const CGRect myBounds = self.bounds;
    const CGFloat aspectRatio = myBounds.size.width / myBounds.size.height;
    int closestLayout = 0;
    CGFloat closestLayoutDiff = fabs(aspectRatio - aspectRatiosForLayouts[0]);
    for (int i = 1; i < 4; i++) {
        const CGFloat diff = fabs(aspectRatio - aspectRatiosForLayouts[i]);
        if(diff < closestLayoutDiff){
            closestLayout = i;
            closestLayoutDiff = diff;
        }
    }
    
    switch (closestLayout) {
        case 0:
        {   // portrait 2x6
            const CGFloat W = ((int)myBounds.size.width/6)*6;
            const CGFloat H = ((int)myBounds.size.height/2)*2;
            const CGRect boardRect = CGRectMake((myBounds.size.width - W), (myBounds.size.height - H), W, H);
            const CGRect buttonBounds = CGRectMake(0, 0, W/6, H/2);
            for (int row = 0; row < 2; row++) {
                for (int col = 0; col < 6; col++) {
                    const int tag = buttonTagsPortrait[row][col];
                    UIView *button = [self viewWithTag:tag];
                    button.bounds = buttonBounds;
                    button.center = CGPointMake(boardRect.origin.x + buttonBounds.size.width*(col + 0.5), boardRect.origin.x + buttonBounds.size.height*(row + 0.5));
                }
            }
        }
            break;
        case 1:
        {   // portrait 3x4
            const CGFloat W = ((int)myBounds.size.width/4)*4;
            const CGFloat H = ((int)myBounds.size.height/3)*3;
            const CGRect boardRect = CGRectMake((myBounds.size.width - W), (myBounds.size.height - H), W, H);
            const CGRect buttonBounds = CGRectMake(0, 0, W/4, H/3);
            for (int row = 0; row < 3; row++) {
                for (int col = 0; col < 4; col++) {
                    const int tag = buttonTagsPortraitTall[row][col];
                    UIView *button = [self viewWithTag:tag];
                    button.bounds = buttonBounds;
                    button.center = CGPointMake(boardRect.origin.x + buttonBounds.size.width*(col + 0.5), boardRect.origin.x + buttonBounds.size.height*(row + 0.5));
                }
            }
            
        }
            break;
        case 2:
        {   // portrait 6x2
            const CGFloat W = ((int)myBounds.size.width/2)*2;
            const CGFloat H = ((int)myBounds.size.height/6)*6;
            const CGRect boardRect = CGRectMake((myBounds.size.width - W), (myBounds.size.height - H), W, H);
            const CGRect buttonBounds = CGRectMake(0, 0, W/2, H/6);
            for (int row = 0; row < 6; row++) {
                for (int col = 0; col < 2; col++) {
                    const int tag = buttonTagsLandscape[row][col];
                    UIView *button = [self viewWithTag:tag];
                    button.bounds = buttonBounds;
                    button.center = CGPointMake(boardRect.origin.x + buttonBounds.size.width*(col + 0.5), boardRect.origin.x + buttonBounds.size.height*(row + 0.5));
                }
            }
        }
            break;
        case 3:
        {   // portrait 4x3
            const CGFloat W = ((int)myBounds.size.width/3)*3;
            const CGFloat H = ((int)myBounds.size.height/4)*4;
            const CGRect boardRect = CGRectMake((myBounds.size.width - W), (myBounds.size.height - H), W, H);
            const CGRect buttonBounds = CGRectMake(0, 0, W/3, H/4);
            for (int row = 0; row < 4; row++) {
                for (int col = 0; col < 3; col++) {
                    const int tag = buttonTagsLandscapeTall[row][col];
                    UIView *button = [self viewWithTag:tag];
                    button.bounds = buttonBounds;
                    button.center = CGPointMake(boardRect.origin.x + buttonBounds.size.width*(col + 0.5), boardRect.origin.x + buttonBounds.size.height*(row + 0.5));
                }
            }
        }
            break;
            
        default:
            break;
    }
}

@end