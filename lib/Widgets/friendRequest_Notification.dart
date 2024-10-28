import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/testStyles.dart';
import 'package:flutter/material.dart';

class FriendRequestWidget extends StatelessWidget {
  const FriendRequestWidget({
    super.key,
    required this.userOfAddImage,
    required this.userOfAddName,
    required this.acceptFriendRequest,
    required this.cancelFriendRequest,
  });
  final String? userOfAddImage;
  final String? userOfAddName;
  final Function? acceptFriendRequest;
  final Function? cancelFriendRequest;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    /////////////////////////////////// PROFILE OF USER THAT SENT THE ADD  //////////////////////////////////////////////////
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userOfAddImage!),
                    maxRadius: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    /////////////////////////////////// PROFILE OF USER THAT SENT THE ADD  //////////////////////////////////////////////////
                  },
                  child: Text(
                    "\t ${userOfAddName}",
                    style: const TextStyle(
                      fontFamily: "splashFont",
                      color: CaydroColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              " Has sent you a friend request",
              maxLines: 2,
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: CaydroColors.mainColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.15, vertical: 10),
                  ),
                  child: const Text(
                    "Accept",
                    style: CaydroTextStyles.ElevatedButtonTextStyle,
                  ),
                  onPressed: () {
                    ///////////////////////////////// Accept Button    ///////////////////////////////////
                    acceptFriendRequest!.call();
                  },
                ),
                SizedBox(width: width * 0.04),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: CaydroColors.BlueGreyColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.15, vertical: 10),
                  ),
                  child: const Text(
                    "Cancel",
                    style: CaydroTextStyles.ElevatedButtonTextStyle,
                  ),
                  onPressed: () {
                    ///////////////////////////////// Cancel Button    ///////////////////////////////////
                    cancelFriendRequest!.call();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
