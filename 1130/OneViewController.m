//
//  OneViewController.m
//  1130
//
//  Created by dqh on 2018/10/29.
//  Copyright © 2018 juesheng. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    back.backgroundColor = [UIColor greenColor];
    [back addTarget:self action:@selector(bakcAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_xin_first_upload.png"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    red.backgroundColor = [UIColor redColor];
    [button addSubview:red];
    
    NSArray *images = @[@"bg_deng1.png", @"icon_deng1_user.png", @"icon_deng2_password.png", @"icon_deng3_remember_press.png", @"icon_deng3_remember.png", @"icon_zhu_phone.png", @"icon_zhu_yan.png", @"LOGO_sy.png"];
    
    for (NSInteger i = 0; i < images.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*50 + 100, 40, 40)];
        imageview.image = [UIImage imageNamed:images[i]];
        [self.view addSubview:imageview];
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        button.hidden = true;
//    });
    // Do any additional setup after loading the view.
}

- (void)bakcAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
