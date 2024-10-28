import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/routesOfPages.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/circleBackandBirthDayCubit/circleCubit.dart';
import 'package:collagiey/Cubit/circleBackandBirthDayCubit/circleState.dart';
import 'package:collagiey/Home/home_Body.dart';
import 'package:collagiey/Home/mainHome.dart';
import 'package:collagiey/Home/profile_Page.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';

class BirthDayAndCirclePhotoPage extends StatefulWidget {
  const BirthDayAndCirclePhotoPage({super.key, this.userID});
  final int? userID;
  @override
  State<BirthDayAndCirclePhotoPage> createState() =>
      _BirthDayAndCirclePhotoPageState();
}

class _BirthDayAndCirclePhotoPageState
    extends State<BirthDayAndCirclePhotoPage> {
  DateTime? firstDate;

  DateTime? secondtDate;
  String? timeUserPicked;
  File? _circleBackGround;

  Future<void> _pickImage({required ImageSource imageSource}) async {
    final ImagePicker _picker = ImagePicker();

    // Pick an image from the gallery or camera
    final XFile? pickedFile = await _picker.pickImage(
      source: imageSource, // Change to ImageSource.camera to use the camera
    );

    if (pickedFile != null) {
      setState(() {
        _circleBackGround = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CircleAndBirthdayCubit, CirclePhotoAndBirthdayState>(
      listener: (context, state) {
        if (state is CirclePhotoAndBirthStateFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is CirclePhotoAndBirthStateSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(
                userID: widget.userID!,
              ),
            ),
          );
          SharedPrefrencesOptions().addUserDataToSharedPrefMethod({
            "userID": widget.userID,
            /////////////////////////////////////////    HERE WE GO NEXT NEED TO MAKE SURE YOU SAVE USERID IN THE SIGNIN TOO AND FIX NULL FOR NO MODEL DATA
          });
        } else if (state is CirclePhotoAndBirthStateloading) {
          Lottie.asset("assets/lottie/LoadingMixSocial.json");
        }
      },
      child: BlocBuilder<CircleAndBirthdayCubit, CirclePhotoAndBirthdayState>(
        builder: (context, state) {
          if (state is CirclePhotoAndBirthStateloading) {
            Lottie.asset("assets/lottie/LoadingMixSocial.json");
          }
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  betweenLinesText(text: "Pick a Background"),
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            _pickImage(
                                                imageSource:
                                                    ImageSource.camera);
                                          },
                                          child: const Text("From camera",
                                              style: CaydroTextStyles
                                                  .cameraChooseStyle),
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            _pickImage(
                                                imageSource:
                                                    ImageSource.gallery);
                                          },
                                          child: const Text("From gallery",
                                              style: CaydroTextStyles
                                                  .cameraChooseStyle),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: _circleBackGround == null
                          ? Tooltip(
                              enableFeedback: true,
                              message: "Pick Image",
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.transparent,
                                child: Lottie.asset(
                                  "assets/lottie/pickImageLottie.json",
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  FileImage(File(_circleBackGround!.path)),
                            ),
                    ),
                  ),
                  betweenLinesText(text: "Pick a Birthday"),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      child: Lottie.asset("assets/lottie/birthdayPick.json",
                          repeat: false),
                      onTap: () async {
                        DateTime? timePicked = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        timeUserPicked = timePicked.toString();
                        print(timePicked.toString());
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          if (_circleBackGround != null &&
                              timeUserPicked != "null") {
                            BlocProvider.of<CircleAndBirthdayCubit>(context)
                                .addCirclePhotoAndBirthdayFunc(
                                    userID: widget.userID!,
                                    file: _circleBackGround!,
                                    birthDay: timeUserPicked!);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: DefaultTextStyle(
                                style: CaydroTextStyles.goHomeButtonStyle,
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    WavyAnimatedText('Go to Home'),
                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget betweenLinesText({required String text}) {
  return const Row(
    children: [
      Expanded(
        child: Divider(),
      ),
      SizedBox(width: 10),
      Text(
        "Pick a Background",
        style: CaydroTextStyles.actionsText,
      ),
      SizedBox(width: 10),
      Expanded(child: Divider()),
    ],
  );
}
