//
//  JYRatingView.m
//  StarEvaluation
//
//  Created by sun on 16/4/13.
//  Copyright © 2016年 sun. All rights reserved.
//

#import "JYRatingView.h"

@implementation JYRatingView

-(void)setImagesDeselected:(NSString *)unselected partlySelected:(NSString *)partlySelected
              fullSelected:(NSString *)fullSelected andJYRatingChangedBlock:(JYRatingChangedBlock)block{
    _ratingChangedBlock = [block copy];
    unselectedImage = [UIImage imageNamed:unselected];
	partlySelectedImage = [UIImage imageNamed:partlySelected];
	fullySelectedImage = [UIImage imageNamed:fullSelected];
	
	height=0.0; width=0.0;
	if (height < [fullySelectedImage size].height) {
		height = [fullySelectedImage size].height;
	}
	if (height < [partlySelectedImage size].height) {
		height = [partlySelectedImage size].height;
	}
	if (height < [unselectedImage size].height) {
		height = [unselectedImage size].height;
	}
	if (width < [fullySelectedImage size].width) {
		width = [fullySelectedImage size].width;
	}
	if (width < [partlySelectedImage size].width) {
		width = [partlySelectedImage size].width;
	}
	if (width < [unselectedImage size].width) {
		width = [unselectedImage size].width;
	}
	
	starRating = 0;
	lastRating = 0;
    
    _imageWidth = ([[UIScreen mainScreen] bounds].size.width-40-(width*5))/5;
	stars1 = [[UIImageView alloc] initWithImage:unselectedImage];
	stars2 = [[UIImageView alloc] initWithImage:unselectedImage];
	stars3 = [[UIImageView alloc] initWithImage:unselectedImage];
	stars4 = [[UIImageView alloc] initWithImage:unselectedImage];
	stars5 = [[UIImageView alloc] initWithImage:unselectedImage];
	
	[stars1 setFrame:CGRectMake(0,         0, width, height)];
	[stars2 setFrame:CGRectMake(width+_imageWidth,     0, width, height)];
	[stars3 setFrame:CGRectMake(2 * (width+_imageWidth), 0, width, height)];
	[stars4 setFrame:CGRectMake(3 * (width+_imageWidth), 0, width, height)];
	[stars5 setFrame:CGRectMake(4 * (width+_imageWidth), 0, width, height)];
	
	[stars1 setUserInteractionEnabled:NO];
	[stars2 setUserInteractionEnabled:NO];
	[stars3 setUserInteractionEnabled:NO];
	[stars4 setUserInteractionEnabled:NO];
	[stars5 setUserInteractionEnabled:NO];
	
	[self addSubview:stars1];
	[self addSubview:stars2];
	[self addSubview:stars3];
	[self addSubview:stars4];
	[self addSubview:stars5];
	
	CGRect frame = [self frame];
	frame.size.width = width * 5;
	frame.size.height = height;
	[self setFrame:frame];
}

-(void)displayRating:(float)rating {
	[stars1 setImage:unselectedImage];
	[stars2 setImage:unselectedImage];
	[stars3 setImage:unselectedImage];
	[stars4 setImage:unselectedImage];
	[stars5 setImage:unselectedImage];
	
	if (rating >= 0.5) {
		[stars1 setImage:partlySelectedImage];
	}
	if (rating >= 1) {
		[stars1 setImage:fullySelectedImage];
	}
	if (rating >= 1.5) {
		[stars2 setImage:partlySelectedImage];
	}
	if (rating >= 2) {
		[stars2 setImage:fullySelectedImage];
	}
	if (rating >= 2.5) {
		[stars3 setImage:partlySelectedImage];
	}
	if (rating >= 3) {
		[stars3 setImage:fullySelectedImage];
	}
	if (rating >= 3.5) {
		[stars4 setImage:partlySelectedImage];
	}
	if (rating >= 4) {
		[stars4 setImage:fullySelectedImage];
	}
	if (rating >= 4.5) {
		[stars5 setImage:partlySelectedImage];
	}
	if (rating >= 5) {
		[stars5 setImage:fullySelectedImage];
	}
	
	starRating = rating;
	lastRating = rating;
    if (rating>=5) {
        rating = 5;
    }
    if (rating<=0) {
        rating = 0;
    }
    _ratingChangedBlock(rating);
}

-(void) touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
	[self touchesMoved:touches withEvent:event];
}

-(void) touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event
{
	CGPoint pt = [[touches anyObject] locationInView:self];
    int count;
    if (pt.x<width) {
        count = 0;
    }else{
        count = (int)(pt.x / (width+_imageWidth));
    }
    float newRating = (float) ((pt.x-count*(width+_imageWidth)) / width);
    if (pt.x-count*(width+_imageWidth)>width) {
        newRating = 1;
    }else{
        newRating = (float) (pt.x-count*(width+_imageWidth)) / width;
    }
    if (newRating <= 0 || newRating > 5.5)
        return;
    
    if (newRating != lastRating)
        [self displayRating:(newRating+count)];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[self touchesMoved:touches withEvent:event];
}

-(float)rating {
	return starRating;
}

@end
