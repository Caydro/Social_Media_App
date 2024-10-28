import 'package:collagiey/Core/NamesOfApp.dart';

class ApiActionsLink {
  static const String signUpLink =
      "http://${NamesOfApp.ipHost}/collagiey/auth/signUp.php";
  static const String signInLink =
      "http://${NamesOfApp.ipHost}/collagiey/auth/signIn.php";
  static const String addPostWithNoPhotoApiLink =
      "http://${NamesOfApp.ipHost}/collagiey/posts/addPostbyUserIDWithNoPhoto.php";
  static const String showPostWithNoPhotoApiLink =
      "http://${NamesOfApp.ipHost}/collagiey/posts/myProfilePostsWithNoPhoto.php";
  static const String showPostWithNoPhotoForUsersApiLink =
      "http://${NamesOfApp.ipHost}/collagiey/posts/userProfilePostsWithNoPhoto.php";
  static const String showUsersInSearch =
      "http://${NamesOfApp.ipHost}/collagiey/friends/showAllUsersWithALetter.php";
  static const String addFriendRequest =
      "http://${NamesOfApp.ipHost}/collagiey/friends/addFriend/addSomeOneAsFriend.php";
  static const String checkForFriendRequest =
      "http://${NamesOfApp.ipHost}/collagiey/friends/addFriend/checkForFriendRequest.php";
  static const String myFriendRequests =
      "http://${NamesOfApp.ipHost}/collagiey/friends/addFriend/getMyFriendRequests.php";
  static const String deletingTheFriendRequest =
      "http://${NamesOfApp.ipHost}/collagiey/friends/deleteAddFriendRequestForSomeOne.php";
  static const String acceptFriendRequest =
      "http://${NamesOfApp.ipHost}/collagiey/friends/friendsList/acceptFriendRequest.php";
  static const String showHomePagePostsWithNoPhoto =
      "http://${NamesOfApp.ipHost}/collagiey/posts/homePagePosts.php";
  static const String deleteCircleBackground =
      "http://${NamesOfApp.ipHost}/collagiey/profile/deleteCircle_Background.php";
  static const String checkCirclePhotoExists =
      "http://${NamesOfApp.ipHost}/collagiey/profile/checkIfNoPhoto.php";
  static const String updateCircleBackground =
      "http://${NamesOfApp.ipHost}/collagiey/profile/changeCircleBackground.php";
  static const String updateCoverPhoto =
      "http://${NamesOfApp.ipHost}/collagiey/profile/coverBackground/addCoverBackground.php";
  static const String checkCoverPhoto =
      "http://${NamesOfApp.ipHost}/collagiey/profile/coverBackground/checkCoverBackgroundExist.php";
  static const String addTextStories =
      "http://${NamesOfApp.ipHost}/collagiey/story/addStoryTextByUserID.php";
  static const String addPhotoStories =
      "http://${NamesOfApp.ipHost}/collagiey/story/addStoryPhotoByUserID.php";
  static const String showHomePageStories =
      "http://${NamesOfApp.ipHost}/collagiey/story/showFriendsStoriesLimitOne.php";
  static const String showEveryUserStories =
      "http://${NamesOfApp.ipHost}/collagiey/story/showEveryUserStoryByUserID.php";
  static const String addLikeToAnyPost =
      "http://${NamesOfApp.ipHost}/collagiey/posts/activities/addLike.php";
  static const String deleteLikeToAnyPost =
      "http://${NamesOfApp.ipHost}/collagiey/posts/activities/deleteLike.php";
}
