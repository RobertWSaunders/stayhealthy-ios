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

#define APPNAME                         @"StayHealthy"
#define APPDELEGATE                     (AppDelegate *)[[UIApplication sharedApplication] delegate]

/******************/
#pragma mark - URLS
/******************/

#define WEBSITE_URL                     @"http://stayhealthyapp.com"
#define FACEBOOK_URL                    @"http://www.facebook.com/stayhealthyapp"
#define TWITTER_URL                     @"http://twitter.com/stayhealthyapp"
#define TUMBLR_URL                      @"http://stayhealthyapp.tumblr.com"
#define PRIVACY_URL                     @"http://mail.rsgc.on.ca/~rsaunders/privacy.html"
#define TERMS_URL                       @"http://mail.rsgc.on.ca/~rsaunders/terms.html"
#define FAQ_URL                         @"http://mail.rsgc.on.ca/~rsaunders/terms.html"
#define DATABASE_URL                    @"http://mail.rsgc.on.ca/~rsaunders/StayHealthyDatabase.sqlite"
#define DATABASE_VERSION_URL            @"http://webservice.stayhealthyapp.com/StayHealthyDatabaseVersion.txt"

/*******************/
#pragma mark - EMAIL
/*******************/

#define SUPPORT_EMAIL                   @""
#define FEEDBACK_EMAIL                  @""

/***************************/
#pragma mark - NOTIFICATIONS
/***************************/

#define CLOUD_UPDATE_NOTIFICATION           @"CLOUD_UPDATE_NOTIFICATION"
#define EXERCISE_UPDATE_NOTIFICATION        @"EXERCISE_UPDATE_NOTIFICATION"
#define EXERCISE_SAVE_NOTIFICATION          @"EXERCISE_SAVE_NOTIFICATION"
#define WORKOUT_UPDATE_NOTIFICATION         @"WORKOUT_UPDATE_NOTIFICATION"
#define WORKOUT_SAVE_NOTIFICATION           @"WORKOUT_SAVE_NOTIFICATION"
#define CUSTOM_WORKOUT_UPDATE_NOTIFICATION  @"CUSTOM_WORKOUT_UPDATE_NOTIFICATION"
#define CUSTOM_WORKOUT_SAVE_NOTIFICATION    @"CUSTOM_WORKOUT_SAVE_NOTIFICATION"
#define CUSTOM_WORKOUT_DELETE_NOTIFICATION  @"CUSTOM_WORKOUT_DELETE_NOTIFICATION"

/*********************************/
#pragma mark - Database Constants
/*********************************/

#define STAYHEALTHY_DATABASE_NAME       @"StayHealthyDatabase.sqlite"
#define STRENGTH_DB_TABLENAME           @"StayHealthyStrengthExercises"
#define WARMUP_DB_TABLENAME             @"StayHealthyWarmupExercises"
#define STRETCHING_DB_TABLENAME         @"StayHealthyStretchingExercises"
#define WORKOUTS_DB_TABLENAME           @"StayHealthyWorkouts"
#define PRELOADED_DATABASE_VERSION      @"1.0.0"

/**************************/
#pragma mark - Screen Sizes
/**************************/

#define IS_IPAD                         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE                       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA                       ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH                    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                   ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH               (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH               (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS             (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5                     (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6                     (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P                    (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

/********************/
#pragma mark - Colors
/********************/

#define BLUE_COLOR                      [UIColor colorWithRed:52.0f/255.2f green:152.0f/255.2f blue:219.0f/255.2f alpha:1]
#define DARK_BLUE_COLOR                 [UIColor colorWithRed:41.0f/255.2f green:128.0f/255.2f blue:185.0f/255.2f alpha:1]
#define GREEN_COLOR                     [UIColor colorWithRed:46.0f/255.2f green:204.0f/255.2f blue:113.0f/255.2f alpha:1]
#define RED_COLOR                       [UIColor colorWithRed:231.0f/255.2f green:76.0f/255.2f blue:60.0f/255.2f alpha:1]
#define WHITE_COLOR                     [UIColor colorWithRed:236.0f/255.2f green:240.0f/255.2f blue:241.0f/255.2f alpha:1]
#define LIGHT_GRAY_COLOR                [UIColor lightGrayColor]
#define DARK_GRAY_COLOR                 [UIColor darkGrayColor]

/************************/
#pragma mark - Font Names
/************************/

#define STAYHEALTHY_FONTNAME            @"Arista 2.0"
#define regularFontName                 @"Avenir"
#define regularLightFontName            @"Avenir-Light"

