abstract class CirclePhotoAndBirthdayState {}

class CirclePhotoAndBirthStateInitial extends CirclePhotoAndBirthdayState {}

class CirclePhotoAndBirthStateFailed extends CirclePhotoAndBirthdayState {
  final String error;
  CirclePhotoAndBirthStateFailed(this.error);
}

class CirclePhotoAndBirthStateloading extends CirclePhotoAndBirthdayState {}

class CirclePhotoAndBirthStateSuccess extends CirclePhotoAndBirthdayState {
  final Map<String, dynamic> imageName;
  CirclePhotoAndBirthStateSuccess(this.imageName);
}
