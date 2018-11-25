//
//  NSObject+ObjDic.h
//  MiGuKit
//
//  Created by zhgz on 2018/3/10.
//  Copyright © 2018年 Migu Video Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSObject *_Nullable(^MG_Value)(id _Nullable key);

@interface NSObject (ObjDic)

/** *将JSON string 转化为Dictionary*/
-(NSDictionary * _Nullable)toDictionary;

/** *将JSON string 转化为Array*/
-(NSArray * _Nullable)toArray;

/** *将url string 进行编码，且只需编码一次*/
-(NSString * _Nullable)urlEncodeFullOnce;

/** *将url string 进行解码，且只需编码一次*/
-(NSString * _Nullable)urlDecodeFullOnce;



/**
 keyPath字符串取字典/数组的值
 
 {
 "JavaObjc":{
    "testMap":{
        "entry":[{
                     "string":"testMapList",
                     "list":{
                     "DemoModel":[
                         {
                             "age":"20",
                             "birthday":"1988-01-01 00:00:00",
                             "name":"testDemoModelMap0"
                         },
                         {
                             "age":"20",
                             "birthday":"1988-01-01 00:00:00",
                             "name":"testDemoModelMap1"
                         }
                     ]
                 }
             }]
         },
         "testString":"testString"
     }
 }

 NSString *name = [dict2 jsonValueForKeyPath:@"JavaObjc.testMap.entry[0].list.DemoModel[0].name"];
 //打印testDemoModelMap0
 
 支持一下格式keyPath
 @"name"
 @"peroples[2].name"
 @"peoples[2][3].name"
 */
- (id _Nullable)jsonValueForKeyPath:(NSString *_Nullable)keyPath;

@end
