//
//  TwoViewController.h
//  1130
//
//  Created by dqh on 2018/11/1.
//  Copyright © 2018 juesheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

@interface People : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger count;
@end
