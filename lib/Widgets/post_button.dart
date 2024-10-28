import 'package:collagiey/Core/Colors.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Core/routesOfPages.dart';
import 'package:collagiey/Cubit/photosCubit/photos_cubit.dart';
import 'package:collagiey/Cubit/photosCubit/photos_state.dart';
import 'package:collagiey/Home/SHARE_POST_UIPAGE.dart';
import 'package:collagiey/Models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPostButton extends StatelessWidget {
  CustomPostButton({super.key, this.userData});
  UserModel? userData;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        /////////////////////////////////////////////////////////              POST BUTTON FOR POSTS      ///////////////////////////////////////////////////////////
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SharePostsPageUI(
                  userData: userData!,
                )));
      },
      child: Row(
        children: [
          SizedBox(
            width: width * 0.01,
          ),
          BlocBuilder<PhotosCubit, PhotosState>(
            builder: (context, state) {
              if (state is DeleteCirclePhotoStateSuccess) {
                return const CircleAvatar(
                  radius: 25,
                  ///////////       CALL IT AND TRY TO MAKE IT AS IF NULL MAKE IT  WITH NO CIRCLE PHOTO///////////////////////
                  backgroundImage: NetworkImage(CaydroImagesPath.noCirclePhoto),
                );
              } else if (state is DeleteCirclePhotoStateFailed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errMessage!)));
                return Container();
              } else if (state is DeleteCirclePhotoStateLoading) {
                return const CircularProgressIndicator(
                  color: CaydroColors.mainColor,
                );
              } else {
                return CircleAvatar(
                  radius: 25,
                  ///////////       CALL IT AND TRY TO MAKE IT AS IF NULL MAKE IT  WITH NO CIRCLE PHOTO///////////////////////
                  backgroundImage: NetworkImage(
                      "${MySqlImagePath.circlePhotoPath}/${userData!.circleBackground}"),
                );
              }
            },
          ),
          SizedBox(
            width: width * 0.03,
          ),
          const Text(
            "What's in your mind?",
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.photo_library_rounded,
                color: CaydroColors.mainColor,
              )),
        ],
      ),
    );
  }
}
