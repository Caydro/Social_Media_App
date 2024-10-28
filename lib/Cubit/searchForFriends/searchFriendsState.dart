abstract class SearchForUsersState {}

class SearchForUsersStateInitial extends SearchForUsersState {}

class SearchForUsersStateLoading extends SearchForUsersState {}

class SearchForUsersStateSuccess extends SearchForUsersState {
  final List<Map<String, dynamic>> data;
  SearchForUsersStateSuccess(this.data);
}

class SearchForUsersStateFailed extends SearchForUsersState {
  final String errMessage;
  SearchForUsersStateFailed(this.errMessage);
}
