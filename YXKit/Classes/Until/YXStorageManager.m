//
//  YXStorageManager.m
//  YXKit
//
//  Created by 顾玉玺 on 2020/1/17.
//

#import "YXStorageManager.h"
#import "FMDB.h"
#import "YXMacro.h"
#import "YXStorageModel.h"
// Column Name
static NSString *const kObjectDataColumn = @"ObjectData";
static NSString *const kIdentityColumn = @"Identity";
static NSString *const KIdSecondLevelColumn = @"IdSecondLevel";
static NSString *const KIdThreeLevelColumn = @"IdThreeLevel";
static NSString *const kLaunchDateColumn = @"LaunchDate";
static NSString *const kDescriptionColumn = @"Desc";
static NSString *const kDatabaseVersion = @"1";

@interface YXStorageManager()
@property (strong, nonatomic) FMDatabaseQueue * dbQueue;
@property (strong, nonatomic) NSMutableArray <Class>*registerClass;
@property (copy, nonatomic) NSString *folderPath;
@property (copy, nonatomic) NSDateFormatter *format;
@end

@implementation YXStorageManager

singleton(YXStorageManager, manager)

- (void)operation:(NSArray<YXStorageModel *> *)datas option:(int)option{
    __block BOOL flag;
       [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
           @try {
               for (YXStorageModel *model in datas) {
                   NSString *launchDate = [self.format stringFromDate:[NSDate date]];
                   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                   NSString *identity = model.storageIdentity?:@"";
                   NSString *second = model.storageSecondIdentity?:@"";
                   NSString *three = model.storageThreeIdentity?:@"";
                   NSArray *arguments = @[data,launchDate,identity,second,three,model.description?:@"None description"];
                   if (option==0) {
                       flag = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@,%@) VALUES (?,?,?,?,?,?);",[self tableNameFromClass:model.class],kObjectDataColumn,kLaunchDateColumn,kIdentityColumn,KIdSecondLevelColumn,KIdThreeLevelColumn,kDescriptionColumn] withArgumentsInArray:arguments];
                   }
                   if (option == 1) {
                       flag = [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET %@ = ? ,%@ = ?,%@ = ?,%@ = ?,%@ = ?,%@ = ? WHERE %@ = \"%@\";",[self tableNameFromClass:model.class],kObjectDataColumn,kLaunchDateColumn,kIdentityColumn,KIdSecondLevelColumn,KIdThreeLevelColumn,kDescriptionColumn,kIdentityColumn,model.storageIdentity] withArgumentsInArray:arguments];
    
                   }
               }
           } @catch (NSException *exception) {
               *rollback = YES;
               flag = NO;
           } @finally {
               *rollback=!flag;
           }
       }];
}

- (void)transactionForInsert:(NSArray *)datas{
    [self operation:datas option:0];
}
- (void)transactionForUpdate:(NSArray<LLStorageModel *> *)datas{
    [self operation:datas option:1];
}
- (void)transactionForDelete:(NSArray<LLStorageModel *> *)datas {
    __block NSMutableSet *identities = [NSMutableSet set];
    __block Class cls;
     for (LLStorageModel *model in datas) {
         [identities addObject:model.storageIdentity];
         cls = model.class;
     }
     __block BOOL flag = NO;
     [_dbQueue inTransaction:^(FMDatabase * db, BOOL *rollback) {
         @try {
             NSString *tableName = [self tableNameFromClass:cls];
                    NSString *identitiesString = [self convertArrayToSQL:identities.allObjects];
             flag = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ IN %@;",tableName,kIdentityColumn,identitiesString]];
                  
         } @catch (NSException *exception) {
             *rollback = YES;
             flag = NO;
         } @finally {
             *rollback=!flag;
         }
     }];
}

