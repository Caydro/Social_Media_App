import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/posts/postsCubit.dart';
import 'package:collagiey/Cubit/posts/postsState.dart';
import 'package:collagiey/Home/mainHome.dart';
import 'package:collagiey/Models/userModel.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SharePostsPageUI extends StatefulWidget {
  SharePostsPageUI({super.key, required this.userData});
  UserModel userData;

  @override
  State<SharePostsPageUI> createState() => _SharePostsPageUIState();
}

bool typing = false;
String privacyStatus = "anyOne";
int? user_id;
TextEditingController postString = TextEditingController();

class _SharePostsPageUIState extends State<SharePostsPageUI> {
  userID() async {
    int userID = await SharedPrefrencesOptions().showUserID();
    user_id = userID;
  }

  @override
  void initState() {
    userID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<PostsCubit, PostsCubitState>(
      listener: (context, state) {
        if (state is AddPostsWithNoPhotoCubitStateFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${state.errMessage}"),
            ),
          );
        } else if (state is AddPostsWithNoPhotoCubitStateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Post Successfully added"),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.of(context).pop();
          });
        }
      },
      child: BlocBuilder<PostsCubit, PostsCubitState>(
        builder: (context, state) {
          if (state is AddPostsWithNoPhotoCubitStateLoading) {
            return Scaffold(
              body: Center(
                child: Lottie.asset("assets/lottie/postSharedLoading.json"),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: CaydroColors.BlueGreyColor,
                actions: [
                  buttonForPrivacy(
                    context: context,
                    height: height,
                    width: width,
                    setStateFunction: () {
                      setState(() {});
                    },
                  ),
                ],
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      typing = false;
                    });
                  },
                ),
                centerTitle: true,
                title: typing == false
                    ? const Text(
                        "Create post",
                        style: CaydroTextStyles.createPostTextStyle,
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const BeveledRectangleBorder(),
                          backgroundColor: Colors.blueGrey,
                        ),
                        child: const Text(
                          "Post it",
                          style: CaydroTextStyles.ElevatedButtonTextStyle,
                        ),
                        onPressed: () {
                          //////////////////////  POST BUTTON //////////////////////////////
                          BlocProvider.of<PostsCubit>(context)
                              .addPostWithNoPhoto(
                                  userID: user_id!,
                                  postString: postString.text,
                                  postPrivacy: privacyStatus);
                          postString.clear();
                        },
                      ),
              ),
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: NetworkImage(
                              "${MySqlImagePath.circlePhotoPath}/${widget.userData.circleBackground}"),
                        ),
                      ),
                      Text(widget.userData.userName,
                          style: CaydroTextStyles.namesTextStyle),
                    ],
                  ),
                  TextFormField(
                    controller: postString,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        typing = false;
                        setState(() {});
                      } else {
                        setState(() {
                          typing = true;
                        });
                      }
                    },
                    maxLines: 6,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintMaxLines: 5,
                      hintText: " What's in your mind?",
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: CaydroColors.BlueGreyColor,
                  child: const Icon(
                    Icons.expand_more_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showBottomSheetForPostPage(context);
                  }),
            );
          }
        },
      ),
    );
  }
}

Widget buttonForPrivacy(
    {required BuildContext context,
    required double height,
    required double width,
    required Function() setStateFunction}) {
  return InkWell(
    onTap: () {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: height * 0.39,
              width: double.infinity,
              child: Column(
                children: [
                  const Text("Who can see my post?",
                      style: CaydroTextStyles.normalRandom),
                  const Divider(
                    indent: 80,
                    endIndent: 80,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: CaydroColors.BlueGreyColor,
                      width: 3,
                    )),
                    child: ListTile(
                      leading: const Icon(
                        Icons.group,
                        color: CaydroColors.greyColor,
                      ),
                      onTap: () {
                        ////////// to anyone action //////////////////////
                        privacyStatus = "anyOne";
                        setStateFunction();
                        Navigator.of(context).pop();
                      },
                      title: const Text("To anyone",
                          style: CaydroTextStyles.textButtonStyle),
                      subtitle: const Text(
                          "By Selecting this all your friends will see that post",
                          style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: CaydroColors.BlueGreyColor,
                      width: 3,
                    )),
                    child: ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: CaydroColors.greyColor,
                      ),
                      onTap: () {
                        ////////// to personal action //////////////////////
                        privacyStatus = "onlyMe";
                        setStateFunction();
                        Navigator.of(context).pop();
                      },
                      title: const Text(
                        "Only me",
                        style: CaydroTextStyles.textButtonStyle,
                      ),
                      subtitle: const Text(
                        "By Selecting this only you will see it at home",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    },
    child: Row(
      children: [
        Text("${privacyStatus}", style: CaydroTextStyles.randomStyle),
        const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
      ],
    ),
  );
}

showBottomSheetForPostPage(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const Center(
                child: Divider(
                  color: CaydroColors.greyColor,
                  thickness: 4,
                  endIndent: 170,
                  indent: 170,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text("Photo/Video",
                    style: CaydroTextStyles.chooseFont),
                leading: const Icon(
                  Icons.browse_gallery,
                  size: 25,
                  color: CaydroColors.BlueGreyColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text("Camera", style: CaydroTextStyles.chooseFont),
                leading: const Icon(
                  Icons.camera_enhance,
                  size: 25,
                  color: CaydroColors.BlueGreyColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const Text("Tag a friend",
                    style: CaydroTextStyles.chooseFont),
                leading: const Icon(
                  Icons.person_add,
                  size: 25,
                  color: CaydroColors.BlueGreyColor,
                ),
              ),
              ListTile(
                onTap: () {},
                title:
                    const Text("Check in", style: CaydroTextStyles.chooseFont),
                leading: const Icon(
                  Icons.location_on_rounded,
                  size: 25,
                  color: CaydroColors.BlueGreyColor,
                ),
              ),
            ],
          ),
        );
      });
}
