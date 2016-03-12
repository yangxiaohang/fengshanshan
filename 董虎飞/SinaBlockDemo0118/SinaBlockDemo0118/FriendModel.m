//
//  FriendModel.m
//  SinaBlockDemo0118
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 DHF. All rights reserved.
//

#import "FriendModel.h"
#import "XMLReader.h"

@implementation FriendModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        
        self.name = dic[@"user"][@"name"];
        
        self.picData = [NSData dataWithContentsOfURL:[NSURL URLWithString:dic[@"user"][@"profile_image_url"]]];
        
        self.text = dic[@"text"];
        
        NSError *error = nil;
        
        NSDictionary *dict = [XMLReader dictionaryForXMLString:dic[@"source"] options:XMLReaderOptionsProcessNamespaces error:&error];
        
        self.source = dict[@"a"][@"text"];
        
        
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    
    return [[[self alloc]initWithDic:dic]autorelease];
}

- (void)dealloc {
    self.name = nil;
    self.picData = nil;
    self.text = nil;
    self.source = nil;
    [super dealloc];
}

@end
