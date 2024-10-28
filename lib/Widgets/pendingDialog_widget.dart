import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/friend_requests/friend_requestCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

penddingDialog({
  required BuildContext context,
  required int myUserID,
  required int otherUserID,
  required Function onCanlingRequest,
  required Function onBlockThisUser,
}) {
  showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: AlertDialog(
            content: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        onBlockThisUser.call();
                      },
                      child: const Text(
                        "Block this user",
                        style: CaydroTextStyles.TextButtonStyle,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        onCanlingRequest.call();
                        BlocProvider.of<FriendRequestCubit>(context)
                            .checkForFriendRequest(myUserID, otherUserID);
                      },
                      child: const Text(
                        "Cancel your request",
                        style: CaydroTextStyles.TextButtonStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
