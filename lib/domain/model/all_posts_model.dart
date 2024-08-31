class AllPostsModel {
  final String id;
  final String userId;
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
    required this.userId,
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
      userId: json['userId'],
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

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'image': image,
      'description': description,
      'date': date.toIso8601String(),
      'likes': likes,
      'hidden': hidden,
      'blocked': blocked,
      'tags': tags,
      'taggedUsers': taggedUsers,
      'edited': edited.toIso8601String(),
      'commentCount': commentCount,
    };
  }
}
