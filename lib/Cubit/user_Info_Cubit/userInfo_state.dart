abstract class UserInfoState {}

class UserInfoStateInitial extends UserInfoState {}

class UserInfoStateFailed extends UserInfoState {
  final String? errMessage;

  UserInfoStateFailed(this.errMessage);
}

class UserInfoStateSuccess extends UserInfoState {
  final Map<String, dynamic> data;
  UserInfoStateSuccess(this.data);
}

class UserInfoStateLoading extends UserInfoState {}
