//
//  TKDataFormValidator.h
//  TelerikUI
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

@class TKEntityProperty;

/**
 A protocol used to validate values when using TKDataForm.
 */
@protocol TKDataFormValidator <NSObject>
@required

/**
 Returns a response message based on the validation status of the property.
 */
@property (nonatomic, strong, readonly, nullable) NSString *validationMessage;

/**
 Defines the validation logic for a specific property.
 @param property The property to validate.
 */
- (BOOL)validateProperty:(TKEntityProperty * __nonnull)property;

@end
