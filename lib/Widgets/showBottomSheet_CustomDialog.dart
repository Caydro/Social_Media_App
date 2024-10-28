import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:flutter/material.dart';

class CaydroCustomDialog {
  deleteCirclePhoto({
    required context,
    required Function changePhotoAction,
    required Function removePhotoAction,
    required bool removeButtonEnabled,
  }) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 180,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  child: const Text(
                    "Change your Photo",
                    style: CaydroTextStyles.TextButtonStyle,
                  ),
                  onPressed: () {
                    changePhotoAction.call();
                  },
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  child: const Text(
                    "Remove your photo",
                    style: CaydroTextStyles.TextButtonStyle,
                  ),
                  onPressed: removeButtonEnabled == false
                      ? null
                      : () {
                          removePhotoAction.call();
                        },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
