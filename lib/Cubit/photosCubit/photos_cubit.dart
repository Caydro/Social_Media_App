import 'dart:io';

import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Core/imagesPath.dart';
import 'package:collagiey/Cubit/circleBackandBirthDayCubit/circleState.dart';
import 'package:collagiey/Cubit/photosCubit/photos_state.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';
import 'package:collagiey/Service/custom_fileHttpRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosCubit extends Cubit<PhotosState> {
  PhotosCubit() : super(DeleteCirclePhotoStateInitial());
  deleteCirclePhoto({required int userID}) async {
    emit(DeleteCirclePhotoStateLoading());
    Map<String, dynamic> response = await customHttpRequest(
        url: ApiActionsLink.deleteCircleBackground,
        body: {
          "user_id": "$userID",
        });
    if (response.containsKey("success")) {
      emit(DeleteCirclePhotoStateSuccess(CaydroImagesPath.noProfileImage));
    } else if (response.containsKey("error")) {
      emit(DeleteCirclePhotoStateFailed(response['error']));
    } else {
      emit(DeleteCirclePhotoStateFailed(response['error']));
    }
  }

  checkCirclePhotoExist({required int userID}) async {
    Map<String, dynamic> response = await customHttpRequest(
        url: ApiActionsLink.checkCirclePhotoExists,
        body: {"user_id": "$userID"});
    if (response.containsKey("noPhoto")) {
      emit(CheckCirclePhotoStateNoPhoto());
    } else if (response.containsKey("photo")) {
      emit(CheckCirclePhotoStatePhotoExists());
    }
  }

  updateCirclePhoto({
    required File file,
    required int userID,
  }) async {
    Map<String, dynamic> response = await CaydroCustomPostFile()
        .postHttpRequestFileMethod(
            url: ApiActionsLink.updateCircleBackground,
            file: file,
            data: {
          'user_id': "$userID",
        });
    if (response.containsKey("success")) {
      emit(ChangeCirclePhotoStateSuccess());
      print(response);
    } else if (response.containsKey("error")) {
      emit(ChangeCirclePhotoStateFailed());
      print(response);
    } else {
      emit(ChangeCirclePhotoStateFailed());
      print(response);
    }
  }

  ///////////////////////////////////////                     Cover Plays //////////////////////////////////////////////////////////

  updateCoverPhoto({
    required File file,
    required int userID,
  }) async {
    emit(UpdateCoverPhotoStateLoading());
    Map<String, dynamic> response = await CaydroCustomPostFile()
        .postHttpRequestFileMethod(
            url: ApiActionsLink.updateCoverPhoto,
            file: file,
            data: {
          'user_id': "$userID",
        });
    if (response.containsKey("success")) {
      emit(UpdateCoverPhotoStateSuccess());
      print(response);
    } else if (response.containsKey("error")) {
      emit(UpdateCoverPhotoStateFailed());
      print(response);
    } else {
      emit(UpdateCoverPhotoStateFailed());
      print(response);
    }
  }

  checkIfCoverPhotoExist({required int userID}) async {
    Map<String, dynamic> response =
        await customHttpRequest(url: ApiActionsLink.checkCoverPhoto, body: {
      "user_id": "$userID",
    });
    if (response.containsKey("success")) {
      emit(CheckCoverExistCoverIsReady(response["success"]));
    } else if (response.containsKey("error")) {
      emit(CheckCoverExistNoCover());
    }
  }
}
