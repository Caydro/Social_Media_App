import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';

class DeletePhotos {
  deleteCircleBackground({required int userID}) async {
    customHttpRequest(url: ApiActionsLink.deleteCircleBackground, body: {
      "user_id": "$userID",
    });
  }
}
