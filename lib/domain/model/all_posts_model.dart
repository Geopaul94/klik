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

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'email': email,
      'profilePic': profilePic,
    };
  }
}


// class AllPostsModel {
//   final String id;
//   final User? userId; // Make userId nullable
//   final String image;
//   final String? description;
//   final DateTime date;
//   final List<User> likes;
//   final bool hidden;
//   final bool blocked;
//   final List<String> tags;
//   final List<String> taggedUsers;
//   final DateTime edited;
//   final int commentCount;
  
//   DateTime createdAt;
//   DateTime updatedAt;
//   int? v;
//   bool? isLiked;
//   bool? isSaved;
//   DateTime? editedTime;
  




//   AllPostsModel({
//     required this.id,
//     this.userId, // Nullable userId
//     required this.image,
//     this.description,
//     required this.date,
//     required this.likes,
//     required this.hidden,
//     required this.blocked,
//     required this.tags,
//     required this.taggedUsers,
//     required this.edited,
//     required this.commentCount, required this.createdAt,
//       required this.updatedAt,
//       required this.v,
//       this.isLiked,
//       this.isSaved,
//       this.editedTime,
//   });

//   factory AllPostsModel.fromJson(Map<String, dynamic> json) {
//     return AllPostsModel(
//       id: json['_id'],
//       userId: json['userId'] != null && json['userId'] is Map
//           ? User.fromJson(json['userId'])
//           : null,
//       image: json['image'],
//       description: json['description'],
//       date: DateTime.parse(json['date']),
//       likes: (json['likes'] as List<dynamic>)
//           .map((like) => User.fromJson(like))
//           .toList(),
//       hidden: json['hidden'],
//       blocked: json['blocked'],
//       tags: List<String>.from(json['tags']),
//       taggedUsers: List<String>.from(json['taggedUsers']),createdAt: DateTime.parse(json["createdAt"]),
//           updatedAt: DateTime.parse(json["updatedAt"]),
//           v: json["__v"],
//       edited: DateTime.parse(json['edited']),
//       commentCount: json['commentCount'],
//     );
//   }





//   static List<AllPostsModel> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((json) => AllPostsModel.fromJson(json)).toList();
//   }
// }


class AllPostsModel {
  final String id;
  final User? userId; // Make userId nullable
  final String image;
  final String? description;
  final DateTime date;
  final List<User> likes;
  final bool hidden;
  final bool blocked;
  final List<String> tags;
  final List<String> taggedUsers;
  final DateTime edited;
  final int commentCount;
  
  DateTime createdAt;
  DateTime updatedAt;
  int? v;
  bool? isLiked;
  bool? isSaved;
  DateTime? editedTime;

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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.isLiked,
    this.isSaved,
    this.editedTime,
  });

  factory AllPostsModel.fromJson(Map<String, dynamic> json) {
    return AllPostsModel(
      id: json['_id'],
      userId: json['userId'] != null && json['userId'] is Map
          ? User.fromJson(json['userId'])
          : null,
      image: json['image'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      likes: (json['likes'] as List<dynamic>)
          .map((like) => User.fromJson(like))
          .toList(),
      hidden: json['hidden'],
      blocked: json['blocked'],
      tags: List<String>.from(json['tags']),
      taggedUsers: List<String>.from(json['taggedUsers']),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
      edited: DateTime.parse(json['edited']),
      commentCount: json['commentCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId?.toJson(), // Call toJson on userId if not null
      'image': image,
      'description': description,
      'date': date.toIso8601String(), // Convert DateTime to ISO string
      'likes': likes.map((user) => user.toJson()).toList(), // Convert each user in likes to JSON
      'hidden': hidden,
      'blocked': blocked,
      'tags': tags,
      'taggedUsers': taggedUsers,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'edited': edited.toIso8601String(),
      'commentCount': commentCount,
      'isLiked': isLiked,
      'isSaved': isSaved,
      'editedTime': editedTime?.toIso8601String(),
    };
  }

  static List<AllPostsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AllPostsModel.fromJson(json)).toList();
  }
}
