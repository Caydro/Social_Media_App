import 'dart:io';

import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/stories/stories_cubit.dart';
import 'package:collagiey/Cubit/stories/stories_state.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:collagiey/Widgets/custom_snackBar.dart';
import 'package:collagiey/Widgets/text_story_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({super.key});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

File? storyPhoto;
int? userID;

class _CreateStoryPageState extends State<CreateStoryPage> {
  getUserID() async {
    int user_id = await SharedPrefrencesOptions().showUserID();
    userID = user_id;
    print(userID);
  }

  @override
  void initState() {
    getUserID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<File?> _pickImage({required ImageSource imageSource}) async {
      final ImagePicker _picker = ImagePicker();

      // Pick an image from the gallery or camera
      final XFile? pickedFile = await _picker.pickImage(source: imageSource);

      if (pickedFile != null) {
        setState(() {
          storyPhoto = File(pickedFile.path);
          print(
              "Picked file path: ${storyPhoto!.path}"); // Log the picked file path
        });
        return storyPhoto; // Return the picked file
      } else {
        print("No file picked.");
        return null; // Return null if no file is picked
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<StoriesCubit, StoriesState>(
          listener: (context, state) {
            if (state is AddPhotoStoriesStateSuccess) {
              customSnackBar(context: context, text: "Story added");
            } else if (state is AddPhotoStoriesStateFailed) {
              customSnackBar(context: context, text: "${state.errMessage}");
            }
          },
          child: Column(
            children: [
              // First row with close button, title, and camera icon
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: CaydroColors.mainColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                  const Text(
                    "Create story",
                    style: TextStyle(
                      fontSize: 21,
                      color: CaydroColors.mainColor,
                      fontWeight: FontWeight.bold,
                    ), // Replace with your custom text style
                  ),
                  SizedBox(
                    width: width * 0.2,
                  ),
                  IconButton(
                    onPressed: () async {
                      File? pickedFile =
                          await _pickImage(imageSource: ImageSource.camera);
                      if (pickedFile != null) {
                        // If a file is picked, select Story Photo
                        BlocProvider.of<StoriesCubit>(context)
                            .addPhotoStoriesFunction(
                                file: pickedFile, userID: userID!);
                      } else {
                        // Show a message if no file was picked
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("You didn't pick a photo to Update"),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: CaydroColors.mainColor,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CaydroColors.storyTextColor,
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.43),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Handle Text button click
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TextStoryPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Text",
                          style: CaydroTextStyles.ElevatedButtonTextStyle,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CaydroColors.storyGalleryColor,
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.43),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          // Handle Gallery button click
                          File? pickedFile = await _pickImage(
                              imageSource: ImageSource.gallery);
                          if (pickedFile != null) {
                            // If a file is picked, select Story Photo
                            BlocProvider.of<StoriesCubit>(context)
                                .addPhotoStoriesFunction(
                                    file: pickedFile, userID: userID!);
                          } else {
                            // Show a message if no file was picked
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("You didn't pick a photo to Update"),
                              ),
                            );
                          }
                        },
                        child: const Text("Gallery",
                            style: CaydroTextStyles.ElevatedButtonTextStyle),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
