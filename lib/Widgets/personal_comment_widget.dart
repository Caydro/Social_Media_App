import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:flutter/material.dart';

class PersonalComment extends StatelessWidget {
  const PersonalComment({
    super.key,
    required this.nameOfUserComment,
    required this.commentIsOn,
    required this.comment,
  });
  final String nameOfUserComment;
  final bool commentIsOn;
  final String comment;
  @override
  Widget build(BuildContext context) {
    if (commentIsOn == false) {
      return Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  CaydroImagesPath.noProfileImage,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                nameOfUserComment,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                comment,
                style: CaydroTextStyles.commentStyle,
              ),
            ),
          ),
        ],
      );
    } else {
      ///////////////////////////////////////////// YOU NEED TO COME BACK ASS POSSIABLE AS YOU CAN ///////////////////////////////////////////////////
      return Column(
        children: [
          Stack(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      CaydroImagesPath.noProfileImage,
                    ),
                  ),
                  Text(
                    nameOfUserComment,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                height: 150,
                width: 300,
                child: Image.asset(
                  CaydroImagesPath.customCommentCurve,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
