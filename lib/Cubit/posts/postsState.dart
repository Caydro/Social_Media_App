abstract class PostsCubitState {}

/////////////////////////////////// ADD POSTS STATES ///////////////////////////////////////
class AddPostsWithNoPhotoCubitStateInitial extends PostsCubitState {}

class AddPostsWithNoPhotoCubitStateLoading extends PostsCubitState {}

class AddPostsWithNoPhotoCubitStateFailed extends PostsCubitState {
  final String? errMessage;
  AddPostsWithNoPhotoCubitStateFailed(this.errMessage);
}

class AddPostsWithNoPhotoCubitStateSuccess extends PostsCubitState {}

/////////////////////////// SHOW THE POSTS WITHOUT PHOTOS /////////////////////////////////////////////
class ShowPostWithNoPhotoForProfileCubitInitial extends PostsCubitState {}

class ShowPostWithNoPhotoForProfileCubitLoading extends PostsCubitState {}

class ShowPostWithNoPhotoForProfileCubitFailed extends PostsCubitState {
  final String? errMessage;
  ShowPostWithNoPhotoForProfileCubitFailed(this.errMessage);
}

class ShowPostWithNoPhotoForProfileCubitSuccess extends PostsCubitState {
  final List<Map<String, dynamic>>? data;
  ShowPostWithNoPhotoForProfileCubitSuccess(this.data);
}

////////////////////// SHOW THE POSTS WITHOUT PHOTOS FOR STRANGE USERS //////////////////////
class ShowPostWithNoPhotoForUsersCubitInitial extends PostsCubitState {}

class ShowPostWithNoPhotoForUsersCubitLoading extends PostsCubitState {}

class ShowPostWithNoPhotoForUsersCubitFailed extends PostsCubitState {
  final String? errMessage;
  ShowPostWithNoPhotoForUsersCubitFailed(this.errMessage);
}

class ShowPostWithNoPhotoForUsersCubitSuccess extends PostsCubitState {
  final List<Map<String, dynamic>>? data;
  ShowPostWithNoPhotoForUsersCubitSuccess(this.data);
}

////////////////////////////////// homePage Posts ////////////////////////////////////////////////

class ShowHomePagePostsWithNoPhotoSuccess extends PostsCubitState {
  final List<Map<String, dynamic>>? data;
  ShowHomePagePostsWithNoPhotoSuccess(this.data);
}

class ShowHomePagePostsWithNoPhotoLoading extends PostsCubitState {}

class ShowHomePagePostsWithNoPhotoFailed extends PostsCubitState {
  final String? errMessage;
  ShowHomePagePostsWithNoPhotoFailed(this.errMessage);
}
