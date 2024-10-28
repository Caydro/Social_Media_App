import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/routesOfPages.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/posts/postsCubit.dart';
import 'package:collagiey/Cubit/posts/postsState.dart';
import 'package:collagiey/Cubit/stories/stories_cubit.dart';
import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_cubit.dart';
import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_state.dart';
import 'package:collagiey/Home/home_upper_And_Logo.dart';
import 'package:collagiey/Models/userModel.dart';
import 'package:collagiey/Service/reacting_with_posts.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:collagiey/Widgets/create_my_story.dart';
import 'package:collagiey/Widgets/my_add_story_widget.dart';
import 'package:collagiey/Widgets/post_No_Photo.dart';
import 'package:collagiey/Widgets/post_button.dart';
import 'package:collagiey/Widgets/story_ListView_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

int? user_ID;
void userInfoActive(BuildContext context) async {
  int userID = await SharedPrefrencesOptions().showUserID();
  BlocProvider.of<UserInfoCubit>(context).getAllUserInfo(userID: userID);
  BlocProvider.of<PostsCubit>(context)
      .showHomePagePostsWithNoPhoto(userID: userID);
  BlocProvider.of<StoriesCubit>(context)
      .showHomePageStoriesForFriends(userID: userID);
  user_ID = userID;
}

class _HomePageBodyState extends State<HomePageBody> {
  UserModel? userModel;

  @override
  void initState() {
    userInfoActive(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<UserInfoCubit, UserInfoState>(
        listener: (context, state) {
          if (state is UserInfoStateSuccess) {
            userModel = UserModel.fromJson(state.data);
          } else if (state is UserInfoStateFailed) {
            Navigator.of(context).pushNamed(NamesOfRoutes.signInRoute);
          }
        },
        child: BlocBuilder<UserInfoCubit, UserInfoState>(
          builder: (context, state) {
            if (userModel == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                      child: HomeUpperPart(
                        userID: user_ID!,
                        userData: userModel!,
                      )),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                      child: CustomPostButton(userData: userModel)),
                ),
                const SliverToBoxAdapter(child: Divider(thickness: 3)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.29,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          MyAddStoryListView(
                            numberOfStories: 1,
                            userOfStoryImage: [
                              "${MySqlImagePath.circlePhotoPath}/${userModel!.circleBackground}",
                            ],
                            imageOfStory: const [
                              "https://i.pinimg.com/originals/3f/d3/f8/3fd3f81ba354e8dbf56942a13f3374d9.webp",
                            ],
                            viewStoryActionFunction: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CreateStoryPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                              width: 1), // Space between user story and others
                          // Additional stories can be added here if you have more users' data.
                          StoryListView(),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider(thickness: 3)),
                SliverToBoxAdapter(
                  child: BlocBuilder<PostsCubit, PostsCubitState>(
                    builder: (context, state) {
                      if (state is ShowHomePagePostsWithNoPhotoSuccess) {
                        return postsWidget(
                            dataOfPostsWithOutPhoto: state.data!);
                      } else if (state is ShowHomePagePostsWithNoPhotoFailed) {
                        return Center(
                          child: Text(
                            "${state.errMessage}",
                            style: CaydroTextStyles.normalTextForAll,
                          ),
                        );
                      } else {
                        return const Center(
                            child: Text(
                          "There's something went wrong",
                          style: CaydroTextStyles.normalTextForAll,
                        ));
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget postsWidget(
    {required List<Map<String, dynamic>> dataOfPostsWithOutPhoto}) {
  return Expanded(
    child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataOfPostsWithOutPhoto.length,
        itemBuilder: (context, item) {
          String circlePhoto = dataOfPostsWithOutPhoto[item]['circlePhoto'];
          String nameOfUser = dataOfPostsWithOutPhoto[item]['nameOfUser'];
          String postString = dataOfPostsWithOutPhoto[item]['post_string'];
          int likesNumber = dataOfPostsWithOutPhoto[item]['likes'];
          String commentsNumber = dataOfPostsWithOutPhoto[item]['comments'];
          int sharesNumber = dataOfPostsWithOutPhoto[item]['ppl_share'];
          String timeOfThePost = dataOfPostsWithOutPhoto[item]['time'];
          int postID = dataOfPostsWithOutPhoto[item]['post_id'];

          DateTime dateOfPost = DateTime.parse(timeOfThePost);
          DateTime dateAndTimeNow = DateTime.now();
          Duration timeThatYouShared = dateAndTimeNow.difference(dateOfPost);
          return PostWithNoPhoto(
            imageuserOfPost: "${MySqlImagePath.circlePhotoPath}/$circlePhoto",
            nameOfUserPost: nameOfUser,
            onLikeButton: () {
              PostsReact().addLikeToAnyPostByPostIDAndUserID(
                  postID: postID, userID: user_ID!);
            },
            onDisLikeButton: () {
              PostsReact().deleteLikeToAnyPostByPostIDAndUserID(
                  postID: postID, userID: user_ID!);
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
        }),
  );
}
