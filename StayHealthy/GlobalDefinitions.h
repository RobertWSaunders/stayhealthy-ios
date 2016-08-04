//
//  GlobalDefinitions.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-05.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

/***********************************/
#pragma mark - Application Standards
/***********************************/

#define APPNAME                             @"StayHealthy Fitness"
#define APPDELEGATE                         (AppDelegate *)[[UIApplication sharedApplication] delegate]

/******************/
#pragma mark - URLS
/******************/

#define WEBSITE_URL                         @"http://www.stayhealthy.io"
#define PRIVACY_URL                         @"http://mail.rsgc.on.ca/~rsaunders/privacy.html"
#define TERMS_URL                           @"http://mail.rsgc.on.ca/~rsaunders/terms.html"
#define DATABASE_URL                        @"http://mail.rsgc.on.ca/~rsaunders/StayHealthyDatabase.sqlite"
#define DATABASE_VERSION_URL                @"http://mail.rsgc.on.ca/~rsaunders/StayHealthyDatabaseVersion.txt"

/*******************/
#pragma mark - EMAIL
/*******************/

#define SUPPORT_EMAIL                       @"hello@stayhealthy.io"
#define FEEDBACK_EMAIL                      @"hello@stayhealthy.io"

/***************************/
#pragma mark - NOTIFICATIONS
/***************************/

#define CLOUD_UPDATE_NOTIFICATION           @"CLOUD_UPDATE_NOTIFICATION"

#define EXERCISE_UPDATE_NOTIFICATION        @"EXERCISE_UPDATE_NOTIFICATION"
#define EXERCISE_SAVE_NOTIFICATION          @"EXERCISE_SAVE_NOTIFICATION"

#define EXERCISE_LOG_SAVE_NOTIFICATION      @"EXERCISE_LOG_SAVE_NOTIFICATION"
#define EXERCISE_LOG_UPDATE_NOTIFICATION    @"EXERCISE_LOG_UPDATE_NOTIFICATION"
#define EXERCISE_LOG_DELETE_NOTIFICATION    @"EXERCISE_LOG_DELETE_NOTIFICATION"

#define EXERCISE_SET_LOG_SAVE_NOTIFICATION      @"EXERCISE_LOG_SAVE_NOTIFICATION"
#define EXERCISE_SET_LOG_UPDATE_NOTIFICATION    @"EXERCISE_LOG_UPDATE_NOTIFICATION"
#define EXERCISE_SET_LOG_DELETE_NOTIFICATION    @"EXERCISE_LOG_DELETE_NOTIFICATION"

#define CUSTOM_EXERCISE_SAVE_NOTIFICATION   @"CUSTOM_EXERCISE_SAVE_NOTIFICATION"
#define CUSTOM_EXERCISE_UPDATE_NOTIFICATION @"CUSTOM_EXERCISE_UPDATE_NOTIFICATION"
#define CUSTOM_EXERCISE_DELETE_NOTIFICATION @"CUSTOM_EXERCISE_DELETE_NOTIFICATION"

#define WORKOUT_UPDATE_NOTIFICATION         @"WORKOUT_UPDATE_NOTIFICATION"
#define WORKOUT_SAVE_NOTIFICATION           @"WORKOUT_SAVE_NOTIFICATION"

#define CUSTOM_WORKOUT_UPDATE_NOTIFICATION  @"CUSTOM_WORKOUT_UPDATE_NOTIFICATION"
#define CUSTOM_WORKOUT_SAVE_NOTIFICATION    @"CUSTOM_WORKOUT_SAVE_NOTIFICATION"
#define CUSTOM_WORKOUT_DELETE_NOTIFICATION  @"CUSTOM_WORKOUT_DELETE_NOTIFICATION"

#define WORKOUT_LOG_SAVE_NOTIFICATION       @"WORKOUT_LOG_SAVE_NOTIFICATION"
#define WORKOUT_LOG_UPDATE_NOTIFICATION     @"WORKOUT_LOG_UPDATE_NOTIFICATION"
#define WORKOUT_LOG_DELETE_NOTIFICATION     @"WORKOUT_LOG_DELETE_NOTIFICATION"

