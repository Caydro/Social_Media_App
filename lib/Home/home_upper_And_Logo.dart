import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/NamesOfApp.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/searchForFriends/searchFriendsCubit.dart';
import 'package:collagiey/Cubit/searchForFriends/searchFriendsState.dart';
import 'package:collagiey/Home/SHARE_POST_UIPAGE.dart';
import 'package:collagiey/Home/home_Body.dart';
import 'package:collagiey/Models/userModel.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:collagiey/Widgets/post_button.dart';
import 'package:collagiey/users_page/users_homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';

class HomeUpperPart extends StatefulWidget {
  const HomeUpperPart(
      {super.key, required this.userID, required this.userData});
  final int? userID;
  @override
  State<HomeUpperPart> createState() => _HomeUpperPartState();
  final UserModel userData;
}

UserModel? userModelData;

@override
class _HomeUpperPartState extends State<HomeUpperPart> {
  @override
  Widget build(BuildContext context) {
    userModelData = widget.userData;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * 0.02,
        ),
        const Text(
          NamesOfApp.mainNameOfApp,
          style: CaydroTextStyles.logoTextStyle,
        ),
        const Spacer(),
        InkWell(
          splashColor: Colors.transparent,
          child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.search,
                color: CaydroColors.mainColor,
              )),
          onTap: () {
            ///////////////// SEARCH BAR HERE /////////////////////////
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        ),
        InkWell(
          splashColor: Colors.transparent,
          child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.arrow_circle_up_sharp,
                color: CaydroColors.mainColor,
              )),
          onTap: () {
            showBottomSheetForPostAndReels(
              context: context,
              width: width,
              height: height,
            );
          },
        ),
        InkWell(
          splashColor: Colors.transparent,
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.messenger_rounded,
              color: CaydroColors.mainColor,
            ),
          ),
          onTap: () {
            //////////////////////////////                        MESSENGER PART LATER          /////////////////////////////////
          },
        ),
      ],
    );
  }
}

void showBottomSheetForPostAndReels(
    {required BuildContext context,
    required double width,
    required double height}) {
  showBottomSheet(
      enableDrag: true,
      backgroundColor: Colors.white54,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: height * 0.22,
          width: width,
          child: Column(
            children: [
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Reel",
                      style: CaydroTextStyles.TextButtonStyleForDialog,
                    ),
                    SizedBox(width: width * 0.002),
                    const Icon(Icons.video_collection,
                        color: CaydroColors.mainColor),
                  ],
                ),
                onPressed: () {
                  /////////////////////////REEL ACTION//////////////////////////
                },
              ),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Post",
                      style: CaydroTextStyles.TextButtonStyleForDialog,
                    ),
                    SizedBox(width: width * 0.002),
                    const Icon(Icons.post_add, color: CaydroColors.mainColor),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SharePostsPageUI(
                        userData: userModelData!,
                      ),
                    ),
                  );
                },
              ),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Story",
                      style: CaydroTextStyles.TextButtonStyleForDialog,
                    ),
                    SizedBox(width: width * 0.002),
                    const Icon(Icons.camera, color: CaydroColors.mainColor),
                  ],
                ),
                onPressed: () {
                  /////////////////////                      STORY ACTION                 //////////////////////////
                },
              ),
            ],
          ),
        );
      });
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") {
      return const Center(
        child: Text("Search for a friend that you know"),
      );
    } else {
      BlocProvider.of<SearchForUsersCubit>(context)
          .showUsersWithALetter(userName: query, userID: user_ID!);

      return BlocBuilder<SearchForUsersCubit, SearchForUsersState>(
        builder: (context, state) {
          if (state is SearchForUsersStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchForUsersStateSuccess) {
            List<Map<String, dynamic>> usersDataThatYouSearching = state.data;

            return ListView.builder(
              itemBuilder: (context, item) {
                String userName = usersDataThatYouSearching[item]["user_name"];
                String circleBackground =
                    usersDataThatYouSearching[item]["circle_background"];
                String coverImage =
                    usersDataThatYouSearching[item]["cover_background"];
                int userID = usersDataThatYouSearching[item]["user_id"];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UsersHomePage(
                          userName: userName,
                          userCircleImage: circleBackground,
                          userCoverBackground: coverImage,
                          user_id: userID,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "${MySqlImagePath.circlePhotoPath}/$circleBackground",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(userName),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: usersDataThatYouSearching.length,
            );
          } else if (state is SearchForUsersStateFailed) {
            return Center(
              child: Text("Failed to load users: ${state.errMessage}"),
            );
          } else {
            return const Center(
              child: Text("No users found"),
            );
          }
        },
      );
    }
  }
}
