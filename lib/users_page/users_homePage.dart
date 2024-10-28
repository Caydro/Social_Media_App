import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/friend_requests/friend_requestCubit.dart';
import 'package:collagiey/Cubit/friend_requests/friend_requestState.dart';
import 'package:collagiey/Cubit/posts/postsCubit.dart';
import 'package:collagiey/Cubit/posts/postsState.dart';
import 'package:collagiey/Home/mainHome.dart';
import 'package:collagiey/Service/reacting_with_posts.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:collagiey/Widgets/pendingDialog_widget.dart';
import 'package:collagiey/Widgets/post_No_Photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersHomePage extends StatefulWidget {
  const UsersHomePage({
    super.key,
    this.userCircleImage,
    this.userCoverBackground,
    this.user_id,
    this.userName,
  });

  final String? userCircleImage;
  final String? userCoverBackground;
  final int? user_id;
  final String? userName;

  @override
  State<UsersHomePage> createState() => _UsersHomePageState();
}

List<Map<String, dynamic>>? dataOfPostsWithOutPhoto;
int? myUserID;
int? otherUserID;

class _UsersHomePageState extends State<UsersHomePage> {
  cubitActivation() async {
    BlocProvider.of<PostsCubit>(context)
        .showUsersPostWithNoPhoto(userID: widget.user_id!);
    int userID = await SharedPrefrencesOptions().showUserID();
    BlocProvider.of<FriendRequestCubit>(context)
        .checkForFriendRequest(userID, widget.user_id!);
    myUserID = userID;
  }

  @override
  void initState() {
    cubitActivation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    otherUserID = widget.user_id;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: height * 0.42,
                      width: width,
                      child: Image.network(
                          CaydroImagesPath.customProfileCoverBackGroundNetwork),
                    ),
                    Positioned(
                      bottom: -50,
                      child: Padding(
                        padding: const EdgeInsets.all(17),
                        child: InkWell(
                          onTap: () {
                            // PERSONAL BACKGROUND PHOTO ACTIONS
                          },
                          hoverColor: CaydroColors.mainColor,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: NetworkImage(
                              "${MySqlImagePath.circlePhotoPath}/${widget.userCircleImage}",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // ALL ABOUT USER PROFILE
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: width * 0.2,
                    ), // Adjust padding to account for the CircleAvatar overlap
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.userName}",
                          style: CaydroTextStyles.normalRobotoStyle,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Text("777", style: CaydroTextStyles.numbersTextStyle),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "friends",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "splashFont",
                          color: Colors.grey,
                        ),
                      ),
                    ]),
                const Divider(),
                BlocBuilder<FriendRequestCubit, FriendRequestState>(
                  builder: (context, state) {
                    if (state is FriendRequestStateFailed) {
                      return addFriendButton(
                        height: height,
                        width: width,
                        myuserID: myUserID!,
                        otherUserID: widget.user_id!,
                      );
                    } else if (state is FriendRequestStateSuccess) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CaydroColors.mainColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.4, vertical: height * 0.02),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Pending",
                          style:
                              CaydroTextStyles.ElevatedButtonTextStyleSmallOne,
                        ),
                      );
                    } else if (state is FriendRequestStateLoading) {
                      return const CircularProgressIndicator(
                        color: CaydroColors.mainColor,
                      );
                    } else {
                      return addFriendButton(
                          height: height,
                          width: width,
                          myuserID: myUserID!,
                          otherUserID: widget.user_id!);
                    }
                  },
                ),
                BlocBuilder<PostsCubit, PostsCubitState>(
                  builder: (context, state) {
                    if (state is ShowPostWithNoPhotoForUsersCubitSuccess) {
                      dataOfPostsWithOutPhoto = state.data;
                      return postsWidget();
                    } else if (state
                        is ShowPostWithNoPhotoForUsersCubitFailed) {
                      return const Center(
                        child: Text(
                          "Failed to load user posts",
                          style: CaydroTextStyles.normalTextForAll,
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "No Posts yet",
                          style: CaydroTextStyles.normalTextForAll,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CaydroColors.mainColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(
                userID: myUserID!,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
    );
  }
}

Widget postsWidget() {
  return ListView.builder(
    shrinkWrap:
        true, // Important to make the ListView take only the space it needs
    physics:
        const NeverScrollableScrollPhysics(), // Disable scrolling for the ListView
    itemCount: dataOfPostsWithOutPhoto!.length,
    itemBuilder: (context, item) {
      String circlePhoto = dataOfPostsWithOutPhoto![item]['circlePhoto'];
      String nameOfUser = dataOfPostsWithOutPhoto![item]['nameOfUser'];
      String postString = dataOfPostsWithOutPhoto![item]['post_string'];
      int likesNumber = dataOfPostsWithOutPhoto![item]['likes'];
      String commentsNumber = dataOfPostsWithOutPhoto![item]['comments'];
      int sharesNumber = dataOfPostsWithOutPhoto![item]['ppl_share'];
      String timeOfThePost = dataOfPostsWithOutPhoto![item]['time'];
      int postID = dataOfPostsWithOutPhoto![item]['post_id'];
      DateTime dateOfPost = DateTime.parse(timeOfThePost);
      DateTime dateAndTimeNow = DateTime.now();
      Duration timeThatYouShared = dateAndTimeNow.difference(dateOfPost);

      return PostWithNoPhoto(
        imageuserOfPost: "${MySqlImagePath.circlePhotoPath}/$circlePhoto",
        nameOfUserPost: nameOfUser,
        onLikeButton: () {
          PostsReact().addLikeToAnyPostByPostIDAndUserID(
              postID: postID, userID: myUserID!);
        },
        onDisLikeButton: () {
          PostsReact().deleteLikeToAnyPostByPostIDAndUserID(
              postID: postID, userID: myUserID!);
        },
        postOfUser: postString,
        likes: likesNumber,
        numberOfComments: commentsNumber,
        numberOfShares: sharesNumber,
        time: timeThatYouShared < const Duration(minutes: 60)
            ? "${timeThatYouShared.inMinutes}m"
            : timeThatYouShared > const Duration(days: 1)
                ? "${timeThatYouShared.inDays}d"
                : "${timeThatYouShared.inHours}h",
      );
    },
  );
}

Widget addFriendButton(
    {required double width,
    required double height,
    required int myuserID,
    required int otherUserID}) {
  return BlocBuilder<FriendRequestCubit, FriendRequestState>(
    builder: (context, state) {
      if (state is CheckForFriendRequestStateThereIsNoRequest) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CaydroColors.mainColor,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.4, vertical: height * 0.02),
          ),
          onPressed: () {
            BlocProvider.of<FriendRequestCubit>(context)
                .makeFriendRequest(myuserID, otherUserID);
          },
          child: const Text(
            "Add Friend",
            style: CaydroTextStyles.ElevatedButtonTextStyleSmallOne,
          ),
        );
      } else if (state is CheckForFriendRequestStateThereIsRequest) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CaydroColors.mainColor,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.4, vertical: height * 0.02),
          ),
          onPressed: () {},
          child: const Text(
            "Pending",
            style: CaydroTextStyles.ElevatedButtonTextStyleSmallOne,
          ),
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: CaydroColors.mainColor,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.4, vertical: height * 0.02),
          ),
          onPressed: () {
            BlocProvider.of<FriendRequestCubit>(context)
                .makeFriendRequest(myuserID, otherUserID);
          },
          child: const Text(
            "Add Friend",
            style: CaydroTextStyles.ElevatedButtonTextStyleSmallOne,
          ),
        );
      }
    },
  );
}
