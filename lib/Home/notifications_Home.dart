import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/friend_requests/friend_requestCubit.dart';
import 'package:collagiey/Cubit/friend_requests/friend_requestState.dart';
import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_cubit.dart';
import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_state.dart';
import 'package:collagiey/Service/shared_Prefrence_Method.dart';
import 'package:collagiey/Widgets/friendRequest_Notification.dart';
import 'package:collagiey/Widgets/pendingDialog_widget.dart';

class NotificationsHomePage extends StatefulWidget {
  const NotificationsHomePage({super.key});

  @override
  State<NotificationsHomePage> createState() => _NotificationsHomePageState();
}

class _NotificationsHomePageState extends State<NotificationsHomePage> {
  Map<int, Map<String, dynamic>> usersInfoMap = {};
  int? myUserID;

  @override
  void initState() {
    super.initState();
    blocActivation();
  }

  blocActivation() async {
    int userID = await SharedPrefrencesOptions().showUserID();
    BlocProvider.of<FriendRequestCubit>(context).myFriendRequests(myID: userID);
    myUserID = userID;
  }

  fetchUserInfo(int senderID) async {
    await BlocProvider.of<UserInfoCubit>(context)
        .getAllUserInfo(userID: senderID);
    final userInfoState = BlocProvider.of<UserInfoCubit>(context).state;

    if (userInfoState is UserInfoStateSuccess) {
      usersInfoMap[senderID] = userInfoState.data;
    } else {
      usersInfoMap[senderID] = {
        'circle_background': null,
        'userName': 'Unknown User',
      };
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Notifications",
              style: CaydroTextStyles.NotificationTitleStyle,
            ),
            const Divider(),
            BlocBuilder<FriendRequestCubit, FriendRequestState>(
              builder: (context, state) {
                if (state is MyFriendRequestsStateSuccess) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, item) {
                        int? senderID = state.data[item]['sender'];
                        int? friendRequestID = state.data[item]['request_id'];
                        if (senderID == null) {
                          return const Center(
                            child: Text("There's No Notification"),
                          );
                        }

                        if (!usersInfoMap.containsKey(senderID)) {
                          fetchUserInfo(senderID);
                        }

                        var user = usersInfoMap[senderID] ?? {};
                        String? circleBackground = user['circle_background'];
                        String? userName = user['userName'];

                        return BlocListener<FriendRequestCubit,
                            FriendRequestState>(
                          listener: (context, state) {
                            if (state is AddFriendRequestActionSuccess) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Friend Request accepted"),
                              ));
                            } else if (state is AddFriendRequestActionFailed) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Something went wrong"),
                              ));
                            }
                          },
                          child: FriendRequestWidget(
                            userOfAddImage: circleBackground != null
                                ? "${MySqlImagePath.circlePhotoPath}/$circleBackground"
                                : "default_image_path",
                            userOfAddName: userName ?? "Unknown User",
                            acceptFriendRequest: () {
                              ////////////// HERE YOU NEED TO ADD ALL ///// user the cubit
                              BlocProvider.of<FriendRequestCubit>(context)
                                  .acceptFriendRequest(
                                requestID: friendRequestID!,
                              );
                              setState(() {
                                state.data.removeAt(item);
                              });
                            },
                            cancelFriendRequest: () {
                              penddingDialog(
                                myUserID: myUserID!,
                                context: context,
                                otherUserID: senderID,
                                onCanlingRequest: () {
                                  BlocProvider.of<FriendRequestCubit>(context)
                                      .cancelingMyFriendRequest(
                                    request_id: friendRequestID!,
                                  );
                                  setState(() {
                                    state.data.removeAt(item);
                                  });
                                },
                                onBlockThisUser: () {},
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is MyFriendRequestsStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: CaydroColors.mainColor,
                    ),
                  );
                } else if (state is MyFriendRequestsStateFailed) {
                  return const Center(
                    child: Text("There's No Notification"),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
