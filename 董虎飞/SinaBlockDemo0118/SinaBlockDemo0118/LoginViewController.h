//
//  LoginViewController.h
//  SinaBlockDemo0118
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 DHF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic,copy) void(^getAccessTokenSuccess)();

@end