/********************/
#pragma mark - Fonts
/********************/

#define STAYHEALTHY_FONT                [UIFont fontWithName:STAYHEALTHY_FONTNAME size:20.0]
#define NAVIGATIONBAR_TITLE_FONT        [UIFont fontWithName:regularLightFontName size:20.0]
#define NAVIGATIONBAR_BUTTON_FONT       [UIFont fontWithName:regularFontName size:18.0]
#define tableViewTitleTextFont          [UIFont fontWithName:regularFontName size:16]
#define tableViewUnderTitleTextFont     [UIFont fontWithName:regularLightFontName size:14]
#define tableViewDetailTextFont         [UIFont fontWithName:regularLightFontName size:16]
#define tableViewHeaderFont             [UIFont fontWithName:regularLightFontName size:15]
#define alertViewTitleFont              [UIFont fontWithName:regularLightFontName size:20]
#define alertViewButtonFont             [UIFont fontWithName:regularLightFontName size:18]
#define alertViewMessageFont            [UIFont fontWithName:regularLightFontName size:16]
#define subtleFont                      [UIFont fontWithName:regularLightFontName size:13]

/************************************/
#pragma mark - Collection View Cells
/************************************/

#define SMALLCELL                       CGSizeMake(137.f, 205.f)
#define MEDIUMCELL                      CGSizeMake(160.f, 225.f)
#define LARGECELL                       CGSizeMake(180.f, 244.f)
#define LARGEINSETS                     UIEdgeInsetsMake(18, 18, 18, 18)
#define SMALLINSETS                     UIEdgeInsetsMake(15, 15, 15, 15)

//////////////////////////////////////////////////////////////////////////////////////////////////////
//User Defaults Keys
//////////////////////////////////////////////////////////////////////////////////////////////////////

#define PREFERENCE_TUTORIAL_MESSAGES                @"userPreferredTutorialMessages"
#define PREFERENCE_FINDEXERCISE_MODULE              @"userPreferredFindExerciseModule"
#define PREFERENCE_WORKOUT_MODULE                   @"userPreferredWorkoutModule"
#define PREFERENCE_FAVOURITES_MODULE                @"userPreferredFavouritesModule"
#define PREFERENCE_DEFAULT_HOME_MODULE              @"userPreferredHomeModule"
#define PREFERENCE_RECENTLY_VIEWED_QUANTITY         @"userPreferredRecentlyViewedQuantity"
#define PREFERENCE_AUTO_DATABASE_UPDATES            @"userPreferredAutoDatabaseUpdates"


#define USER_FIRST_LAUNCH                               @"userFirstLaunch"
#define USER_FIRST_VIEW_FIND_EXERICSE                   @"userFirstViewFindExercise"
#define USER_FIRST_VIEW_FIND_EXERCISE_ADVANCED_SEARCH   @"userFirstViewFindExerciseAdvancedSearch"
#define USER_FIRST_VIEW_FIND_EXERCISE_SEARCHED          @"userFirstViewFindExerciseSearchedExercises"
#define USER_FIRST_VIEW_FIND_EXERCISE_DETAIL            @"userFirstViewFindExerciseDetail"

#define USER_FIRST_VIEW_FAVORITES                       @"userFirstViewFavorites"

#define USER_INSTALLED_DATABASE_VERSION                 @"userInstalledDatabaseVersion"



typedef enum : NSUInteger {
    strength,
    stretching,
    warmup,
} exerciseTypes;

typedef enum : NSUInteger {
    targetSports,
    targetMuscles,
    workoutEquipment,
    workoutType,
    workoutDifficulty,
} workoutBrowseOptions;



//------------------------------
#pragma mark Xcode Colors Set Up
//------------------------------

#define XCODE_COLORS_ESCAPE            @"\033["
#define XCODE_COLORS_RESET_FG          XCODE_COLORS_ESCAPE @"fg;"
#define XCODE_COLORS_RESET             XCODE_COLORS_ESCAPE @";"

#define LogDataOperation(frmt, ...)    NSLog((XCODE_COLORS_ESCAPE @"fg52,152,219;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataSuccess(frmt, ...)      NSLog((XCODE_COLORS_ESCAPE @"fg46,204,113;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataError(frmt, ...)        NSLog((XCODE_COLORS_ESCAPE @"fg231,76,60;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataWarning(frmt, ...)      NSLog((XCODE_COLORS_ESCAPE @"fg243,156,18;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogInfo(frmt, ...)             NSLog((XCODE_COLORS_ESCAPE @"fg155,89,182;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)