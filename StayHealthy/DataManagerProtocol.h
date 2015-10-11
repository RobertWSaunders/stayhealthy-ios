/**
 `DataManagerProtocol` declares methods that a StayHealthy data manager must implement so that they can perform data operations. Data operations include but are not limited to saving, deleting and updating records in the Core Data persistent store. The protocol also has all of the Core Data entity names as constants so the data managers have access to them.
 */

#import <Foundation/Foundation.h>

//Exercise Entity Name
#define EXERCISE_ENTITY_NAME             @"Exercise"
//Workout Entity Name
#define WORKOUT_ENTITY_NAME              @"Workout"
//Custom Workout Entity Name
#define CUSTOM_WORKOUT_ENTITY_NAME       @"CustomWorkout"

@protocol DataManagerProtocol <NSObject>

/**
 Saves a business object to the Core Data persistent store. Handles the mapping from business object to Core Data object.
 @param object Business object to be saved to the Core Data persistent store.
 */
- (void)saveItem:(id)object;

/**
 Updates a business object to the Core Data persistent store. Handles the mapping from business object to Core Data object.
 @param object Business object to be updated in the Core Data persistent store.
 */
- (void)updateItem:(id)object;

/**
 Deletes a object from the Core Data persistent store. Handles the mapping from business object to Core Data object.
 @param object Business object to be deleted in the Core Data persistent store.
 */
- (void)deleteItem:(id)object;

/**
 Deletes a object from the Core Data persistent store by its identifier. Handles the mapping from business object to Core Data object.
 @param objectIdentifier Business object to be deleted in the Core Data persistent store.
 */
- (void)deleteItemById:(NSString *)objectIdentifier;

/**
 Deletes all items in the Core Data persistent store.
 */
- (void)deleteAllItems;

/**
 Fetches a business object from the Core Data persistent store by it's identifier.
 @param objectIdentifier The identifier to look for.
 @return A business object with the identifier equal to `objectIdentifier`, only if can be found.
 @warning Can return `nil` if the object with the identifier does not exist in the Core Data persistent store.
 */
- (id)fetchItemByIdentifier:(NSString *)objectIdentifier;

/**
 Fetches all of the records in the table.
 @return All records in the table.
 */
- (NSArray *)fetchAllRecords;

/**
 Returns the entity name for the given data manager.
 @return The entity name.
 */
- (NSString *)returnEntityName;

/**
 Returns the count of all of the items in the table.
 @return Count of all items in the table inside of the database.
 */
- (NSUInteger) getTableCount;

@end
