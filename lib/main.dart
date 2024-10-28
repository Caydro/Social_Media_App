import 'package:collagiey/Core/routesOfPages.dart';
import 'package:collagiey/Cubit/authentication/authenticationCubit.dart';
import 'package:collagiey/Cubit/circleBackandBirthDayCubit/circleCubit.dart';
import 'package:collagiey/Cubit/friend_requests/friend_requestCubit.dart';
import 'package:collagiey/Cubit/photosCubit/photos_cubit.dart';
import 'package:collagiey/Cubit/posts/postsCubit.dart';
import 'package:collagiey/Cubit/searchForFriends/searchFriendsCubit.dart';
import 'package:collagiey/Cubit/stories/stories_cubit.dart';
import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_cubit.dart';
import 'package:collagiey/Home/mainHome.dart';
import 'package:collagiey/Pages/date_and_circlePhoto_Pick.dart';
import 'package:collagiey/Pages/sign_Up_Page.dart';
import 'package:collagiey/Widgets/sign_In_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    const MainHome(),
  );
}

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => PhotosCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => CircleAndBirthdayCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => UserInfoCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => PostsCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => SearchForUsersCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => FriendRequestCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => StoriesCubit(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignInPage(),
        routes: CaydroRoutesPages(context: context).allRoutes,
      ),
    );
  }
}