#define PREFERENCE_CHANGE_NOTIFICATION             @"PREFERENCE_NOTIFICATION"

/*********************************/
#pragma mark - Database Constants
/*********************************/

#define STAYHEALTHY_DATABASE_NAME           @"StayHealthyDatabase.sqlite"
#define STRENGTH_DB_TABLENAME               @"StayHealthyStrengthExercises"
#define WARMUP_DB_TABLENAME                 @"StayHealthyWarmupExercises"
#define STRETCHING_DB_TABLENAME             @"StayHealthyStretchingExercises"
#define WORKOUTS_DB_TABLENAME               @"StayHealthyWorkouts"
#define PRELOADED_DATABASE_VERSION          @"1.0.0"

/**************************/
#pragma mark - Screen Sizes
/**************************/

#define IS_IPAD                             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE                           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA                           ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH                        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH                   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH                   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS                 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5                         (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6                         (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P                        (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

/********************/
#pragma mark - Colors
/********************/

//-----------------------------
#pragma mark Difficulty Colors
//-----------------------------

#define INTERMEDIATE_BLUE_COLOR                  [UIColor colorWithRed:52.0f/255.2f green:152.0f/255.2f blue:219.0f/255.2f alpha:1]
#define EASY_GREEN_COLOR                         [UIColor colorWithRed:46.0f/255.2f green:204.0f/255.2f blue:113.0f/255.2f alpha:1]
#define HARD_RED_COLOR                           [UIColor colorWithRed:231.0f/255.2f green:76.0f/255.2f blue:60.0f/255.2f alpha:1]

//-----------------------------
#pragma mark Grey Scale Colors
//-----------------------------

#define WHITE_COLOR                         [UIColor colorWithRed:255.0f/255.2f green:255.0f/255.2f blue:255.0f/255.2f alpha:1]
#define LIGHT_GRAY_COLOR                    [UIColor colorWithRed:216.0f/255.2f green:216.0f/255.2f blue:216.0f/255.2f alpha:1]
#define DARK_GRAY_COLOR                     [UIColor colorWithRed:168.0f/255.2f green:168.0f/255.2f blue:168.0f/255.2f alpha:1]
#define SHADOW_COLOR                        [UIColor colorWithRed:237.0f/255.2f green:237.0f/255.2f blue:237.0f/255.2f alpha:1]

//------------------------
#pragma mark Module Colors
//------------------------

#define EXERCISES_COLOR                     [UIColor colorWithRed:56.0f/255.2f green:151.0f/255.2f blue:255.0f/255.2f alpha:1]
#define WORKOUTS_COLOR                      [UIColor colorWithRed:113.0f/255.2f green:90.0f/255.2f blue:255.0f/255.2f alpha:1]
#define JOURNAL_COLOR                       [UIColor colorWithRed:255.0f/255.2f green:170.0f/255.2f blue:39.0f/255.2f alpha:1]
#define LIKED_COLOR                         [UIColor colorWithRed:246.0f/255.2f green:36.0f/255.2f blue:89.0f/255.2f alpha:1]

/********************/
#pragma mark - Fonts
/********************/

#define STAYHEALTHY_FONT                    [UIFont fontWithName:STAYHEALTHY_FONTNAME size:20.0]

#define NAVIGATIONBAR_TITLE_FONT            [UIFont fontWithName:REGULAR_FONTNAME size:22.0]
#define NAVIGATIONBAR_BUTTON_FONT           [UIFont fontWithName:REGULAR_FONTNAME size:19.0]

#define TABLE_VIEW_TITLE_FONT               [UIFont fontWithName:REGULAR_FONTNAME size:18.0]
#define TABLE_VIEW_DETAIL_FONT              [UIFont fontWithName:REGULAR_BOOK_FONTNAME size:16.0]


#define TABLE_VIEW_SECTION_TITLE_FONT       [UIFont fontWithName:REGULAR_FONTNAME size:12];
#define tableViewUnderTitleTextFont         [UIFont fontWithName:REGULAR_LIGHT_FONTNAME size:14]
#define tableViewDetailTextFont             [UIFont fontWithName:REGULAR_LIGHT_FONTNAME size:16]
#define tableViewHeaderFont                 [UIFont fontWithName:REGULAR_LIGHT_FONTNAME size:15]




