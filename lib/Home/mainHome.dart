import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_cubit.dart';
import 'package:collagiey/Home/home_Body.dart';
import 'package:collagiey/Home/home_upper_And_Logo.dart';
import 'package:collagiey/Home/notifications_Home.dart';
import 'package:collagiey/Home/profile_Page.dart';
import 'package:collagiey/Home/videos_Home.dart';
import 'package:collagiey/Widgets/post_No_Photo.dart';
import 'package:collagiey/Widgets/post_button.dart';
import 'package:collagiey/Widgets/post_with_Photo.dart';
import 'package:collagiey/Widgets/settingWidget.dart';
import 'package:collagiey/Widgets/story_ListView_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.userID,
  });
  final int? userID;
  @override
  State<HomePage> createState() => _HomePageState();
}

int mainIndex = 1;

class _HomePageState extends State<HomePage> {
  void initState() {
    // TODO: implement initState
    BlocProvider.of<UserInfoCubit>(context)
        .getAllUserInfo(userID: widget.userID!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Drawer(
        child: settingDrawerPage(width: screenWidth),
      ),
      body: getSelectedFromBottomNavigationBar(index: mainIndex),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.08,
          maxWidth: MediaQuery.of(context).size.width,
          index: mainIndex,
          onTap: (selectedIndex) {
            setState(() {
              mainIndex = selectedIndex;
            });
          },
          items: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_settings_rounded,
                  color: CaydroColors.BlueGreyColor,
                ),
                Text(
                  "Videos",
                  style: CaydroTextStyles.bottomNavigationChooseTextStyle,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: CaydroColors.BlueGreyColor,
                ),
                Text(
                  "Home",
                  style: CaydroTextStyles.bottomNavigationChooseTextStyle,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications,
                  color: CaydroColors.BlueGreyColor,
                ),
                Text(
                  "Notifications",
                  style: CaydroTextStyles.bottomNavigationChooseTextStyle,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 15,
                  backgroundImage:
                      AssetImage("${CaydroImagesPath.noProfileImage}"),
                ),
                Text(
                  "Profile",
                  style: CaydroTextStyles.bottomNavigationChooseTextStyle,
                ),
              ],
            ),
          ]),
    );
  }
}

Widget getSelectedFromBottomNavigationBar({required int index}) {
  Widget widget;
  switch (index) {
    case 0:
      widget = const VideosHomePage();
      break;
    case 1:
      widget = const HomePageBody();
      break;
    case 2:
      widget = const NotificationsHomePage();
      break;
    case 3:
      widget = const ProfileHomePage();
    default:
      widget = const HomePageBody();
  }
  return widget;
}
