
class User {
  final String id;
  final String userName;
  final String email;
  final String profilePic;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      profilePic: json['profilePic'],
    );
  }
}
class AllPostsModel {
  final String id;
  final User? userId; // Make userId nullable
  final String image;
  final String? description;
  final DateTime date;
  final List<String> likes;
  final bool hidden;
  final bool blocked;
  final List<String> tags;
  final List<String> taggedUsers;
  final DateTime edited;
  final int commentCount;

  AllPostsModel({
    required this.id,
    this.userId, // Nullable userId
    required this.image,
    this.description,
    required this.date,
    required this.likes,
    required this.hidden,
    required this.blocked,
    required this.tags,
    required this.taggedUsers,
    required this.edited,
    required this.commentCount,
  });

  factory AllPostsModel.fromJson(Map<String, dynamic> json) {
    return AllPostsModel(
      id: json['_id'],
      userId: json['userId'] != null && json['userId'] is Map ? User.fromJson(json['userId']) : null,
      image: json['image'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      likes: List<String>.from(json['likes']),
      hidden: json['hidden'],
      blocked: json['blocked'],
      tags: List<String>.from(json['tags']),
      taggedUsers: List<String>.from(json['taggedUsers']),
      edited: DateTime.parse(json['edited']),
      commentCount: json['commentCount'],
    );
  }











    static List<AllPostsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AllPostsModel.fromJson(json)).toList();
  }
}
