//
//  ShopDataSource.m
//  gameShop
//
//  Created by student on 4/4/15.
//  Copyright (c) 2015 SSU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopDataSource.h"


@interface ShopDataSource()

@property(nonatomic) NSMutableArray *skinDictionaryArray;

@property(nonatomic) NSMutableArray *skinArray;
@property(nonatomic) NSMutableArray *unlockedSkins;
@property(nonatomic) UIImage *blueLizard;


@end

@implementation ShopDataSource

-(instancetype)initWithSkins
{
    if((self = [super init]) == nil)
        return nil;
    
    
    [self createSkin:@"Skin1" withDescription:@"Made In China" withPrice:@"777" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    [self createSkin:@"Skin2" withDescription:@"Crafted deep within Mt. Doom" withPrice:@"123" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    [self createSkin:@"Skin3" withDescription:@"Crafted by Justin...in Runescape" withPrice:@"999" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    [self createSkin:@"Skin4" withDescription:@"Crafted by a Craftsman" withPrice:@"999" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    [self createSkin:@"Skin5" withDescription:@"Skin5 Description" withPrice:@"999" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    [self createSkin:@"Skin6" withDescription:@"Skin6 Description" withPrice:@"999" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    [self createSkin:@"Skin7" withDescription:@"Skin7 Description" withPrice:@"999" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    [self createSkin:@"Skin8" withDescription:@"Skin8 Description" withPrice:@"999" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    [self createSkin:@"Skin9" withDescription:@"Skin9 Description" withPrice:@"999" withImg:[UIImage imageWithContentsOfFile:@"/Users/student/Downloads/gameShop-master/gameShop/1194989442932416363sword_01.svg.hi.png"]];
    return self;
    
}

-(NSMutableArray *) skinArray
{
    if(!_skinArray){
        _skinArray = [[NSMutableArray alloc] init];
    }
    return _skinArray;
}
-(NSMutableArray *) unlockedSkins
{
    if(!_unlockedSkins){
        _unlockedSkins = [[NSMutableArray alloc] init];
    }
    return _unlockedSkins;
}

-(void) createSkin:(NSString *) name withDescription:(NSString *)desc withPrice:(NSString *)price withImg:(UIImage *)img
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:name forKey:@"name"];
    [dict setObject:desc forKey:@"description"];
    [dict setObject:price forKey:@"price"];
    
    //NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    //UIImage *img = [[UIImage alloc]initWithData:data];
    
    [dict setObject:img forKey:@"image"];
    
    NSLog(@"Created Skin %@", dict);
    
    Skin *skin = [[Skin alloc] initWithDictionary:dict];
    
    [skin print];
    
    [self.skinArray addObject:skin];
    
    NSLog(@"Skin Array Count %lu", (unsigned long)[self.skinArray count]);
    
}

-(Skin *) skinAtIndex: (NSInteger) idx
{
    if( idx >= [self.skinArray count] )
        return nil;
    return [self.skinArray objectAtIndex: idx];
}

-(NSInteger) numberOfSkins
{
    return [self.skinArray count];
}







@end