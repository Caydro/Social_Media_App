import 'package:collagiey/Home/SHARE_POST_UIPAGE.dart';
import 'package:collagiey/Home/Stories_View_Page.dart';
import 'package:collagiey/Home/home_Body.dart';
import 'package:collagiey/Home/mainHome.dart';
import 'package:collagiey/Pages/date_and_circlePhoto_Pick.dart';
import 'package:collagiey/Pages/sign_Up_Page.dart';
import 'package:collagiey/Widgets/sign_In_Page.dart';
import 'package:flutter/material.dart';

/////////////////      NAMES OF  ROUTES  ///////////////////////////////////////////
class NamesOfRoutes {
  static String signUpRoute = "signUp";
  static String signInRoute = "signIn";
  static String storyView = "storyView";

  static String selectPhotoAndBirthDay = "photoAndBirthDayPage";
  static String homePage = "homePage";
}

////////////////////////////////// ALL ROUTES ///////////////////////////////////////////////
class CaydroRoutesPages {
  CaydroRoutesPages({required this.context});
  final BuildContext? context;

  var allRoutes = {
    NamesOfRoutes.signUpRoute: (context) => const SignUpPage(),
    NamesOfRoutes.selectPhotoAndBirthDay: (context) =>
        BirthDayAndCirclePhotoPage(),
    NamesOfRoutes.signInRoute: (context) => SignInPage(),
    NamesOfRoutes.homePage: (context) => const HomePage(),
    NamesOfRoutes.storyView: (context) => const StoriesViewPage(),
  };
}
