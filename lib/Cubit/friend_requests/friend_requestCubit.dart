import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Core/mySql_imagesPath.dart';
import 'package:collagiey/Cubit/friend_requests/friend_requestState.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendRequestCubit extends Cubit<FriendRequestState> {
  FriendRequestCubit() : super(FriendRequestStateInitial());
  checkForFriendRequest(int sender, int receiver) async {
    emit(FriendRequestStateLoading());
    Map<String, dynamic> request = await customHttpRequest(
        url: ApiActionsLink.checkForFriendRequest,
        body: {
          "sender": "$sender",
          "receiver": "$receiver",
        });
    if (request.containsKey("already")) {
      emit(CheckForFriendRequestStateThereIsRequest());
      print(request);
    } else if (request.containsKey("noRequest")) {
      emit(CheckForFriendRequestStateThereIsNoRequest());
      print(request);
    }
  }

  ////////////////////////// MAKE FRIEND REQUEST METHOD  /////////////////////////////////////////////////////////////
  makeFriendRequest(int sender, int receiver) async {
    emit(FriendRequestStateLoading());
    Map<String, dynamic> request =
        await customHttpRequest(url: ApiActionsLink.addFriendRequest, body: {
      "sender": "$sender",
      "receiver": "$receiver",
    });
    if (request.containsKey("success")) {
      emit(FriendRequestStateSuccess());
      print(request);
    } else if (request.containsKey("error")) {
      emit(FriendRequestStateFailed());
      print(request);
    }
  }

  myFriendRequests({required int myID}) async {
    emit(MyFriendRequestsStateLoading());
    List<Map<String, dynamic>> data = await customHttpRequestWithList(
        url: ApiActionsLink.myFriendRequests,
        body: {
          "receiver": "$myID",
        });
    if (data[0].isNotEmpty) {
      emit(MyFriendRequestsStateSuccess(data));
    } else if (data[0].containsKey("error")) {
      emit(MyFriendRequestsStateFailed(data[0]['error']));
    } else {
      emit(MyFriendRequestsStateFailed("There's No Friend Request"));
    }
  }

  cancelingMyFriendRequest({required int request_id}) async {
    emit(CancelMyFriendRequestStateLoading());
    Map<String, dynamic> deletingRequest = await customHttpRequest(
        url: ApiActionsLink.deletingTheFriendRequest,
        body: {
          "request_id": "$request_id",
        });
    if (deletingRequest.containsKey("success")) {
      emit(CancelMyFriendRequestStateSuccess());
      print(deletingRequest);
    } else if (deletingRequest.containsKey("error")) {
      emit(CancelMyFriendRequestStateFailed());
    }
  }

  acceptFriendRequest({required int requestID}) async {
    emit(AddFriendRequestActionLoading());
    Map<String, dynamic> request =
        await customHttpRequest(url: ApiActionsLink.acceptFriendRequest, body: {
      "request_id": "$requestID",
    });
    if (request.containsKey("success")) {
      emit(AddFriendRequestActionSuccess());
      print(request);
    } else if (request.containsKey("error")) {
      emit(AddFriendRequestActionFailed());
      print(request);
    } else {
      emit(AddFriendRequestActionFailed());
      print(request);
    }
  }
}