#define alertViewTitleFont                  [UIFont fontWithName:REGULAR_LIGHT_FONTNAME size:20]
#define alertViewButtonFont                 [UIFont fontWithName:REGULAR_LIGHT_FONTNAME size:18]
#define alertViewMessageFont                [UIFont fontWithName:REGULAR_LIGHT_FONTNAME size:16]
#define subtleFont                          [UIFont fontWithName:REGULAR_LIGHT_FONTNAME size:13]

//---------------------
#pragma mark Font Names
//---------------------

#define STAYHEALTHY_FONTNAME                @"Arista 2.0"

#define REGULAR_FONTNAME                    @"Avenir-Roman"
#define REGULAR_BOOK_FONTNAME               @"Avenir-Book"
#define REGULAR_MEDIUM_FONTNAME             @"Avenir-Medium"
#define REGULAR_LIGHT_FONTNAME              @"Avenir-Light"



/******************************/
#pragma mark - User Preferences
/******************************/

//------------------------------
#pragma mark General Preferences
//------------------------------

#define PREFERENCE_TUTORIAL_MESSAGES                @"userPreferredTutorialMessages"
#define PREFERENCE_DEFAULT_LAUNCH_MODULE            @"userPreferredLaunchModule"
#define PREFERENCE_AUTO_DATABASE_UPDATES            @"userPreferredAutoDatabaseUpdates"
#define PREFERENCE_LIST_VIEW                        @"userPreferredCollectionOrTable"

//------------------------------
#pragma mark Journal Preferences
//------------------------------

#define PREFERENCE_CALENDAR_WEEKS                   @"userPreferredCalendarWeeks"
#define PREFERENCE_HIGHLIGHT_WEEKENDS               @"userPreferredHighlightWeekends"
#define PREFERENCE_SIMPLE_MODE                      @"userPreferredSimpleMode"
#define PREFERENCE_CALENDAR_VIEW                    @"userPreferredCalendarView"
#define PREFERENCE_CALENDAR_SELECTED_DATE           @"userPreferredSelectedCalendarDate"

//--------------------------------
#pragma mark Exercises Preferences
//--------------------------------

#define PREFERENCE_INTELLIGENT_MODE                 @"userPreferredIntelligentMode"
#define PREFERENCE_ALWAYS_FOCUSED                   @"userPreferredAlwaysFocused"
#define PREFERENCE_SCIENTIFIC_NAMES                 @"userPreferredScientificNames"
#define PREFERENCE_DEFAULT_EXERCISES_VIEW                     @"userPreferredExercisesDefaultView"
#define PREFERENCE_EXERCISES_RECENTS_SHOWN                    @"userPreferredExercisesRecentsShown"

//-------------------------------
#pragma mark Workouts Preferences
//-------------------------------

#define PREFERENCE_WORKOUT_SECTIONS                 @"userPreferredWorkoutSections"
#define PREFERENCE_DEFAULT_WORKOUTS_VIEW                     @"userPreferredWorkoutsDefaultView"

//----------------------------
#pragma mark Liked Preferences
//----------------------------

#define PREFERENCE_DEFAULT_LIKED_VIEW               @"userPreferredLikedDefaultView"

/********************************/
#pragma mark - User Default Keys
/********************************/

#define USER_INSTALLED_VERSION                          @"userInstalledVersion"

//--------------------------
#pragma mark First View Keys
//--------------------------

