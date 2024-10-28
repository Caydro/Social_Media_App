import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/stories/stories_cubit.dart';
import 'package:collagiey/Cubit/stories/stories_state.dart';
import 'package:collagiey/Home/Stories_View_Page.dart';
import 'package:collagiey/Models/storiesModel.dart';
import 'package:collagiey/Widgets/custom_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryListView extends StatefulWidget {
  StoryListView({
    super.key,
  });

  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  StoryModel? storyModel;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<StoriesCubit, StoriesState>(
      builder: (context, state) {
        if (state is ShowHomePageStoriesStateSuccess) {
          Color getColorFromString(String hexColor) {
            // Parse the string to an integer
            int colorInt = int.parse(hexColor);
            return Color(colorInt); // Create Color from the integer
          }

          List<Map<String, dynamic>> storiesData = state.data!;
          return ListView.builder(
            itemCount: storiesData.length,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              storyModel = StoryModel.fromJson(storiesData[index]);

              return InkWell(
                onTap: () {
                  int onPressedUserID = state.data![index]['user_id'];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StoriesViewPage(
                        storyModel: onPressedUserID,
                      ),
                    ),
                  );
                },
                child: storyModel!.contentType == "photo"
                    ? Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: height * 0.1,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    ///////////////// STORY IMAGES /////////////////////////
                                    "${MySqlImagePath.storiesImages}/${storyModel!.storyContent}",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(
                                  "${MySqlImagePath.circlePhotoPath}/${storyModel!.circleBackground}",
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: getColorFromString(
                                    storyModel!.backgroundColor),
                              ),
                              height: height * 0.1,
                              width: width * 0.3,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    storyModel!.storyContent,
                                    style:
                                        CaydroTextStyles.storyOutHomeTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(
                                  "${MySqlImagePath.circlePhotoPath}/${storyModel!.circleBackground}",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            },
          );
        } else if (state is ShowHomePageStoriesStateFailed) {
          return Container();
        } else if (state is ShowHomePageStoriesStateLoading) {
          return const CircularProgressIndicator(
            color: CaydroColors.mainColor,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
