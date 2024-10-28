import 'package:flutter/material.dart';

class MyAddStoryListView extends StatelessWidget {
  const MyAddStoryListView(
      {super.key,
      required this.imageOfStory,
      required this.viewStoryActionFunction,
      required this.numberOfStories,
      required this.userOfStoryImage});
  final List<String>? imageOfStory;
  final Function? viewStoryActionFunction;
  final int? numberOfStories;
  final List<String>? userOfStoryImage;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: numberOfStories,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            viewStoryActionFunction!.call();
          },
          child: Stack(
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
                        imageOfStory![index],
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
                      userOfStoryImage![index],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
