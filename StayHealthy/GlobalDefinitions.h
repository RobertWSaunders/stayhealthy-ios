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

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;"
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"

#define LogDataOperation(frmt, ...)    NSLog((XCODE_COLORS_ESCAPE @"fg52,152,219;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataSuccess(frmt, ...)       NSLog((XCODE_COLORS_ESCAPE @"fg46,204,113;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataError(frmt, ...)      NSLog((XCODE_COLORS_ESCAPE @"fg231,76,60;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogDataWarning(frmt, ...)      NSLog((XCODE_COLORS_ESCAPE @"fg243,156,18;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)


#define LogInfo(frmt, ...)      NSLog((XCODE_COLORS_ESCAPE @"fg155,89,182;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

/** The applications name */
#define APPNAME                    @"StayHealthy"
/*!
 * @constant  The applications website url.
 */
#define WEBSITE                    @"stayhealthyapp.com"
/*!
 * @constant  The applications iOS developer.
 */
#define IOSDEVELOPER               @"Robert Saunders"
/*!
 * @constant  @return The applications Android developer.
 */
#define ANDROIDDEVELOPER           @"Cameron Connor"
/*!
 * @constant  Reference to the applications delegate.
 */
#define APPDELEGATE                (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define FACEBOOK_URL                @"http://www.facebook.com/stayhealthyapp"

#define TWITTER_URL                 @"http://twitter.com/stayhealthyapp"

#define TUMBLR_URL                  @"http://stayhealthyapp.tumblr.com"

#define PRIVACY_URL                  @"http://mail.rsgc.on.ca/~rsaunders/privacy.html"

#define TERMS_URL                  @"http://mail.rsgc.on.ca/~rsaunders/terms.html"

/*********************************/
#pragma mark - Database Constants
/*********************************/

/*!
 * @constant  File name for StayHealthy's database.
 */
#define STAYHEALTHY_DATABASE_NAME       @"StayHealthyDatabase.sqlite"
/*!
 * @constant  Strength exercises table name in the database.
 */
#define STRENGTH_DB_TABLENAME           @"StayHealthyStrengthExercises"
/*!
 * @constant Warmup exercises table name in the database.
 */
#define WARMUP_DB_TABLENAME             @"StayHealthyWarmupExercises"
/*!
 * @constant  Stretching exercises table name in the database.
 */
#define STRETCHING_DB_TABLENAME         @"StayHealthyStretchingExercises"
/*!
 *@constant  Workouts table name in the database.
 */
#define WORKOUTS_DB_TABLENAME           @"StayHealthyWorkouts"

/***************************/
#pragma mark - Screen Sizes
/***************************/

#define IS_IPAD                     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA                   ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH                ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT               ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH           (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH           (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS         (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
//IS IPHONE 4
#define IS_IPHONE_5                 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
//IS IPHONE 5
#define IS_IPHONE_6                 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
//IS IPHONE 6
#define IS_IPHONE_6P                (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
//IS IPHONE 6P

//////////////////////////////////////////////////////////////////////////////////////////////////////
//StayHealthy Colors
//////////////////////////////////////////////////////////////////////////////////////////////////////

#define STAYHEALTHY_BLUE            [UIColor colorWithRed:52.0f/255.2f green:152.0f/255.2f blue:219.0f/255.2f alpha:1]
//STAYHEALTHY BLUE
#define STAYHEALTHY_DARKERBLUE      [UIColor colorWithRed:41.0f/255.2f green:128.0f/255.2f blue:185.0f/255.2f alpha:1]
//STAYHEALTHY BLUE (INTERMEDIATE COLOR)
#define STAYHEALTHY_GREEN           [UIColor colorWithRed:46.0f/255.2f green:204.0f/255.2f blue:113.0f/255.2f alpha:1]
//STAYHEALTHY GREEN (EASY COLOR)
#define STAYHEALTHY_RED             [UIColor colorWithRed:231.0f/255.2f green:76.0f/255.2f blue:60.0f/255.2f alpha:1]
//STAYHEALTHY RED (HARD COLOR)
#define STAYHEALTHY_WHITE           [UIColor colorWithRed:236.0f/255.2f green:240.0f/255.2f blue:241.0f/255.2f alpha:1]
//STAYHEALTHY WHITE

#define STAYHEALTHY_LIGHTGRAYCOLOR  [UIColor lightGrayColor]
#define STAYHEALTHY_DARKGRAYCOLOR   [UIColor darkGrayColor]

//////////////////////////////////////////////////////////////////////////////////////////////////////
//StayHealthy Fonts and Sizes
//////////////////////////////////////////////////////////////////////////////////////////////////////

#define STAYHEALTHY_FONT             [UIFont fontWithName:STAYHEALTHY_FONTNAME size:20.0]
//STAYHEALTHY LOGO FONT

#define STAYHEALTHY_NAVBARFONT       [UIFont fontWithName:regularLightFontName size:20.0]
//FONT FOR NAVIGATION BAR
#define STAYHEALTHY_NAVBARBUTTONFONT [UIFont fontWithName:regularFontName size:17.0]
//FONT FOR NAVIGATION BAR BUTTONS