#define USER_FIRST_LAUNCH                               @"userFirstLaunchVersionTwo"
#define USER_FIRST_VIEW_FIND_EXERICSE                   @"userFirstViewFindExercise"
#define USER_FIRST_VIEW_FIND_EXERCISE_ADVANCED_SEARCH   @"userFirstViewFindExerciseAdvancedSearch"
#define USER_FIRST_VIEW_FIND_EXERCISE_SEARCHED          @"userFirstViewFindExerciseSearchedExercises"
#define USER_FIRST_VIEW_FIND_EXERCISE_DETAIL            @"userFirstViewFindExerciseDetail"
#define USER_FIRST_VIEW_WORKOUTS                        @"userFirstViewWorkouts"
#define USER_FIRST_VIEW_WORKOUTS_ADVANCED_SEARCH        @"userFirstViewWorkoutsAdvancedSearch"
#define USER_FIRST_VIEW_WORKOUTS_SEARCHED               @"userFirstViewWorkoutsSearchedWorkouts"
#define USER_FIRST_VIEW_WORKOUTS_DETAIL                 @"userFirstViewWorkoutsDetail"
#define USER_FIRST_VIEW_WORKOUTS_PERFORM                @"userFirstViewWorkoutsPerform"
#define USER_FIRST_VIEW_CREATE_WORKOUTS                 @"userFirstViewCreateWorkouts"
#define USER_FIRST_VIEW_EXERCISE_SELECTION              @"userFirstViewExerciseSelection"
#define USER_FIRST_VIEW_FAVORITES                       @"userFirstViewFavorites"
#define USER_INSTALLED_DATABASE_VERSION                 @"userInstalledDatabaseVersion"



typedef enum : NSUInteger {
    strength,
    stretching,
    warmup,
} exerciseType;

typedef enum : NSUInteger {
    targetSports,
    targetMuscles,
    workoutEquipment,
    workoutType,
    workoutDifficulty,
} workoutBrowseOptions;


typedef enum : NSUInteger {
    journal,
    exercises,
    workouts,
    liked,
} modules;

typedef enum : NSUInteger {
    bodyzone,
    recents,
    customExercises,
} exercisesModules;

typedef enum : NSUInteger {
    categories,
    customWorkouts,
} workoutModules;

typedef enum : NSUInteger {
    exercisesLiked,
    workoutsLiked,
} likedModules;

//Specifies the different types of exercise attributes.
typedef enum {
    primaryMuscle,
    secondaryMuscle,
    equipment,
    difficulty,
    forceType,
    mechanicType,
    exerciseTypes
} exerciseAttributes;

//------------------------------
#pragma mark Xcode Colors Set Up
//------------------------------

#define XCODE_COLORS_ESCAPE                 @"\033["
#define XCODE_COLORS_RESET_FG               XCODE_COLORS_ESCAPE @"fg;"
#define XCODE_COLORS_RESET                  XCODE_COLORS_ESCAPE @";"

#define LogDataOperation(frmt, ...)         NSLog((XCODE_COLORS_ESCAPE @"fg52,152,219;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataSuccess(frmt, ...)           NSLog((XCODE_COLORS_ESCAPE @"fg46,204,113;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataTentativeSuccess(frmt, ...)  NSLog((XCODE_COLORS_ESCAPE @"fg39,174,96;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataError(frmt, ...)             NSLog((XCODE_COLORS_ESCAPE @"fg231,76,60;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataWarning(frmt, ...)           NSLog((XCODE_COLORS_ESCAPE @"fg243,156,18;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogInfo(frmt, ...)                  NSLog((XCODE_COLORS_ESCAPE @"fg155,89,182;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

/************************/
#pragma mark - Protocols
/************************/

@protocol ExerciseSelectionDelegate <NSObject>

- (void)selectedExercises:(NSMutableArray*)selectedExercises;

@end

@protocol AdvancedSearchExerciseSelectionDelegate <NSObject>

- (void)advancedSelectedExercises:(NSMutableArray*)selectedExercises;

@end

@protocol ExerciseListExerciseSelectionDelegate <NSObject>

- (void)selectedExercises:(NSMutableArray*)selectedExercises;

@end

@protocol SelectionDelegate <NSObject>

- (void)selectedItemsWithCount:(NSMutableArray*)selectedItems indexPath:(NSIndexPath*)indexPath passedArrayCount:(NSInteger)passedArrayCount;

@end


@protocol LikedExercisesExerciseSelectionDelegate <NSObject>

- (void)selectedFavoriteExercises:(NSMutableArray*)selectedExercises;

@end

