//
//  HTTPRequest.m
//  SinaBlockDemo0118
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 DHF. All rights reserved.
//

#import "HTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "FriendModel.h"


/*
 App Key：918422208
 App Secret：c5a1a3df0cf96a5bbd6bfb4407ccd1e5
 */

#define access_token_key @"access_token"
#define expires_in_key @"expires_in"
#define uid_key @"uid"

@implementation HTTPRequest

+ (BOOL)isNeedLogin {
    
    NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:access_token_key];
    
    if (!access_token) {
        return YES;
    }
    
    NSDate *date = [[NSUserDefaults standardUserDefaults]objectForKey:expires_in_key];
    
    NSDate *nowDate = [NSDate date];
    
    NSComparisonResult result = [nowDate compare:date];
    
    if (result == NSOrderedAscending) {
        return NO;
    }
    
    return YES;
    
}

+ (NSURL *)getLoginURL {
    
    NSString *urlString = @"https://api.weibo.com/oauth2/authorize?client_id=918422208&redirect_uri=http://www.baidu.com";
    
    return [NSURL URLWithString:urlString];
    
}

- (void)getAccesstokenWithCode:(NSString *)code {
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"]];
    
    [request setPostValue:@"918422208"
                   forKey:@"client_id"];
    [request setPostValue:@"c5a1a3df0cf96a5bbd6bfb4407ccd1e5"
                   forKey:@"client_secret"];
    [request setPostValue:@"authorization_code"
                   forKey:@"grant_type"];
    [request setPostValue:code
                   forKey:@"code"];
    [request setPostValue:@"http://www.baidu.com"
                   forKey:@"redirect_uri"];
    
    [request setCompletionBlock:^{
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
        [self parseAccessTokenWithDic:dic];
    }];
    
    [request startAsynchronous];
    
}

- (void)parseAccessTokenWithDic:(NSDictionary *)dic {
    
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"access_token"] forKey:access_token_key];
    NSDate *nowDate = [NSDate date];
    
    NSDate *finalDate = [nowDate dateByAddingTimeInterval:[dic[@"expires_in"]integerValue]];
    
    [[NSUserDefaults standardUserDefaults]setObject:finalDate forKey:expires_in_key];
    
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"uid"] forKey:uid_key];
    
    if (self.getAccesstokenSuccess) {
        self.getAccesstokenSuccess(dic[@"access_token"]);
    }

}

- (void)getFriendsTimeLine {
    
    NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:access_token_key];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/friends_timeline.json?access_token=%@",access_token]]];
    
    [request setCompletionBlock:^{
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
        [self parseFriendsTimeLineWithDic:dic];
        
    }];
    
    [request startAsynchronous];
    
}

- (void)parseFriendsTimeLineWithDic:(NSDictionary *)dic {
    
    NSArray *array = dic[@"statuses"];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        FriendModel *friend = [FriendModel modelWithDic:dict];
        
        [dataArr addObject:friend];
        
    }
    
    if (self.getFriendTimeLineSuccess) {
        self.getFriendTimeLineSuccess(dataArr);
    }
    
}

- (void)dealloc {
    self.getAccesstokenSuccess = nil;
    self.getFriendTimeLineSuccess = nil;
    [super dealloc];
}

@end
