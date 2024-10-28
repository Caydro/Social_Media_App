import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Cubit/posts/postsState.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<PostsCubitState> {
  PostsCubit() : super(AddPostsWithNoPhotoCubitStateInitial());
  addPostWithNoPhoto(
      {required int userID,
      required String postString,
      required String postPrivacy}) async {
    emit(AddPostsWithNoPhotoCubitStateLoading());
    Future.delayed(const Duration(milliseconds: 1900), () async {
      Map<String, dynamic> addPost = await customHttpRequest(
          url: ApiActionsLink.addPostWithNoPhotoApiLink,
          body: {
            'user_id': "$userID",
            'post_string': postString,
            'post_privacy': postPrivacy,
            "post_status": "noPhoto",
          });
      if (addPost.containsKey("success")) {
        emit(AddPostsWithNoPhotoCubitStateSuccess());
      } else if (addPost.containsKey("error")) {
        emit(AddPostsWithNoPhotoCubitStateFailed(
            "Failed to Add your post please try again"));
      } else {
        emit(
          AddPostsWithNoPhotoCubitStateFailed("Something Went wrong.."),
        );
      }
    });
  }

  showMyProfilePostWithNoPhoto({required int userID}) async {
    emit(ShowPostWithNoPhotoForProfileCubitLoading());
    List<Map<String, dynamic>> data = await customHttpRequestWithList(
        url: ApiActionsLink.showPostWithNoPhotoApiLink,
        body: {
          "user_id": "$userID",
        });
    if (data[0].isNotEmpty) {
      ////////// you need to handle the coming from back end as list<Map<String,dynamic>> not only map //////////////////////////
      emit(ShowPostWithNoPhotoForProfileCubitSuccess(data));
    } else if (data[0].containsKey("error")) {
      emit(
        ShowPostWithNoPhotoForProfileCubitFailed(data[0]['error']),
      );
    } else {
      emit(ShowPostWithNoPhotoForProfileCubitFailed("Something Went wrong.."));
    }
  }

  showUsersPostWithNoPhoto({required int userID}) async {
    emit(ShowPostWithNoPhotoForUsersCubitLoading());
    List<Map<String, dynamic>> data = await customHttpRequestWithList(
        url: ApiActionsLink.showPostWithNoPhotoForUsersApiLink,
        body: {
          "user_id": "$userID",
          "post_privacy": "anyOne",
        });
    if (data[0].isNotEmpty) {
      ////////// you need to handle the coming from back end as list<Map<String,dynamic>> not only map //////////////////////////
      emit(ShowPostWithNoPhotoForUsersCubitSuccess(data));
    } else if (data[0].isNotEmpty && data[0].containsKey("noPosts")) {
      emit(
        ShowPostWithNoPhotoForUsersCubitFailed(data[0]['noPosts']),
      );
    } else {
      emit(ShowPostWithNoPhotoForUsersCubitFailed("Something Went wrong.."));
    }
  }

  showHomePagePostsWithNoPhoto({required int userID}) async {
    emit(ShowHomePagePostsWithNoPhotoLoading());
    try {
      // Fetch data using your custom HTTP request function
      List<Map<String, dynamic>> data = await customHttpRequestWithList(
        url: ApiActionsLink.showHomePagePostsWithNoPhoto,
        body: {
          "user_id": "$userID",
        },
      );

      // Check if data is not empty
      if (data.isNotEmpty) {
        // Check if the first element does not contain the "error" key
        if (!data[0].containsKey("error")) {
          emit(ShowHomePagePostsWithNoPhotoSuccess(data)); // Success case
          print(data);
        } else {
          emit(ShowHomePagePostsWithNoPhotoFailed(
              data[0]['error'])); // Error in the data
        }
      } else {
        emit(ShowHomePagePostsWithNoPhotoFailed(
            "Something Went wrong..")); // Empty data
      }
    } catch (e) {
      emit(ShowHomePagePostsWithNoPhotoFailed(
          "Error: $e")); // Exception occurred
    }
  }
}
