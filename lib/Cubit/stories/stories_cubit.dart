import 'dart:io';

import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Cubit/friend_requests/friend_requestState.dart';
import 'package:collagiey/Cubit/stories/stories_state.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';
import 'package:collagiey/Service/custom_fileHttpRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoriesCubit extends Cubit<StoriesState> {
  StoriesCubit() : super(AddTextStoriesStateInitial());
  addTextStoriesFunction(
      {required int userID,
      required String storyTextContent,
      required String backgroundColor}) async {
    emit(AddTextStoriesStateLoading());
    Map<String, dynamic> addStoryRequest = await customHttpRequest(
      url: ApiActionsLink.addTextStories,
      body: {
        "user_id": "$userID",
        "story_text_content": storyTextContent,
        "background_color": backgroundColor,
        "content_type": "text",
      },
    );
    if (addStoryRequest.containsKey("success")) {
      emit(AddTextStoriesStateSuccess());
    } else if (addStoryRequest.containsKey("error")) {
      emit(AddTextStoriesStateFailed(addStoryRequest["error"]));
    }
  }

  addPhotoStoriesFunction({required File file, required int userID}) async {
    emit(AddPhotoStoriesStateLoading());
    Map<String, dynamic> response = await CaydroCustomPostFile()
        .postHttpRequestFileMethod(
            url: ApiActionsLink.addPhotoStories,
            file: file,
            data: {
          'user_id': "$userID",
          "content_type": "photo",
        });
    if (response.containsKey("success")) {
      emit(AddPhotoStoriesStateSuccess());
    } else if (response.containsKey("error")) {
      emit(AddPhotoStoriesStateFailed(response['error']));
    } else {
      emit(AddPhotoStoriesStateFailed(response['error']));
    }
  }

  showHomePageStoriesForFriends({required int userID}) async {
    emit(ShowHomePageStoriesStateLoading());
    List<Map<String, dynamic>> data = await customHttpRequestWithList(
        url: ApiActionsLink.showHomePageStories,
        body: {
          "user_id": userID.toString(),
        });
    if (data.isNotEmpty) {
      // Check if the first element does not contain the "error" key
      if (!data[0].containsKey("error")) {
        emit(ShowHomePageStoriesStateSuccess(data)); // Success case
      } else {
        emit(ShowHomePageStoriesStateFailed(data[0]['error']));
        // Error in the data
      }
    } else {
      emit(ShowHomePageStoriesStateFailed(
          "Something Went wrong..")); // Empty data
    }
  }

  showEveryUserStories({required int userID}) async {
    emit(ShowEveryUserStoriesStateLoading());
    List<Map<String, dynamic>> data = await customHttpRequestWithList(
        url: ApiActionsLink.showEveryUserStories,
        body: {
          "user_id": "$userID",
        });
    if (data.isNotEmpty) {
      // Check if the first element does not contain the "error" key
      if (!data[0].containsKey("error")) {
        emit(ShowEveryUserStoriesStateSuccess(data)); // Success case
        print(data[0]);
      } else {
        emit(ShowEveryUserStoriesStateFailed(data[0]['error']));
        print(data[0]);
        // Error in the data
      }
    } else {
      emit(ShowEveryUserStoriesStateFailed(
          "Something Went wrong..")); // Empty data
    }
  }
}
