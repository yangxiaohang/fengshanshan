//
//  HTTPRequest.h
//  SinaBlockDemo0118
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 DHF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequest : NSObject

@property (nonatomic,copy) void(^getAccesstokenSuccess)(NSString *);
@property (nonatomic,copy) void(^getFriendTimeLineSuccess)(NSArray *);

+ (NSURL *)getLoginURL;

- (void)getAccesstokenWithCode:(NSString *)code;

+ (BOOL)isNeedLogin;

- (void)getFriendsTimeLine;

@end
