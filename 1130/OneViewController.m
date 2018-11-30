//
//  OneViewController.m
//  1130
//
//  Created by dqh on 2018/10/29.
//  Copyright © 2018 juesheng. All rights reserved.
//

#import "OneViewController.h"
#import <CreditInformation/CreditInterface.h>
#import <Toast.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] //调颜色

@interface OneViewController ()

@end

@implementation OneViewController

#pragma mark - E

- (void)CreditInformation{
    //注意：初建订单status传0，本例是退回的订单所以status传的是1
    
    [self.view makeToastActivity:CSToastPositionCenter];
    [[CreditInterface sharedUtil] creatCreditViewControlerBankCode:@"5717434000" assurerNo:@"18044365" platNo:@"nfdb" productType:@"1" orderNo:@"vx2018011999771123"  status:@"0"  successAlert:^(NSDictionary *successAlert) {
        NSLog(@"%@", successAlert);
        [self.view hideToastActivity];
        
    } other:^(NSDictionary *otherDic) {
        NSLog(@"%@", otherDic);
        [self.view hideToastActivity];
        
    } failure:^(NSError *errer) {
        NSLog(@"%@", errer);
        [self.view hideToastActivity];
        
    } creditResults:^(NSDictionary *creditDic) {
        NSLog(@"%@", creditDic);
        [self.view hideToastActivity];
        
    }];
}
//清除缓存
- (void)clearCreditInformation{
    [self.view makeToastActivity:CSToastPositionCenter];
    [[CreditInterface sharedUtil] creditClearCache:^(NSDictionary *resultsDic) {
        NSLog(@"%@", resultsDic);
        [self.view hideToastActivity];
        
    }];
}

#pragma mark - Other

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 44);
    [btn setTitle:@"征信" forState:UIControlStateNormal];
    btn.backgroundColor = UIColorFromRGB(0x7E5BE1);
    [btn addTarget:self action:@selector(CreditInformation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame =  CGRectMake(10,200, self.view.frame.size.width - 20, 44);
    [btn2 setTitle:@"清除缓存" forState:UIControlStateNormal];
    btn2.backgroundColor = UIColorFromRGB(0x7E5BE1);
    [btn2 addTarget:self action:@selector(clearCreditInformation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    return;
    
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
