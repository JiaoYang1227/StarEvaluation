//
//  ViewController.m
//  StarEvaluation
//
//  Created by sun on 16/4/13.
//  Copyright © 2016年 sun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_starView setImagesDeselected:@"unselectedImage" partlySelected:@"partlySelectedImage" fullSelected:@"fullySelectedImage" andJYRatingChangedBlock:^(float newRating) {
        NSLog(@"%@",[NSString stringWithFormat:@"Rating is: %1.1f", newRating]);
    }];
    //设置默认分数
    [_starView displayRating:0.5];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
