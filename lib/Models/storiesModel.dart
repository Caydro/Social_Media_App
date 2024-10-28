class StoryModel {
  final int storyID;
  final int userID;
  final String userName;
  final String circleBackground;
  final String storyContent;
  final int likes;
  final int comments;
  final int shares;
  final String createdAt;
  final String contentType;
  final String backgroundColor;

  StoryModel({
    required this.userName,
    required this.storyID,
    required this.userID,
    required this.circleBackground,
    required this.storyContent,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.createdAt,
    required this.contentType,
    required this.backgroundColor,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      userName: json['user_name'],
      storyID: json['story_id'],
      userID: json['user_id'],
      storyContent: json['content'],
      backgroundColor: json['background_color'],
      circleBackground: json['circlePhoto'],
      contentType: json['content_type'],
      likes: json['likes'],
      comments: json['comments'],
      shares: json['sharesOfStory'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'story_id': storyID,
      'user_id': userID,
      'userName': userName,
      'circle_background': circleBackground,
      'story_content': storyContent,
      'likes': likes,
      'comments': comments,
      'sharesOfStory': shares,
      'created_at': createdAt,
      'content_type': contentType,
      'background_color': backgroundColor,
    };
  }
}
