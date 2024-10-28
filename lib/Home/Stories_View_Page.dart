import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/stories/stories_cubit.dart';
import 'package:collagiey/Cubit/stories/stories_state.dart';
import 'package:collagiey/Models/storiesModel.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';

class StoriesViewPage extends StatefulWidget {
  const StoriesViewPage({super.key, this.storyModel});

  @override
  State<StoriesViewPage> createState() => _StoriesViewPageState();
  final int? storyModel;
}

int? my_User_id;

class _StoriesViewPageState extends State<StoriesViewPage> {
  blocActivition(BuildContext context) async {
    int userID = await SharedPrefrencesOptions().showUserID();
    my_User_id = userID;
    BlocProvider.of<StoriesCubit>(context)
        .showEveryUserStories(userID: widget.storyModel!);
  }

  Color getColorFromString(String hexColor) {
    int colorInt = int.parse(hexColor);
    return Color(colorInt);
  }

  @override
  void initState() {
    blocActivition(context);
    super.initState();
  }

  final story_Controller = StoryController();
  List<StoryModel> storiesList = [];

  @override
  Widget build(BuildContext context) {
    double iconSize = 35;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<StoriesCubit, StoriesState>(
              builder: (context, state) {
                if (state is ShowEveryUserStoriesStateSuccess) {
                  // Get the list of stories from state.data
                  if (state.data != null && state.data!.isNotEmpty) {
                    storiesList = state.data!
                        .map((storyData) => StoryModel.fromJson(storyData))
                        .toList();
                  }

                  if (storiesList.isNotEmpty) {
                    // Convert each story in storiesList to a StoryItem
                    final storyItems = storiesList.map((story) {
                      if (story.contentType == "text") {
                        return StoryItem.text(
                          title: story.storyContent,
                          backgroundColor:
                              getColorFromString(story.backgroundColor),
                        );
                      } else {
                        return StoryItem.pageImage(
                          duration: const Duration(seconds: 5),
                          controller: story_Controller,
                          url:
                              "${MySqlImagePath.storiesImages}/${story.storyContent}",
                        );
                      }
                    }).toList();

                    return StoryView(
                      storyItems: storyItems,
                      controller: story_Controller,
                      onComplete: () {
                        story_Controller.next();
                        setState(() {});
                      },
                      indicatorColor: Colors.transparent,
                      indicatorForegroundColor: Colors.white,
                    );
                  } else {
                    return const Center(child: Text("No story data available"));
                  }
                } else if (state is ShowEveryUserStoriesStateFailed) {
                  return Center(
                      child: Text("Failed to load story: ${state.errMessage}"));
                } else if (state is ShowEveryUserStoriesStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: CaydroColors.mainColor,
                    ),
                  );
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              },
            ),
            Positioned(
              right: width * 0.33,
              top: height * 0.022,
              child: const Text(
                "StoryLine",
                style: CaydroTextStyles.storiesTextStyle,
              ),
            ),
            Positioned(
              bottom: height * 0.22,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.favorite_border_rounded),
                onPressed: () {},
                color: Colors.white,
                iconSize: iconSize,
              ),
            ),
            Positioned(
              bottom: height * 0.13,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {},
                color: Colors.white,
                iconSize: iconSize,
              ),
            ),
            Positioned(
              bottom: height * 0.05,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
                color: Colors.white,
                iconSize: iconSize,
              ),
            ),
            if (storiesList.isNotEmpty)
              Positioned(
                bottom: height * 0.1,
                left: width * 0.01,
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      "${MySqlImagePath.circlePhotoPath}/${storiesList[0].circleBackground}"),
                ),
              ),
            Positioned(
              top: 10,
              left: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<StoriesCubit>(context)
                      .showHomePageStoriesForFriends(userID: my_User_id!);
                },
              ),
            ),
            if (storiesList.isNotEmpty)
              Positioned(
                bottom: height * 0.111,
                left: width * 0.14,
                child: Text(
                  storiesList[0].userName,
                  style: CaydroTextStyles.storyUserNameStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
