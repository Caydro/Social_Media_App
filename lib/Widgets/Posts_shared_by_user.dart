import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:flutter/material.dart';

class PostSharedByUser extends StatefulWidget {
  const PostSharedByUser({
    super.key,
    required this.userThatSharesBackgroundPhoto,
    required this.userThatSharesName,
    required this.userOfPostName,
    required this.userOfPostBackgroundPhoto,
    required this.typeOfPost,
    required this.userThatSharesPostWords,
    required this.userOfPostWords,
    required this.userOfPostPhotoThatHeShare,
    required this.editePostItems,
  });
  final String? userThatSharesBackgroundPhoto;
  final List<String>? userOfPostPhotoThatHeShare;
  final String? userThatSharesName;
  final String? userOfPostName;
  final String? userOfPostBackgroundPhoto;
  final String? typeOfPost;
  final String? userThatSharesPostWords;
  final String? userOfPostWords;
  final Function? editePostItems;

  @override
  State<PostSharedByUser> createState() => _PostSharedByUserState();
}

Color buttonColor = Colors.blueGrey;

class _PostSharedByUserState extends State<PostSharedByUser> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                ////////////////////////////////    Main User PHOTO  //////////////////////////////////////////////////
                "${widget.userThatSharesBackgroundPhoto}",
              ),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              "${widget.userThatSharesName}",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                ///////////////////////// Edite You POST THAT YOU SHARED FROM HERE   ///////////////////////////////////////
                widget.editePostItems!.call();
              },
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: width * 0.1),
          alignment: Alignment.bottomLeft,
          child: Text(
            "${widget.userThatSharesPostWords}",
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: postThatYouShare(
                  width: width,
                  type: "${widget.typeOfPost}",
                  height: height,
                  stringOfPostThatYouShared: "${widget.userOfPostWords}",
                  nameOfUserPost: "${widget.userOfPostName}",
                  numberOfPhotosOfPost:
                      widget.userOfPostPhotoThatHeShare!.length,
                  photoOfPost: widget.userOfPostPhotoThatHeShare!,
                  photoOfUserPost: "${widget.userOfPostBackgroundPhoto}",
                ),
              ),
              likeAndShareButtons(
                  buttonColor: buttonColor,
                  width: width,
                  height: height,
                  likeButtonAction: () {
                    setState(() {
                      if (buttonColor == Colors.blueGrey) {
                        buttonColor = Colors.blue;
                      } else {
                        buttonColor = Colors.blueGrey;
                      }
                    });
                  })
            ]),
          ),
        ),
      ],
    );
  }
}

Widget postThatYouShare({
  required double width,
  required String type,
  required double height,
  required String stringOfPostThatYouShared,
  required String nameOfUserPost,
  required String photoOfUserPost,
  required List<String> photoOfPost,
  required int numberOfPhotosOfPost,
}) {
  return Container(
    padding: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      border: Border.all(
        color: CaydroColors.BlueGreyColor,
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                ////////////////////////////////    Main User PHOTO  //////////////////////////////////////////////////
                photoOfUserPost,
              ),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              nameOfUserPost,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        type == "String"
            ? Text(stringOfPostThatYouShared)
            : type == "hasImage"
                ? Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, bottom: 10, top: 10),
                        child: Text(stringOfPostThatYouShared),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: numberOfPhotosOfPost,
                          itemBuilder: (context, itemI) {
                            return Image.network(photoOfPost[itemI]);
                          }),
                    ),
                  ])
                : Container(
                    height: 0,
                  ),
      ],
    ),
  );
}

Widget likeAndShareButtons({
  required double width,
  required double height,
  required Color buttonColor,
  required Function likeButtonAction,
}) {
  return Row(
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
          likeButtonAction.call();
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
  );
}
