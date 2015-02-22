# CYCoreData

CYCoreData makes use of the parent child relationships `NSManagedObjectContext` provides to hide the process of writing data to disk from the main runloop. With minimal rules, anyone can write a multithreaded coredata application that keeps screen interaction as snappy as possible, while avoiding race conditions that make parent/child contexts so unruly.

Included are several `NSManagedObject` category methods for reading and writing data. 
CYCoreData  seeks to minimize repetitive predicate/sortDescriptor code for the benefit of the developer.

The example project demonstrates the best practices for using CYCoreData with a networking framework like AFNetworking.



## Installation

CYCoreData is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

     pod 'CYCoreData', '~> 0.1.2'

## Documentation
For more see [http://cynicalcocoa.github.io/cycoredata/](http://cynicalcocoa.github.io/cycoredata/)


## Usage

#### Create and configure
_Optional: If the unique identifier for the model objects is not an int, and/or does not stick to the uid convention, configure immediately._

```
[CYCoreData configureModelUniqueIdentifier:@"uid" ofDataType:UniqueObjectValueTypeString withJSONSearchString:@"id"];
```

_The example app uses a subclass of CYCoreData in this manner so that a singleton instance can be used to access data anywhere._

```
CYCoreData *cyCoreData = [[CYCoreData alloc] initWithSqliteFileName:@"example_database" withModelFileName:@"ExampleModel"];
[cyCoreData createStoreAndManagedObjectModel];
```

### Save / Reset

**Synchronously** means the context that writes the changes to disk will use the blocking `performBlockAndWait`

```
[[cyCoreData tempContext] saveSynchronously];
```

**Asynchronously** means the context that writes the changes to disk will use the nonblocking `performBlock` and will return immediately

```
[[cyCoreData tempContext] saveAsynchronously];
```

**Reset** will clear the entire database. Back at square one. No need to configure again.

```
[cyCoreData reset]
```


### Write example
When writing to the database, create a new temporary context.<br/> 

```
NSManagedObjectContext *tempContext = [cyCoreData temporaryWriteContext];
```
Create or update your data next. 

```
NSDictionary *properties = @{ @"id": 24, @"first_name" :@"Scott", @"last_name" : @"Storch" }
User *user = [User updateOrCreateObjectInContext:tempContext withDictionary:properties];

// NOTE: updateOrCreateObjectInContext by default searches the dictionary passed in for
// the key @"id" and fetches the NSManagedObject(User) by propertyKey @"uid". To change this,
// use [configureModelUniqueIdentifier:ofDataType:withJSONSearchString:] mentioned above.
```

Then immediately call the `tempContext` save method.<br/>

```
[tempContext saveAsynchronously];
```


### Read example
After ```[tempContext saveAsynchronously];``` is called, feel free to read your data from the `[cyCoreData readContext]`. Use the read ```NSManagedObject+CYCoreData``` category methods for efficiency.

```
NSManagedObjectContext *readContext = [CYCoreData readContext];
NSArray *users = [User fetchAllInContext:readContext];
```
As long as this is done after the `tempContext` is saved, there will be no race condition. The changes from the `tempContext` have been pushed to the `readContext` and are ready to be queried by the main runloop.


 






## Acknowledgement
Much inspiration and knowledge that made CYCoreData possible came from these sources.

[http://www.cocoanetics.com/2012/07/multi-context-coredata/](http://www.cocoanetics.com/2012/07/multi-context-coredata/)

[Core-Data-Management-Pragmatic-Programmers](http://www.amazon.com/Core-Data-Management-Pragmatic-Programmers/dp/1937785084)

[JCDCoreData](https://github.com/jdriscoll/JCDCoreData)



## Author

hatebyte, hatebyte@gmail.com

## License

CYCoreData is available under the MIT license. See the LICENSE file for more info.

If we meet some day, and you like it, you can buy me a beer. 

Or send bitcoin!

![Alt text](./Assets/githubaddress.png?raw=true "send bitcoin address")