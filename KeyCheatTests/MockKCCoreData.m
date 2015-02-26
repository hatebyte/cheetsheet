//
//  MockKCCoreData.m
//  KeyCheat
//
//  Created by hatebyte on 2/26/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

#import "MockKCCoreData.h"

@implementation MockKCCoreData

static MockKCCoreData *_liason                                  = nil;
static dispatch_once_t _once_token                              = 0;

+ (instancetype)liason {
    if (_liason == nil) {
        dispatch_once(&_once_token, ^{
            _liason                                             = [[self alloc] initWithSqliteFileName:@"key_cheat_db_test"
                                                                                     withModelFileName:@"KeyCheat"];
            [_liason createStoreAndManagedObjectModel];
        });
    }
    return _liason;
}

- (id)initWithSqliteFileName:(NSString *)dataBaseFileName withModelFileName:(NSString *)modelFileName inBundleName:(NSString *)bundleName {
    if (self= [super init]) {
        NSAssert(dataBaseFileName, @"Can't start up CYCoreData without DataBaseFile name. Use [configureDataBaseFileName:andModelFileName:inBundle:]");
        NSAssert(modelFileName, @"Can't start up CYCoreData without ModelFile name. Use [configureDataBaseFileName:andModelFileName:inBundle:]");
        
        self.dataBaseFile                                       = dataBaseFileName;
        self.modelFile                                          = modelFileName;
        self.bundleName                                         = bundleName;
        
        _liason.isTest                                          = YES;

    }
    return self;
}

@end