- (NSArray *)query:(__unsafe_unretained Class)cls storageId:(NSString *)storageIdentity{
    return [self query:cls primaryKey:kIdentityColumn primaryValue:storageIdentity];
}
- (NSArray *)query:(__unsafe_unretained Class)cls storageSecondId:(NSString *)storageIdentity{
    return [self query:cls primaryKey:KIdSecondLevelColumn primaryValue:storageIdentity];
}
- (NSArray *)query:(__unsafe_unretained Class)cls storageThirdId:(NSString *)storageIdentity{
    return [self query:cls primaryKey:KIdThreeLevelColumn primaryValue:storageIdentity];
}

- (NSArray *)query:(__unsafe_unretained Class)cls primaryKey:(NSString *)primaryKey primaryValue:(NSString *)primaryValue{
        __block NSMutableArray *modelArray = [[NSMutableArray alloc] init];
        [_dbQueue inDatabase:^(FMDatabase * db) {
            NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM %@",[self tableNameFromClass:cls]];
            NSArray *values = @[];
            if (primaryValue.length) {
                SQL = [SQL stringByAppendingFormat:@" WHERE %@ = ?",primaryKey];
                values = @[primaryValue];
            }
            FMResultSet *set = [db executeQuery:SQL withArgumentsInArray:values];
            while ([set next]) {
                NSData *data = nil;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
                if ([set respondsToSelector:@selector(objectForColumn:)]) {
                    data = [set performSelector:@selector(objectForColumn:) withObject:kObjectDataColumn];
                } else if ([set respondsToSelector:@selector(objectForColumnName:)]) {
                    data = [set performSelector:@selector(objectForColumnName:) withObject:kObjectDataColumn];
                }
    #pragma clang diagnostic pop
                if (data) {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    id model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    #pragma clang diagnostic pop
                    if (model) {
                        [modelArray insertObject:model atIndex:0];
                    }
                }
            }
        }];
    return modelArray;
}




#pragma mark - init
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}
/**
 Initsomething
 */
- (void)initial {
    [self initDatabase];
    self.format = [[NSDateFormatter alloc] init];
    self.format.dateFormat = @"yyymmddhhmmss";
}

/**
 Init database.
 */
- (void)initDatabase {
//    self.queue = dispatch_queue_create("LLDebugTool.LLStorageManager", DISPATCH_QUEUE_CONCURRENT);
    self.registerClass = [[NSMutableArray alloc] init];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/YXStorageData"];
    self.folderPath = path;
    [self createDirectoryAtPath:self.folderPath];
    NSString *filePath = [self.folderPath stringByAppendingPathComponent:@"YXData.db"];
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:filePath];
}

- (BOOL)registerClass:(Class)cls {
    __block BOOL ret = NO;
    [_dbQueue inDatabase:^(FMDatabase * db) {
       ret = [db executeUpdate:[self createTableSQLFromClass:cls]];
       if (!ret) {
           NSLog(@"建表失败");
       }
    }];
    return ret;
}

- (BOOL)createDirectoryAtPath:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager  defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            
            return NO;
        }
        return YES;
    }
    return YES;
}

- (NSString *)tableNameFromClass:(Class)cls {
    return [NSString stringWithFormat:@"%@Table_%@",NSStringFromClass(cls),kDatabaseVersion];
}
- (NSString *)createTableSQLFromClass:(Class)cls {
    NSString *tableName = [NSString stringWithFormat:@"%@Table_%@",NSStringFromClass(cls),kDatabaseVersion];
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@ BLOB NOT NULL,%@ TEXT NOT NULL,%@ TEXT,%@ TEXT,%@ TEXT NOT NULL,%@ TEXT NOT NULL);",tableName,kObjectDataColumn,kIdentityColumn,KIdSecondLevelColumn,KIdThreeLevelColumn,kLaunchDateColumn,kDescriptionColumn];
}

- (NSString *)convertArrayToSQL:(NSArray *)array {
    NSMutableString *SQL = [[NSMutableString alloc] init];
    [SQL appendString:@"("];
    for (NSString *item in array) {
        [SQL appendFormat:@"\"%@\",",item];
    }
    [SQL deleteCharactersInRange:NSMakeRange(SQL.length - 1, 1)];
    [SQL appendString:@")"];
    return SQL;
}



@end
