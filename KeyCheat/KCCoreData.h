//
//  KCCoreData.h
//  KeyCheat
//
//  Created by hatebyte on 2/26/15.
//  Copyright (c) 2015 Capture Media. All rights reserved.
//

#import "CYCoreData.h"

@interface KCCoreData : CYCoreData

@end


@interface NSManagedObjectContext (KCCoreDataInstance)

/** Calls a sychronous(performBlockAndWait) action to the top parent `NSManagedObjectContext` to write the changes to disk. Changes written to a `temporaryWriteContext` are immediately avaible through the `readContext`.
 *
 * @warning Only call from an `NSManagedObjectContext` returned from `[CYCoreData temporaryWriteContext]`.
 */
- (void)saveSynchronously;


/** Calls a asychronous(performBlock) action to the top parent `NSManagedObjectContext` to write the changes to disk. Changes written to a `temporaryWriteContext` are immediately avaible through the `readContext`.
 *
 * @warning Only call from an `NSManagedObjectContext` returned from `[CYCoreData temporaryWriteContext]`.
 */
- (void)saveAsynchronously;

@end