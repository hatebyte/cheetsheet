//
//  PresentationModel.h
//  KeyCheat
//
//  Created by hatebyte on 2/26/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClueModel;

@interface PresentationModel : NSManagedObject

@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSNumber * isDraft;
@property (nonatomic, retain) NSSet *clues;
@end

@interface PresentationModel (CoreDataGeneratedAccessors)

- (void)addCluesObject:(ClueModel *)value;
- (void)removeCluesObject:(ClueModel *)value;
- (void)addClues:(NSSet *)values;
- (void)removeClues:(NSSet *)values;

@end
