import 'package:collagiey/Core/testStyles.dart';
import 'package:collagiey/Cubit/photosCubit/photos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

removeCirlcePhotoDialog({required BuildContext context, required int userID}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        BlocProvider.of<PhotosCubit>(context)
                            .deleteCirclePhoto(userID: userID);
                      },
                      child: const Text(
                        "Delete",
                        style:
                            CaydroTextStyles.textButtonStylesForChoosingDelete,
                      )),
                ),
                const Divider(),
                Expanded(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: CaydroTextStyles.textButtonStylesForChoosing,
                      )),
                ),
              ],
            ),
          ),
        );
      });
}
