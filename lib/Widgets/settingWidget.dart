import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:flutter/material.dart';

Widget settingDrawerPage({required double width}) {
  return SizedBox(
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: Center(
            child: Text(
              "Settings",
              style: CaydroTextStyles.settingTextStyle,
            ),
          ),
        ),
        const Divider(),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              const Icon(
                Icons.settings,
                color: CaydroColors.mainColor,
                size: 30,
              ),
              SizedBox(
                width: width * 0.02,
              ),
              const Text(
                "Settings",
                style: CaydroTextStyles.chooseBetweenSettingsStyle,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
