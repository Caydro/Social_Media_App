import 'dart:io';

import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/photosCubit/photos_cubit.dart';
import 'package:collagiey/Cubit/photosCubit/photos_state.dart';
import 'package:collagiey/Cubit/posts/postsCubit.dart';
import 'package:collagiey/Cubit/posts/postsState.dart';
import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_cubit.dart';
import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_state.dart';
import 'package:collagiey/Models/userModel.dart';
import 'package:collagiey/Service/reacting_with_posts.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:collagiey/Widgets/Posts_shared_by_user.dart';
import 'package:collagiey/Widgets/post_No_Photo.dart';
import 'package:collagiey/Widgets/post_button.dart';
import 'package:collagiey/Widgets/removeCircleBackground.dart';
import 'package:collagiey/Widgets/showBottomSheet_CustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHomePage extends StatefulWidget {
  const ProfileHomePage({super.key});

  @override
  State<ProfileHomePage> createState() => _ProfileHomePageState();
}

List<Map<String, dynamic>>? dataOfPostsWithOutPhoto;

int? userID;

class _ProfileHomePageState extends State<ProfileHomePage> {
  File? updatePhotoFile;
  Future<File?> _pickImage({required ImageSource imageSource}) async {
    final ImagePicker _picker = ImagePicker();

    // Pick an image from the gallery or camera
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      setState(() {
        updatePhotoFile = File(pickedFile.path);
        print(
            "Picked file path: ${updatePhotoFile!.path}"); // Log the picked file path
      });
      return updatePhotoFile; // Return the picked file
    } else {
      print("No file picked.");
      return null; // Return null if no file is picked
    }
  }

  blocActivation(BuildContext context) async {
    int id = await SharedPrefrencesOptions().showUserID();
    BlocProvider.of<UserInfoCubit>(context).getAllUserInfo(
      userID: id,
    );
    userID = id;
    BlocProvider.of<PostsCubit>(context)
        .showMyProfilePostWithNoPhoto(userID: id);
    BlocProvider.of<PhotosCubit>(context).checkCirclePhotoExist(userID: id);
  }

  UserModel? userData;
  @override
  void initState() {
    blocActivation(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<UserInfoCubit, UserInfoState>(
      listener: (context, state) {
        if (state is UserInfoStateSuccess) {
          setState(() {
            userData = UserModel.fromJson(state.data);
          });
        }
      },
      child: userData == null
          ? const Center(
              child: CircularProgressIndicator(
                color: CaydroColors.mainColor,
              ),
            )
          : Scaffold(
              body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              height: height * 0.4,
                              width: width,
                              child: InkWell(
                                onTap: () {
                                  pickPhotoBottomSheet(
                                    context: context,
                                    cameraAction: () async {
                                      File? pickedFile = await _pickImage(
                                          imageSource: ImageSource.camera);
                                      if (pickedFile != null) {
                                        // If a file is picked, update the circle photo
                                        BlocProvider.of<PhotosCubit>(context)
                                            .updateCoverPhoto(
                                          file: pickedFile,
                                          userID: userID!,
                                        );
                                      } else {
                                        // Show a message if no file was picked
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration: Duration(seconds: 30),
                                            content: Text(
                                              "You didn't pick a photo to Update",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    galleryAction: () async {
                                      File? pickedFile = await _pickImage(
                                          imageSource: ImageSource.gallery);
                                      if (pickedFile != null) {
                                        // If a file is picked, update the circle photo
                                        BlocProvider.of<PhotosCubit>(context)
                                            .updateCoverPhoto(
                                          file: pickedFile,
                                          userID: userID!,
                                        );
                                      } else {
                                        // Show a message if no file was picked
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "You didn't pick a photo to Update"),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                                child: BlocBuilder<PhotosCubit, PhotosState>(
                                  builder: (context, state) {
                                    if (state is UpdateCoverPhotoStateFailed) {
                                      return Image.network(
                                        CaydroImagesPath
                                            .customProfileCoverBackGroundNetwork,
                                      );
                                    }
                                    if (state is UpdateCoverPhotoStateSuccess) {
                                      return Image.network(
                                        "${MySqlImagePath.coverPhotoPath}/${userData!.coverBackground}",
                                      );
                                    } else if (state
                                        is UpdateCoverPhotoStateLoading) {
                                      return const CircularProgressIndicator(
                                        color: CaydroColors.mainColor,
                                      );
                                    } else {
                                      return BlocBuilder<PhotosCubit,
                                          PhotosState>(
                                        builder: (context, state) {
                                          BlocProvider.of<PhotosCubit>(context)
                                              .checkIfCoverPhotoExist(
                                                  userID: userID!);
                                          if (state
                                              is CheckCoverExistCoverIsReady) {
                                            return Image.network(
                                              "${MySqlImagePath.coverPhotoPath}/${state.coverName}",
                                            );
                                          } else if (state
                                              is CheckCoverExistNoCover) {
                                            return Image.network(
                                              CaydroImagesPath
                                                  .customProfileCoverBackGroundNetwork,
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -50,
                              child: BlocBuilder<PhotosCubit, PhotosState>(
                                builder: (context, state) {
                                  if (state is ChangeCirclePhotoStateSuccess) {
                                    return circleBackground(
                                      changePhotoAction: () async {
                                        await pickPhotoBottomSheet(
                                          context: context,
                                          cameraAction: () async {
                                            // Await the picked image
                                            File? pickedFile = await _pickImage(
                                                imageSource:
                                                    ImageSource.camera);
                                            if (pickedFile != null) {
                                              // If a file is picked, update the circle photo
                                              BlocProvider.of<PhotosCubit>(
                                                      context)
                                                  .updateCirclePhoto(
                                                file: pickedFile,
                                                userID: userID!,
                                              );
                                            } else {
                                              // Show a message if no file was picked
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  duration:
                                                      Duration(seconds: 30),
                                                  content: Text(
                                                    "You didn't pick a photo to Update",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          galleryAction: () async {
                                            // Await the picked image
                                            File? pickedFile = await _pickImage(
                                                imageSource:
                                                    ImageSource.gallery);
                                            if (pickedFile != null) {
                                              // If a file is picked, update the circle photo
                                              BlocProvider.of<PhotosCubit>(
                                                      context)
                                                  .updateCirclePhoto(
                                                file: pickedFile,
                                                userID: userID!,
                                              );
                                            } else {
                                              // Show a message if no file was picked
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "You didn't pick a photo to Update"),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  } else if (state
                                      is ChangeCirclePhotoStateLoading) {
                                    return const CircularProgressIndicator(
                                      color: CaydroColors.mainColor,
                                    );
                                  } else {
                                    return circleBackground(
                                      changePhotoAction: () async {
                                        await pickPhotoBottomSheet(
                                          context: context,
                                          cameraAction: () async {
                                            File? pickedFile = await _pickImage(
                                                imageSource:
                                                    ImageSource.camera);
                                            if (pickedFile != null) {
                                              BlocProvider.of<PhotosCubit>(
                                                      context)
                                                  .updateCirclePhoto(
                                                file: pickedFile,
                                                userID: userID!,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "You didn't pick a photo to Update",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          galleryAction: () async {
                                            File? pickedFile = await _pickImage(
                                                imageSource:
                                                    ImageSource.gallery);
                                            if (pickedFile != null) {
                                              BlocProvider.of<PhotosCubit>(
                                                      context)
                                                  .updateCirclePhoto(
                                                file: pickedFile,
                                                userID: userID!,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "You didn't pick a photo to Update",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            ///////////////////////////     ALL ABOUT USER PROFILE  /////////////////////////////////
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: width * 0.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userData!.userName,
                                  style: CaydroTextStyles.normalRobotoStyle,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              Text("777",
                                  style: CaydroTextStyles.numbersTextStyle),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "friends",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: "splashFont",
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                        const Divider(),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.009,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  backgroundColor: CaydroColors.mainColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.14,
                                    vertical: height * 0.002,
                                  ),
                                ),
                                child: const Text(
                                  "Add Story",
                                  style:
                                      CaydroTextStyles.ElevatedButtonTextStyle,
                                ),
                                onPressed: () {
                                  //////////////////////////////////                          ADD STORY PLAYS ////////////////////////////////////////
                                },
                              ),
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  backgroundColor: CaydroColors.BlueGreyColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.14,
                                    vertical: height * 0.002,
                                  ),
                                ),
                                child: const Text(
                                  "user Info",
                                  style:
                                      CaydroTextStyles.ElevatedButtonTextStyle,
                                ),
                                onPressed: () {
                                  //////////////////////////////////                          ADD STORY PLAYS ////////////////////////////////////////
                                },
                              ),
                            ),
                          ],
                        ),
                        //////////////////// ADDING POST   ///////////////////////////////////
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomPostButton(
                            userData: userData,
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<PostsCubit, PostsCubitState>(
                    builder: (context, state) {
                      if (state is ShowPostWithNoPhotoForProfileCubitSuccess) {
                        dataOfPostsWithOutPhoto = state.data;

                        return postsWidget();
                      } else if (state
                          is ShowPostWithNoPhotoForProfileCubitFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed to load your posts"),
                          ),
                        );
                        return Container();
                      } else {
                        return const Center(
                          child: Text(
                            "No Posts yet",
                            style: CaydroTextStyles.normalTextForAll,
                          ),
                        );
                      }
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: dataOfPostsWithOutPhoto != null
                        ? const Text("That was your first post",
                            style: CaydroTextStyles.normalTextForAll)
                        : Container(),
                  ),
                ),
              ],
            )),
    );
  }

  Padding circleBackground({required Function changePhotoAction}) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: BlocBuilder<PhotosCubit, PhotosState>(
        builder: (context, state) {
          if (state is CheckCirclePhotoStateNoPhoto) {
            return InkWell(
              onTap: () {
                CaydroCustomDialog().deleteCirclePhoto(
                  context: context,
                  removeButtonEnabled: false,
                  removePhotoAction: () {
                    removeCirlcePhotoDialog(context: context, userID: userID!);
                  },
                  changePhotoAction: () {
                    changePhotoAction.call();
                  },
                );
              },
              hoverColor: CaydroColors.mainColor,
              child: BlocBuilder<PhotosCubit, PhotosState>(
                builder: (context, state) {
                  if (state is DeleteCirclePhotoStateSuccess) {
                    return const CircleAvatar(
                      radius: 75,
                      ///////////       CALL IT AND TRY TO MAKE IT AS IF NULL MAKE IT  WITH NO CIRCLE PHOTO///////////////////////
                      backgroundImage: NetworkImage(
                        CaydroImagesPath.noCirclePhoto,
                      ),
                    );
                  } else if (state is DeleteCirclePhotoStateFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errMessage!,
                        ),
                      ),
                    );
                    return Container();
                  } else if (state is DeleteCirclePhotoStateLoading) {
                    return const CircularProgressIndicator(
                      color: CaydroColors.mainColor,
                    );
                  } else {
                    return CircleAvatar(
                      radius: 75,
                      ///////////       CALL IT AND TRY TO MAKE IT AS IF NULL MAKE IT  WITH NO CIRCLE PHOTO///////////////////////
                      backgroundImage: NetworkImage(
                        "${MySqlImagePath.circlePhotoPath}/${userData!.circleBackground}",
                      ),
                    );
                  }
                },
              ),
            );
          } else if (state is CheckCirclePhotoStatePhotoExists) {
            return InkWell(
              onTap: () {
                CaydroCustomDialog().deleteCirclePhoto(
                  context: context,
                  removeButtonEnabled: true,
                  removePhotoAction: () {
                    removeCirlcePhotoDialog(context: context, userID: userID!);
                  },
                  changePhotoAction: () {
                    changePhotoAction.call();
                  },
                );
              },
              hoverColor: CaydroColors.mainColor,
              child: BlocBuilder<PhotosCubit, PhotosState>(
                builder: (context, state) {
                  if (state is DeleteCirclePhotoStateSuccess) {
                    return const CircleAvatar(
                      radius: 75,
                      ///////////       CALL IT AND TRY TO MAKE IT AS IF NULL MAKE IT  WITH NO CIRCLE PHOTO///////////////////////
                      backgroundImage: NetworkImage(
                        CaydroImagesPath.noCirclePhoto,
                      ),
                    );
                  } else if (state is DeleteCirclePhotoStateFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errMessage!,
                        ),
                      ),
                    );
                    return Container();
                  } else if (state is DeleteCirclePhotoStateLoading) {
                    return const CircularProgressIndicator(
                      color: CaydroColors.mainColor,
                    );
                  } else {
                    return CircleAvatar(
                      radius: 75,
                      ///////////       CALL IT AND TRY TO MAKE IT AS IF NULL MAKE IT  WITH NO CIRCLE PHOTO///////////////////////
                      backgroundImage: NetworkImage(
                        "${MySqlImagePath.circlePhotoPath}/${userData!.circleBackground}",
                      ),
                    );
                  }
                },
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                CaydroCustomDialog().deleteCirclePhoto(
                  context: context,
                  removeButtonEnabled: true,
                  removePhotoAction: () {
                    removeCirlcePhotoDialog(context: context, userID: userID!);
                  },
                  changePhotoAction: () {
                    changePhotoAction.call();
                  },
                );
              },
              hoverColor: CaydroColors.mainColor,
              child: BlocBuilder<PhotosCubit, PhotosState>(
                builder: (context, state) {
                  if (state is DeleteCirclePhotoStateSuccess) {
                    return const CircleAvatar(
                      radius: 75,
                      ///////////       CALL IT AND TRY TO MAKE IT AS IF NULL MAKE IT  WITH NO CIRCLE PHOTO///////////////////////
                      backgroundImage: NetworkImage(
                        CaydroImagesPath.noCirclePhoto,
                      ),
                    );
                  } else if (state is DeleteCirclePhotoStateFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errMessage!,
                        ),
                      ),
                    );
                    return Container();
                  } else if (state is DeleteCirclePhotoStateLoading) {
                    return const CircularProgressIndicator(
                      color: CaydroColors.mainColor,
                    );
                  } else {
                    return CircleAvatar(
                      radius: 75,
                      ///////////       CALL IT AND TRY TO MAKE IT AS IF NULL MAKE IT  WITH NO CIRCLE PHOTO///////////////////////
                      backgroundImage: NetworkImage(
                        "${MySqlImagePath.circlePhotoPath}/${userData!.circleBackground}",
                      ),
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

Widget postsWidget() {
  return Expanded(
    child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataOfPostsWithOutPhoto!.length,
        itemBuilder: (context, item) {
          String circlePhoto = dataOfPostsWithOutPhoto![item]['circlePhoto'];
          String nameOfUser = dataOfPostsWithOutPhoto![item]['nameOfUser'];
          String postString = dataOfPostsWithOutPhoto![item]['post_string'];
          int likesNumber = dataOfPostsWithOutPhoto![item]['likes'];
          String commentsNumber = dataOfPostsWithOutPhoto![item]['comments'];
          int sharesNumber = dataOfPostsWithOutPhoto![item]['ppl_share'];
          String timeOfThePost = dataOfPostsWithOutPhoto![item]['time'];
          int postID = dataOfPostsWithOutPhoto![item]['post_id'];

          DateTime dateOfPost = DateTime.parse(timeOfThePost);
          DateTime dateAndTimeNow = DateTime.now();
          Duration timeThatYouShared = dateAndTimeNow.difference(dateOfPost);
          return PostWithNoPhoto(
            imageuserOfPost: "${MySqlImagePath.circlePhotoPath}/$circlePhoto",
            nameOfUserPost: nameOfUser,
            postOfUser: postString,
            onLikeButton: () {
              PostsReact().addLikeToAnyPostByPostIDAndUserID(
                  postID: postID, userID: userID!);
            },
            onDisLikeButton: () {
              PostsReact().deleteLikeToAnyPostByPostIDAndUserID(
                  postID: postID, userID: userID!);
            },
            likes: likesNumber,
            numberOfComments: commentsNumber,
            numberOfShares: sharesNumber,
            time: timeThatYouShared < const Duration(minutes: 60)
                ? "${timeThatYouShared.inMinutes}m"
                : timeThatYouShared > const Duration(days: 1)
                    ? "${timeThatYouShared.inDays}d"
                    : "${timeThatYouShared.inHours}h",
          );
        }),
  );
}

pickPhotoBottomSheet({
  required BuildContext context,
  required Function cameraAction,
  required Function galleryAction,
}) {
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
                      cameraAction.call();
                    },
                    child: const Text("From camera",
                        style: CaydroTextStyles.cameraChooseStyle),
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                flex: 1,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      galleryAction.call();
                    },
                    child: const Text("From gallery",
                        style: CaydroTextStyles.cameraChooseStyle),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
