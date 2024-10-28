import 'package:collagiey/Core/ApiLinks.dart';
import 'package:collagiey/Cubit/searchForFriends/searchFriendsState.dart';
import 'package:collagiey/Service/custom_HttpRequest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchForUsersCubit extends Cubit<SearchForUsersState> {
  SearchForUsersCubit() : super(SearchForUsersStateInitial());

  showUsersWithALetter({required String userName, required int userID}) async {
    emit(SearchForUsersStateLoading());

    List<Map<String, dynamic>> data = await customHttpRequestWithList(
      url: ApiActionsLink.showUsersInSearch,
      body: {
        "user_name": userName,
        "user_id": "$userID",
      },
    );

    // Check if the first item is a Map containing an 'error' key
    if (data.isNotEmpty && data[0].containsKey("error")) {
      // Error case: the backend returned an error message
      emit(SearchForUsersStateFailed(data[0]['error']));
    } else if (data.isNotEmpty && data[0].isNotEmpty) {
      // Success case: data is returned as a list of user maps
      emit(SearchForUsersStateSuccess(data));
    } else {
      // Handle case where data is empty but no specific error is given
      emit(SearchForUsersStateFailed("No users found with the given username"));
    }

    print(data);
  }
}
