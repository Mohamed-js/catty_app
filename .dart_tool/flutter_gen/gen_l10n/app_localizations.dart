
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Add New Message
  ///
  /// In en, this message translates to:
  /// **'Add New Message'**
  String get lbl_Add_new_message;

  /// Search Message,Match
  ///
  /// In en, this message translates to:
  /// **'Search Message, Match...'**
  String get hint_Searchlbl_Search_Message_match;

  /// New Matches
  ///
  /// In en, this message translates to:
  /// **'New Matches'**
  String get lbl_New_Matches;

  /// All Messages
  ///
  /// In en, this message translates to:
  /// **'All Messages'**
  String get lbl_All_Messages;

  /// Add story
  ///
  /// In en, this message translates to:
  /// **'Add story'**
  String get lbl_Add_Story;

  /// Create Story
  ///
  /// In en, this message translates to:
  /// **'Create Story'**
  String get lbl_create_story;

  /// Text
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get lbl_Text;

  /// Aa
  ///
  /// In en, this message translates to:
  /// **'Aa'**
  String get lbl_Aa;

  /// Media
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get lbl_Media;

  /// Create
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get btn_create;

  /// Done
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get lbl_done;

  /// Start Typing
  ///
  /// In en, this message translates to:
  /// **'Start Typing'**
  String get lbl_hint_start_typing;

  /// Add Your Story
  ///
  /// In en, this message translates to:
  /// **'Add Your Story'**
  String get lbl_Add_your_Story;

  /// All
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get lbl_Tab_All;

  /// Online
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get lbl_Tab_Online;

  /// New Daters
  ///
  /// In en, this message translates to:
  /// **'New Daters'**
  String get lbl_Tab_new_daters;

  /// Liked You
  ///
  /// In en, this message translates to:
  /// **'Liked You'**
  String get lbl_Tab_liked_you;

  /// Description
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get lbl_desc;

  /// Intrested Viewers
  ///
  /// In en, this message translates to:
  /// **'Intrested Viewers'**
  String get lbl_intrestes_viewers;

  /// Buy Ticket(s)
  ///
  /// In en, this message translates to:
  /// **'Buy Ticket(s)'**
  String get btn_buy_tickets;

  /// Type Message
  ///
  /// In en, this message translates to:
  /// **'Type Message'**
  String get lbl_hint_chat_type_msg;

  /// Dating Matches
  ///
  /// In en, this message translates to:
  /// **'Dating Matches'**
  String get lbl_dating_matches;

  /// Check out lists of matches & keep enjoing
  ///
  /// In en, this message translates to:
  /// **'Check out lists of matches & keep enjoing'**
  String get lbl_check_out_list_of_matches_keep_enjoying;

  /// You Liked
  ///
  /// In en, this message translates to:
  /// **'You Liked'**
  String get lbl_tab_you_likes;

  /// Views
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get lbl_tab_views;

  /// Filter Options
  ///
  /// In en, this message translates to:
  /// **'Filter Options'**
  String get lbl_filter_options;

  /// Manage and set your preferances to find the best matches for you, keep enjoying!
  ///
  /// In en, this message translates to:
  /// **'Manage and set your preferances to find the best matches for you, keep enjoying!'**
  String get lbl_filter_options_subtitle;

  /// Here to
  ///
  /// In en, this message translates to:
  /// **'Here to'**
  String get lbl_here_to;

  /// Want to meet
  ///
  /// In en, this message translates to:
  /// **'Want to Meet'**
  String get lbl_want_to_meet;

  /// Prefer Age Range
  ///
  /// In en, this message translates to:
  /// **'Prefer Age Range'**
  String get lbl_prefer_age_range;

  /// Prefer Language(s)
  ///
  /// In en, this message translates to:
  /// **'Prefer Language(s)'**
  String get lbl_prefer_language;

  /// Location
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get lbl_location;

  /// Distance Range
  ///
  /// In en, this message translates to:
  /// **'Distance Range'**
  String get lbl_distance_range;

  /// Advance Filter Options
  ///
  /// In en, this message translates to:
  /// **'Advance Filter Options'**
  String get lbl_advance_filter_options;

  /// Apply Filters
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get btn_apply_filters;

  /// Hello Friends!
  ///
  /// In en, this message translates to:
  /// **'Hello Friends!'**
  String get lbl_hello_friends;

  /// Pictures
  ///
  /// In en, this message translates to:
  /// **'Pictures'**
  String get lbl_tab_pictures;

  /// Videos
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get lbl_tab_videos;

  /// Bio
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get lbl_tab_Bio;

  /// More
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get lbl_tab_more;

  /// Intrests
  ///
  /// In en, this message translates to:
  /// **'Intrests'**
  String get lbl_intrests;

  /// Get Started
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get lbl_get_started;

  /// Likes, Intrests
  ///
  /// In en, this message translates to:
  /// **'Likes, Intrests'**
  String get lbl_likes_intrets;

  /// Share your likes & possion with others
  ///
  /// In en, this message translates to:
  /// **'Share your likes & possion with others'**
  String get lbl_likes_intrets_subtitle;

  /// Load More
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get lbl_load_more;

  /// Continue
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btn_continue;

  /// Skip
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get btn_skip;

  /// No description provided for @lbl_location_subtitle1.
  ///
  /// In en, this message translates to:
  /// **'Let the app locate you to provide best'**
  String get lbl_location_subtitle1;

  /// searched results around you
  ///
  /// In en, this message translates to:
  /// **'searched results around you'**
  String get lbl_location_subtitle2;

  /// Current Location
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get lbl_current_location;

  /// Search New Location
  ///
  /// In en, this message translates to:
  /// **'Search New Location'**
  String get lbl_search_location_hint;

  /// powered by
  ///
  /// In en, this message translates to:
  /// **'powered by'**
  String get lbl_powered_by;

  /// Login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get lbl_login;

  /// Please enter your valid mobile number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your valid mobile number.'**
  String get lbl_login_subtitle1;

  /// We will send you a 4-digit code to verify
  ///
  /// In en, this message translates to:
  /// **'We will send you a 4-digit code to verify'**
  String get lbl_login_subtitle2;

  /// Submit
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get btn_submit;

  /// OR
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get lbl_or;

  /// Login Using
  ///
  /// In en, this message translates to:
  /// **'Login Using'**
  String get lbl_login_using;

  /// About
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get lbl_short_bio;

  /// My Bio
  ///
  /// In en, this message translates to:
  /// **'My Bio'**
  String get lbl_tab_mybio;

  /// Notifications
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get lbl_notifications;

  /// Check notifications, respond & keep dating
  ///
  /// In en, this message translates to:
  /// **'Check notifications, respond & keep up'**
  String get lbl_notifications_subtitle;

  /// Payments
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get lbl_payment;

  /// Complete Your Payment to enjoy the most
  ///
  /// In en, this message translates to:
  /// **'Complete Your Payment to enjoy the most'**
  String get lbl_payment_subtitle1;

  /// Saved Payment options
  ///
  /// In en, this message translates to:
  /// **'Saved Payment options'**
  String get lbl_payment_subtitle2;

  /// Add New Payment Option
  ///
  /// In en, this message translates to:
  /// **'Add New Payment Option'**
  String get lbl_add_new_payment_options;

  /// Pay Now
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get btn_pay_now;

  /// Plan Dating
  ///
  /// In en, this message translates to:
  /// **'Plan Dating'**
  String get lbl_plan_dating;

  /// Reserve seat, place, book tickets etc to make your dating even more exciting..
  ///
  /// In en, this message translates to:
  /// **'Reserve seat, place, book tickets etc to make your dating even more exciting..'**
  String get lbl_plan_dating_subtitle;

  /// Popular
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get lbl_tab_popular;

  /// Events
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get lbl_tab_events;

  /// Parties
  ///
  /// In en, this message translates to:
  /// **'Parties'**
  String get lbl_tab_parties;

  /// Festivals
  ///
  /// In en, this message translates to:
  /// **'Festivals'**
  String get lbl_tab_festivals;

  /// Profile Details
  ///
  /// In en, this message translates to:
  /// **'Profile Details'**
  String get lbl_profile_details;

  /// Fill up the following details
  ///
  /// In en, this message translates to:
  /// **'Fill up the following details'**
  String get lbl_profile_details_subtitle;

  /// First Name
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get lbl_first_name_hint;

  /// Last Name
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lbl_last_name_hint;

  /// DOB
  ///
  /// In en, this message translates to:
  /// **'DOB'**
  String get lbl_dob_hint;

  /// Select Gender
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get lbl_gender_hint;

  /// dating
  ///
  /// In en, this message translates to:
  /// **'dating'**
  String get lbl_reward_dating;

  /// Get boosts to increase your matches!
  ///
  /// In en, this message translates to:
  /// **'Get boosts to increase your matches!'**
  String get lbl_reward_get_boost;

  /// BOOST ME
  ///
  /// In en, this message translates to:
  /// **'BOOST ME'**
  String get btn_boost_me;

  /// No description provided for @lbl_plan_select.
  ///
  /// In en, this message translates to:
  /// **'For Best Access'**
  String get lbl_plan_select;

  /// No description provided for @lbl_plan_select_subtitle1.
  ///
  /// In en, this message translates to:
  /// **'Subscribe a Plan'**
  String get lbl_plan_select_subtitle1;

  /// No description provided for @lbl_plan_select_subtitle2.
  ///
  /// In en, this message translates to:
  /// **'Top features you will get'**
  String get lbl_plan_select_subtitle2;

  /// Select Your Plan
  ///
  /// In en, this message translates to:
  /// **'Select Your Plan'**
  String get lbl_select_your_plan;

  /// Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get lbl_settings;

  /// Manage your settings for best app use
  ///
  /// In en, this message translates to:
  /// **'Manage your settings for best app use'**
  String get lbl_settings_subtitle;

  /// Account
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get lbl_account;

  /// Likes & Liked
  ///
  /// In en, this message translates to:
  /// **'Likes & Liked'**
  String get lbl_likes_likes;

  /// Manage Subscriptions
  ///
  /// In en, this message translates to:
  /// **'Manage Subscriptions'**
  String get lbl_subscription;

  /// Dating Rewards
  ///
  /// In en, this message translates to:
  /// **'Dating Rewards'**
  String get lbl_dating_rewards;

  /// Message Options
  ///
  /// In en, this message translates to:
  /// **'Message Options'**
  String get lbl_msg_options;

  /// Manage Matches
  ///
  /// In en, this message translates to:
  /// **'Manage Matches'**
  String get lbl_manage_matches;

  /// Privacy Options
  ///
  /// In en, this message translates to:
  /// **'Privacy Options'**
  String get lbl_privacy_options;

  /// Delete Account
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get lbl_delete_account;

  /// Mode
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get lbl_mode;

  /// Safety
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get lbl_safety;

  /// Help Centre
  ///
  /// In en, this message translates to:
  /// **'Help Centre'**
  String get lbl_help_centre;

  /// Terms & Conditions
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get lbl_terms_cond;

  /// Privacy Policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get lbl_policy;

  /// Congrats!
  ///
  /// In en, this message translates to:
  /// **'Congrats!'**
  String get lbl_congrats;

  /// Its a match!
  ///
  /// In en, this message translates to:
  /// **'Its a match!'**
  String get lbl_its_match;

  /// Start Coversation
  ///
  /// In en, this message translates to:
  /// **'Start Coversation'**
  String get lbl_coversation;

  /// Keep Dating
  ///
  /// In en, this message translates to:
  /// **'Keep Dating'**
  String get lbl_keep_dating;

  /// Online Animals App
  ///
  /// In en, this message translates to:
  /// **'Online Animals App'**
  String get lbl_online_dating_app;

  /// Find Your Animal's
  ///
  /// In en, this message translates to:
  /// **'Find Your Animal\'s'**
  String get lbl_start_dating_subtitle1;

  /// Best Match
  ///
  /// In en, this message translates to:
  /// **'Best Match'**
  String get lbl_start_dating_subtitle2;

  /// Start Dating
  ///
  /// In en, this message translates to:
  /// **'Start Dating'**
  String get lbl_start_dating;

  /// Start Now
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get lbl_start_now;

  /// Be Patient
  ///
  /// In en, this message translates to:
  /// **'Be Patient'**
  String get lbl_be_patient;

  /// Dont loose heart, keep browsing to
  ///
  /// In en, this message translates to:
  /// **'Dont loose heart, keep browsing to'**
  String get lbl_dont_loose;

  /// find your best match
  ///
  /// In en, this message translates to:
  /// **'find your best match'**
  String get lbl_find_your_best;

  /// Start Swiping
  ///
  /// In en, this message translates to:
  /// **'Start Swiping'**
  String get lbl_start_swipping;

  /// Upload ID
  ///
  /// In en, this message translates to:
  /// **'Upload ID'**
  String get lbl_upload_id;

  /// Upload Document
  ///
  /// In en, this message translates to:
  /// **'Upload Document'**
  String get lbl_upload_doc;

  /// Verify
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get lbl_verify;

  /// Please enter the 4-digit code
  ///
  /// In en, this message translates to:
  /// **'Please enter the 4-digit code'**
  String get lbl_4_digit_entre;

  /// sent to your number
  ///
  /// In en, this message translates to:
  /// **'sent to your number'**
  String get lbl_sent_to_num;

  /// Resend OTP
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get lbl_resend_otp;

  /// View Plans
  ///
  /// In en, this message translates to:
  /// **'View Plans'**
  String get btn_view_plan;

  /// Hello User
  ///
  /// In en, this message translates to:
  /// **'Hello User'**
  String get lbl_hello_user;

  /// Reply
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get lbl_reply_hint;

  /// Languages
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get lbl_lang;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
