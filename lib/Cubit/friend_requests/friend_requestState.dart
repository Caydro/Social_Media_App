abstract class FriendRequestState {}

/////////////////////////////////////// check for friend request /////////////////////////////////////////////////

class CheckForFriendRequestStateInitial extends FriendRequestState {}

class CheckForFriendRequestStateLoading extends FriendRequestState {}

class CheckForFriendRequestStateThereIsNoRequest extends FriendRequestState {}

class CheckForFriendRequestStateThereIsRequest extends FriendRequestState {}

/////////////////////////////////////Friend Request ///////////////////////////////////////
class FriendRequestStateInitial extends FriendRequestState {}

class FriendRequestStateLoading extends FriendRequestState {}

class FriendRequestStateFailed extends FriendRequestState {}

class FriendRequestStateSuccess extends FriendRequestState {}

///////////////////////////////////////////  check for my requests //////////////////////////////////////

class MyFriendRequestsStateInitial extends FriendRequestState {}

class MyFriendRequestsStateLoading extends FriendRequestState {}

class MyFriendRequestsStateFailed extends FriendRequestState {
  final String? errMessage;
  MyFriendRequestsStateFailed(this.errMessage);
}

class MyFriendRequestsStateSuccess extends FriendRequestState {
  final List<Map<String, dynamic>> data;
  MyFriendRequestsStateSuccess(this.data);
}
////////////////////////////////// canceling my friend request /////////////////////////////////////////////////////////

class CancelMyFriendRequestStateInitial extends FriendRequestState {}

class CancelMyFriendRequestStateLoading extends FriendRequestState {}

class CancelMyFriendRequestStateFailed extends FriendRequestState {}

class CancelMyFriendRequestStateSuccess extends FriendRequestState {}
/////////////////////////////////////                  add friend states ////////////////////////////////////////

class AddFriendRequestActionSuccess extends FriendRequestState {}

class AddFriendRequestActionLoading extends FriendRequestState {}

class AddFriendRequestActionFailed extends FriendRequestState {}
