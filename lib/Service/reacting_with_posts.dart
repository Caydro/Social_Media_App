import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';

class PostsReact {
  addLikeToAnyPostByPostIDAndUserID(
      {required int postID, required int userID}) async {
    Map<String, dynamic> request =
        await customHttpRequest(url: ApiActionsLink.addLikeToAnyPost, body: {
      "post_id": "$postID",
      "user_id": "$userID",
    });
    if (request.containsKey("success")) {
      print("Liked");
    } else if (request.containsKey("error")) {
      print("Failed");
    } else {
      print("Failed");
    }
  }

  deleteLikeToAnyPostByPostIDAndUserID(
      {required int postID, required int userID}) async {
    Map<String, dynamic> request =
        await customHttpRequest(url: ApiActionsLink.deleteLikeToAnyPost, body: {
      "post_id": "$postID",
      "user_id": "$userID",
    });
    if (request.containsKey("success")) {
      print("Success");
    } else if (request.containsKey("error")) {
      print("error");
    } else {
      print("error Somthing happend wrong");
    }
  }
}
