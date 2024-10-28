import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:flutter/material.dart';

class PostWithNoPhoto extends StatefulWidget {
  const PostWithNoPhoto({
    super.key,
    required this.imageuserOfPost,
    required this.nameOfUserPost,
    required this.postOfUser,
    required this.likes,
    required this.numberOfComments,
    required this.numberOfShares,
    required this.time,
    required this.onLikeButton,
    required this.onDisLikeButton,
  });
  final String? imageuserOfPost;
  final String? nameOfUserPost;
  final String? postOfUser;
  final int? likes;
  final Function? onLikeButton;
  final Function? onDisLikeButton;

  final String? numberOfComments;
  final int? numberOfShares;
  final String? time;

  @override
  State<PostWithNoPhoto> createState() => _PostWithNoPhotoState();
}

Color buttonColor = Colors.blueGrey;

class _PostWithNoPhotoState extends State<PostWithNoPhoto> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child:
                    // This will position the time behind the CircleAvatar

                    CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageuserOfPost!),
                  radius: 22,
                ),
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.nameOfUserPost!,
                    style: CaydroTextStyles.userName,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${widget.time!}               ",
                      style: CaydroTextStyles.normalTextForAll,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  //////////////////////////////             CONTROL THE POST FROM HERE                //////////////////////
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: postControllingPage(context),
                        );
                      });
                },
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              widget.postOfUser!,
              style: CaydroTextStyles.postTextStyle,
            ),
          ),
          SizedBox(
            height: 18,
            child: InkWell(
              onTap: () {
                ////////////// open COMMENTS /////////////////////////////////////
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return commentsWidget();
                    });
              },
              child: Stack(
                children: [
                  Positioned(
                    left: 7,
                    child: Text(
                      "  ${widget.likes} like",
                      style: CaydroTextStyles.likeAndCommentStyle,
                    ),
                  ),
                  Positioned(
                    right: 180,
                    child: Text(
                      "${widget.numberOfComments} comments",
                      style: CaydroTextStyles.likeAndCommentStyle,
                    ),
                  ),
                  Positioned(
                    right: 15,
                    child: Text(
                      " ${widget.numberOfShares} Shares",
                      style: CaydroTextStyles.likeAndCommentStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.01,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  ///////////////////////////////// LIKE BUTTON ACTIONS  ///////////////////////////////////////////////////
                  setState(() {
                    if (buttonColor == Colors.blueGrey) {
                      buttonColor = Colors.blue;
                      widget.onLikeButton!.call();
                      setState(() {});
                    } else {
                      buttonColor = Colors.blueGrey;
                      widget.onDisLikeButton!.call();
                      setState(() {});
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
      ),
    );
  }
}

Widget postControllingPage(BuildContext context) {
  return SizedBox(
    height: 150,
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              ///////////////// editing your post here //////////////////////////
            },
            child: const Center(
              child: Text(
                "edit",
                style: CaydroTextStyles.textButtonStylesForChoosing,
              ),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              /////////////// DELETE THE POST HERE /////////////////////////////////////
            },
            child: const Center(
              child: Text(
                "Delete",
                style: CaydroTextStyles.textButtonStylesForChoosingDelete,
              ),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Center(
              child: Text(
                "Cancel",
                style: CaydroTextStyles.textButtonStylesForChoosing,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget commentsWidget() {
  return SizedBox(
    width: double.infinity,
    height: 300,
    child: Column(
      children: [
        Divider(
          color: Colors.blueGrey,
          thickness: 5,
          indent: 170,
          endIndent: 170,
        ),
        const Text("Hola"),
      ],
    ),
  );
}