//TableView Fonts
#define tableViewTitleTextFont       [UIFont fontWithName:regularFontName size:16]
//FONT FOR TABLEVIEW TITLES
#define tableViewUnderTitleTextFont  [UIFont fontWithName:regularLightFontName size:14]
//FONT FOR TABLEVIEW TITLES UNDER TITLE
#define tableViewDetailTextFont      [UIFont fontWithName:regularLightFontName size:16]
//FONT FOR TABLEVIEW DETAIL TEXT
#define tableViewHeaderFont          [UIFont fontWithName:regularLightFontName size:15]

//AlertView Fonts
#define alertViewTitleFont           [UIFont fontWithName:regularLightFontName size:20]
//FONT FOR ALERTVIEW TITLE
#define alertViewButtonFont          [UIFont fontWithName:regularLightFontName size:18]
//FONT FOR ALERTVIEW BUTTON
#define alertViewMessageFont         [UIFont fontWithName:regularLightFontName size:16]
//FONT FOR ALERTVIEW MESSAGE

#define subtleFont                   [UIFont fontWithName:regularLightFontName size:13]
//FONT FOR SUBTLE LABELS (LIKE IN SETTINGS)

//////////////////////////////////////////////////////////////////////////////////////////////////////
//StayHealthy Fonts Names
//////////////////////////////////////////////////////////////////////////////////////////////////////

#define STAYHEALTHY_FONTNAME         @"Arista 2.0"
//STAYHEALTHY LOGO FONT NAME

#define regularFontName              @"Avenir"
//REGULAR FONT
#define regularLightFontName         @"Avenir-Light"
//REGULAR LIGH FONT

//////////////////////////////////////////////////////////////////////////////////////////////////////
//CollectionViewCells
//////////////////////////////////////////////////////////////////////////////////////////////////////

//Exercise Cells
#define SMALLCELL                   CGSizeMake(137.f, 205.f)
#define MEDIUMCELL                  CGSizeMake(160.f, 225.f)
#define LARGECELL                   CGSizeMake(180.f, 244.f)

#define LARGEINSETS                 UIEdgeInsetsMake(18, 18, 18, 18)
#define SMALLINSETS                 UIEdgeInsetsMake(15, 15, 15, 15)

//////////////////////////////////////////////////////////////////////////////////////////////////////
//UITableView
//////////////////////////////////////////////////////////////////////////////////////////////////////

//Exercise Cells
#define UITABLEVIEWCELL_HEIGHT       60


//////////////////////////////////////////////////////////////////////////////////////////////////////
//User Defaults Keys
//////////////////////////////////////////////////////////////////////////////////////////////////////

#define PREFERENCE_TUTORIAL_MESSAGES                @"userPreferredTutorialMessages"
#define PREFERENCE_LIST_ORIENTATION                 @"userPreferredListOrientation"
#define PREFERENCE_FINDEXERCISE_MODULE              @"userPreferredFindExerciseModule"
#define PREFERENCE_FINDEXERCISE_SCIENTIFIC_NAMES    @"userPreferredFindExerciseScientificNames"
#define PREFERENCE_WORKOUT_MODULE                   @"userPreferredWorkoutModule"
#define PREFERENCE_FAVOURITES_MODULE                @"userPreferredFavouritesModule"
#define PREFERENCE_DEFAULT_HOME_MODULE              @"userPreferredHomeModule"
#define PREFERENCE_RECENTLY_VIEWED_QUANTITY         @"userPreferredRecentlyViewedQuantity"
#define PREFERENCE_AUTO_DATABASE_UPDATES            @"userPreferredAutoDatabaseUpdates"
#define PREFERENCE_FAVORITES_NOFAVMESSAGES          @"userPreferredFavoritesMessages"
#define PREFERENCE_SHOW_TIMES_VIEWED                @"userPreferredShowTimesViewed"

#define USER_FIRST_LAUNCH                           @"userFirstLaunch"
#define USER_FIRST_VIEW_FIND_EXERICSE               @"userFirstViewFindExercise"
#define USER_FIRST_VIEW_ADVANCED_SEARCH             @"userFirstViewFindExerciseAdvancedSearch"
#define USER_FIRST_VIEW_FIND_EXERCISE_SEARCHED      @"userFirstViewFindExerciseSearchedExercises"
#define USER_FIRST_VIEW_FIND_EXERCISE_DETAIL        @"userFirstViewFindExerciseDetail"

#define USER_FIRST_VIEW_FAVORITES                   @"userFirstViewFavorites"



#define WARMUP_EXERCISES_TABLE_NAME      @"StayHealthyWarmupExercises"
#define STRENGTH_EXERCISES_TABLE_NAME    @"StayHealthyStrengthExercises"
#define STRETCHING_EXERCISES_TABLE_NAME  @"StayHealthyStretchingExercises"



typedef enum : NSUInteger {
    strength,
    stretching,
    warmup,
} exerciseTypes;

