import 'package:collagiey/Cubit/user_Info_Cubit/userInfo_state.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoStateInitial());
  getAllUserInfo({required int userID}) async {
    emit(UserInfoStateLoading());
    Map<String, dynamic> data = await customHttpRequest(
        url: "http://192.168.1.47/collagiey/userInfo/userAllInfo.php",
        body: {
          "userID": "$userID",
        });
    if (data.containsKey("success")) {
      emit(UserInfoStateSuccess(data));
    } else if (data.containsKey("error")) {
      emit(UserInfoStateFailed(data["error"]));
    } else {
      emit(UserInfoStateFailed(data["error"]));
    }
  }
}
