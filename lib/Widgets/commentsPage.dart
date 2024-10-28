import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Widgets/personal_comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

commentsPage({
  required BuildContext context,
  required double allHeight,
  required double allWidth,
}) {
  showBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: allHeight - 80,
          width: allWidth,
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Comments",
                  style: CaydroTextStyles.highLightStyle,
                ),
              ),
              Card(
                color: Colors.white54,
                shape: const StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, item) {
                        return const PersonalComment(
                          nameOfUserComment: "Ahmed Mohamed",
                          commentIsOn: true,
                          comment: "Comment For Later",
                        );
                      },
                      itemCount: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
