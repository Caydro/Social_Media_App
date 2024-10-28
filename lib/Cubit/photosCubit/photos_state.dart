abstract class PhotosState {}

////////////////////////////////////////// check No photo or not ////////////////////////////////////////
class CheckCirclePhotoStateNoPhoto extends PhotosState {}

class CheckCirclePhotoStatePhotoExists extends PhotosState {}

//////////////////////////////// Delete Circle Photo /////////////////////////////////////////////////

class DeleteCirclePhotoStateInitial extends PhotosState {}

class DeleteCirclePhotoStateSuccess extends PhotosState {
  final String? noPhotoName;
  DeleteCirclePhotoStateSuccess(this.noPhotoName);
}

class DeleteCirclePhotoStateLoading extends PhotosState {}

class DeleteCirclePhotoStateFailed extends PhotosState {
  final String? errMessage;
  DeleteCirclePhotoStateFailed(this.errMessage);
}

////////////////////////////////////////// change circle photo state /////////////////////////////////////////

class ChangeCirclePhotoStateSuccess extends PhotosState {}

class ChangeCirclePhotoStateLoading extends PhotosState {}

class ChangeCirclePhotoStateFailed extends PhotosState {}

///////////////////////////////////////////////////          update Cover Photo /////////////////////////////////////

class UpdateCoverPhotoStateSuccess extends PhotosState {}

class UpdateCoverPhotoStateLoading extends PhotosState {}

class UpdateCoverPhotoStateFailed extends PhotosState {}
//////////////////////////////////////////////  check cover exists //////////////////////////////////////

class CheckCoverExistNoCover extends PhotosState {}

class CheckCoverExistCoverIsReady extends PhotosState {
  final String? coverName;
  CheckCoverExistCoverIsReady(this.coverName);
}
