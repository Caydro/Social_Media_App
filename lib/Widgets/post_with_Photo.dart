import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Widgets/commentsPage.dart';
import 'package:flutter/material.dart';

class CustomPostWithPhoto extends StatefulWidget {
  const CustomPostWithPhoto({
    super.key,
    required this.imageOfUserOfThePost,
    required this.nameOfUserOfThePost,
    required this.wordsOfThePost,
    required this.imageOfPostContent,
  });

  @override
  State<CustomPostWithPhoto> createState() => _CustomPostWithPhotoState();
  final String imageOfUserOfThePost;
  final String nameOfUserOfThePost;
  final String wordsOfThePost;
  final String imageOfPostContent;
}

Color buttonColor = Colors.blueGrey;

class _CustomPostWithPhotoState extends State<CustomPostWithPhoto> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.imageOfUserOfThePost),
                radius: 22,
              ),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              widget.nameOfUserOfThePost,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                ////////////             CONTROL THE POST FROM HERE                //////////////////////
              },
              icon: const Icon(Icons.more_vert_rounded),
            ),
            ////////////////////////// POST ////////////////////////////////////
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(7),
          child: Text(
            widget.wordsOfThePost,
            style: CaydroTextStyles.postTextStyle,
          ),
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, itemCount) {
              return Stack(children: [
                Image.network(
                  widget.imageOfPostContent,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Positioned(
                    top: 0,
                    left: 0,
                    child: Text(
                      "${itemCount + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ]);
            },
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: SizedBox(
                width: width * 0.02,
                height: height * 0.03,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                ///////////////////////////////// LIKE BUTTON ACTIONS  ///////////////////////////////////////////////////
                setState(() {
                  if (buttonColor == Colors.blueGrey) {
                    buttonColor = Colors.blue;
                  } else {
                    buttonColor = Colors.blueGrey;
                  }
                });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: buttonColor,
                  ),
                  Text(
                    "Like",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: buttonColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.2,
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                ///////////////////////////////// COMMENT BUTTON ACTION  ///////////////////////////////////////////////////
                commentsPage(
                  context: context,
                  allHeight: height,
                  allWidth: width,
                );
              },
              child: const Row(
                children: [
                  Text(
                    "Comment",
                    style: CaydroTextStyles.buttonOfPostTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.2,
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                ///////////////////////////////// SHARE BUTTON ACTION  ///////////////////////////////////////////////////
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.share,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    "Share",
                    style: CaydroTextStyles.buttonOfPostTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
