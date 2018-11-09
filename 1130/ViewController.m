//
//  ViewController.m
//  1130
//
//  Created by dqh on 2017/11/30.
//  Copyright © 2017年 juesheng. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    back.backgroundColor = [UIColor greenColor];
    [back addTarget:self action:@selector(bakcAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UIButton *backTwo = [[UIButton alloc] initWithFrame:CGRectMake(30, 130, 40, 40)];
    backTwo.backgroundColor = [UIColor greenColor];
    backTwo.tag = 10;
    [backTwo addTarget:self action:@selector(bakcAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backTwo];
    
    
    UIButton *backThree = [[UIButton alloc] initWithFrame:CGRectMake(30, 230, 100, 40)];
    backThree.backgroundColor = [UIColor whiteColor];
    [backThree setImage:[UIImage imageNamed:@"icon_deng1_user"] forState:UIControlStateNormal];
    [backThree addTarget:self action:@selector(bakcAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backThree];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setButtonTitleAndImageMargin:(CGFloat)margin button:(UIButton *)button
{
    button.titleLabel.backgroundColor = button.backgroundColor;
    button.imageView.backgroundColor = button.backgroundColor;
    
    CGSize titleSize = [self textBoundingRect:CGSizeMake(1000, 1000) font:button.titleLabel.font text:button.titleLabel.text];
    CGSize imageSize = button.imageView.bounds.size;
    
//    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + margin, (button.frame.size.width - titleSize.width) / 2. - titleSize.width, 0, 0)];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(0, (button.frame.size.width - imageSize.width) / 2., button.frame.size.height - imageSize.height, 0.)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + margin, (button.frame.size.width - titleSize.width) / 2. - titleSize.width, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, (button.frame.size.width - imageSize.width) / 2., button.frame.size.height - imageSize.height, 0.)];
}

- (CGSize)textBoundingRect:(CGSize)size font:(UIFont *)font text:(NSString *)text
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}

- (void)bakcAction:(UIButton *)sender
{
    if(sender.tag == 10) {
        TwoViewController *two = [[TwoViewController alloc] init];
        [self presentViewController:two animated:YES completion:nil];
    } else {
        OneViewController *one = [[OneViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:one];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
