//
//  KCCoreData.m
//  KeyCheat
//
//  Created by hatebyte on 2/26/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

#import "KCCoreData.h"
#import "CYFixtureHelper.h"
#import "NSManagedObject+CYCoreData.h"
#import "NSManagedObjectContext+CYCoreData.h"

@implementation KCCoreData

static KCCoreData *_liason                                      = nil;
static dispatch_once_t _once_token                              = 0;

+ (instancetype)liason {
    if (_liason == nil) {
        dispatch_once(&_once_token, ^{
            _liason                                             = [[self alloc] initWithSqliteFileName:@"key_cheat_db"
                                                                                     withModelFileName:@"KeyCheat"];
            [_liason createStoreAndManagedObjectModel];
        });
    }
    return _liason;
}

+ (void)reset {
    NSAssert([self.class liason], @"Can't reset CYCoreData until configured. Use [configureDataBaseFileName:andModelFileName:inBundle:]");
    @synchronized(self) {
        [[KCCoreData liason] reset];
        _once_token                                             = 0;
        _liason                                                 = nil;
    }
}

- (id)initWithSqliteFileName:(NSString *)dataBaseFileName withModelFileName:(NSString *)modelFileName inBundleName:(NSString *)bundleName {
    if (self= [super init]) {
        NSAssert(dataBaseFileName, @"Can't start up CYCoreData without DataBaseFile name. Use [configureDataBaseFileName:andModelFileName:inBundle:]");
        NSAssert(modelFileName, @"Can't start up CYCoreData without ModelFile name. Use [configureDataBaseFileName:andModelFileName:inBundle:]");
        
        self.dataBaseFile                                       = dataBaseFileName;
        self.modelFile                                          = modelFileName;
        self.bundleName                                         = bundleName;
        
    }
    return self;
}

@end



@implementation NSManagedObjectContext (CYCoreDataInstance)

- (void)saveSynchronously {
    [self saveAndWait:YES];
}

- (void)saveAsynchronously {
    [self saveAndWait:NO];
}

- (void)saveAndWait:(BOOL)wait {
    NSError *error                                              = nil;
    [self save:&error];
    if (error) {
        NSLog(@"Error saving tempContext: %@", error);
    }
    [KCCoreData saveContextAndWait:wait];
}


@end
