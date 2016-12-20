//
//  JYRatingView.h
//  StarEvaluation
//
//  Created by sun on 16/4/13.
//  Copyright © 2016年 sun. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  选择分数的回调
 *
 *  @param newRating 分数
 */
typedef void(^JYRatingChangedBlock)(float newRating);
@interface JYRatingView : UIView {
	UIImageView *stars1, *stars2, *stars3, *stars4, *stars5;
	UIImage *unselectedImage, *partlySelectedImage, *fullySelectedImage;

	float starRating, lastRating;
	float height, width; 
    float _imageWidth;
    JYRatingChangedBlock _ratingChangedBlock;
}
-(void)setImagesDeselected:(NSString *)unselected partlySelected:(NSString *)partlySelected
              fullSelected:(NSString *)fullSelected andJYRatingChangedBlock:(JYRatingChangedBlock)block;

-(void)displayRating:(float)rating;
@end
