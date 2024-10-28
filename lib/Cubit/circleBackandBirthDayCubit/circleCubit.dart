import 'dart:io';

import 'package:collagiey/Cubit/circleBackandBirthDayCubit/circleState.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';
import 'package:collagiey/Service/custom_fileHttpRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:http/http.dart" as http;

class CircleAndBirthdayCubit extends Cubit<CirclePhotoAndBirthdayState> {
  CircleAndBirthdayCubit() : super(CirclePhotoAndBirthStateInitial());

  addCirclePhotoAndBirthdayFunc(
      {required int userID,
      required File file,
      required String birthDay}) async {
    emit(CirclePhotoAndBirthStateloading());
    Future.delayed(const Duration(seconds: 3), () async {
      Map<String, dynamic> response = await CaydroCustomPostFile()
          .postHttpRequestFileMethod(
              url:
                  "http://192.168.1.47/collagiey/profile/circleBackGroundAndBirthDayAdd.php",
              file: file,
              data: {
            'userID': "$userID",
            "birthDay": birthDay,
          });
      if (response.containsKey("success")) {
        emit(CirclePhotoAndBirthStateSuccess(response));
      } else if (response.containsKey("error")) {
        emit(CirclePhotoAndBirthStateFailed(response["error"].toString()));
      } else {
        emit(CirclePhotoAndBirthStateFailed("Somthing went wrong!"));
      }
    });
  }
}
