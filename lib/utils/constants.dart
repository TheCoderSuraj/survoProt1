import 'package:flutter/painting.dart';

const kPagePadding = EdgeInsets.all(10);
const kAppName = "Meme Life";
const kMinAppUpgraderVersion = "1.4.0";
const kAppPlayStoreLink =
    "https://play.google.com/store/apps/details?id=com.codykas.memelife";
const kPlayStoreDashboardLink =
    "https://play.google.com/store/apps/dev?id=8059038717375510913";

const kListOfSubredditLink =
    "https://www.reddit.com/r/ListOfSubreddits/wiki/listofsubreddits/";
const kRedditListLink = "https://redditlist.com/";
const kFeedbackFormLink =
    "https://docs.google.com/forms/d/e/1FAIpQLSf-YeVz_BfyfaHWDoP2gkZ6CYjhvvPuLZ0MMkXIoFc0IovNtA/viewform?usp=sf_link";
const kNoAd = false;
const kIsPremium = false;
const kRewardTimeInMin = 360; // 6 * 60
const kHistoryBoxHiveBox = "HistoryHiveBox";
const kFavoriteMemeHiveBox = "FavoriteMemeHiveBox";

const kMaxFavMemesLimit = 50;
const kMaxFavHistoryLimit = 50;

// shared pref ids
const kOnlySafeContentPrefBoolId = "Only Safe Content prefBool id";
const kFirstTimeUserPrefBoolId = "First Time User prefBool id";
const kAlwaysMutePrefBoolId = "Always Mute prefBool id";
const kAutoPlayPrefBoolId = "Auto Play prefBool id";
const kQuickAccessPrefIntId = "Quick Access prefInt id";
const kNoAdRewardTimePrefIntId = "No Ad Reward Time prefInt id";
const kVisualQualityDataPrefIntId = "Visual Quality Data prefInt id";
const kVisualQualityWifiPrefIntId = "Visual Quality Wifi prefInt id";
const kLastSubredditNamePrefStringId = "Last Subreddit Name prefString id";
const kLoginEmailPrefStringId = "Login Email Pref String Id";
const kLoginPasswordPrefStringId = "Login Password Pref String Id";

const kTotalQuickAccessOpts = 3;
const kQuickAccessLimit = 10;
const kAuthPagePadding = kPagePadding;
// const kTotalVisualQualityOpts = ;

// colors
// const kHighLightColor = Color(0x99C3F8FF);
const kHighLightColor = Color(0x5042C2FF);
// const kHighLightColor = Color(0xffEEF1FF);
const kBackGroundColor = Color(0x50FEF5AC);
// const kBackGroundColor = Color(0x64E1FFEE);
const kGrayBlueColor = Color(0xffAAC4FF);
const kLightBlueColor = Color(0xff42C2FF);
const kSettingItemColor = Color.fromARGB(100, 209, 234, 245);
const kWhiteColor = Color(0xffffffff);

// text styles
const kDefaultTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Color(0xC8000000),
);

const kBoldTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const kSemiBoldTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

const kTitleTextStyle = TextStyle(
  fontSize: 35,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
