//
//  FriendModel.h
//  SinaBlockDemo0118
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 DHF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)NSData *picData;
@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *source;


- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end
