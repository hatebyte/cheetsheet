//
//  ClueModel.h
//  KeyCheat
//
//  Created by hatebyte on 2/26/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PresentationModel;

@interface ClueModel : NSManagedObject

@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) NSString * data;
@property (nonatomic, retain) NSNumber * performanceIndex;
@property (nonatomic, retain) PresentationModel *presentation;

@end
