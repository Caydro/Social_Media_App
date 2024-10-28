abstract class StoriesState {}

/////////////////////////////////////////////       add text stories ////////////////////////////////////////////
class AddTextStoriesStateInitial extends StoriesState {}

class AddTextStoriesStateSuccess extends StoriesState {}

class AddTextStoriesStateLoading extends StoriesState {}

class AddTextStoriesStateFailed extends StoriesState {
  final String? errMessage;
  AddTextStoriesStateFailed(this.errMessage);
}
/////////////////////////////////  add photo stories /////////////////////////////////////////

class AddPhotoStoriesStateSuccess extends StoriesState {}

class AddPhotoStoriesStateLoading extends StoriesState {}

class AddPhotoStoriesStateFailed extends StoriesState {
  final String? errMessage;
  AddPhotoStoriesStateFailed(this.errMessage);
}

///////////////////////////////////// show Home page Stories ///////////////////////////////////////
class ShowHomePageStoriesStateSuccess extends StoriesState {
  final List<Map<String, dynamic>>? data;
  ShowHomePageStoriesStateSuccess(this.data);
}

class ShowHomePageStoriesStateLoading extends StoriesState {}

class ShowHomePageStoriesStateFailed extends StoriesState {
  final String? errMessage;
  ShowHomePageStoriesStateFailed(this.errMessage);
}

/////////////////////////////////// show every user Stories ////////////////////////////////
class ShowEveryUserStoriesStateSuccess extends StoriesState {
  final List<Map<String, dynamic>>? data;
  ShowEveryUserStoriesStateSuccess(this.data);
}

class ShowEveryUserStoriesStateLoading extends StoriesState {}

class ShowEveryUserStoriesStateFailed extends StoriesState {
  final String? errMessage;
  ShowEveryUserStoriesStateFailed(this.errMessage);
}
