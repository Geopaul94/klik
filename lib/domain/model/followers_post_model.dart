// class FollowersPostModel {
//   String id;
//   UserId userId;
//   String image;
//   String description;
//   List<UserId> likes;
//   bool hidden;
//   bool blocked;
//   List<String> tags;
//   List<TaggedUser> taggedUsers;
//   int CommentCount;
//   DateTime createdAt;
//   DateTime updatedAt;
//   DateTime editedAt;
//   int v;
//   bool isLiked;
//   bool isSaved;

//   FollowersPostModel({
//     required this.id,
//     required this.userId,
//     required this.editedAt,
//     required this.image,
//     required this.description,
//     required this.likes,
//     required this.hidden,
//     required this.blocked,
//     required this.tags,
//     required this.taggedUsers,
//     required this.CommentCount,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.isLiked,
//     required this.isSaved,
//   });

//   factory FollowersPostModel.fromJson(Map<String, dynamic> json) {
//     return FollowersPostModel(
//       id: json["_id"],
//       userId: UserId.fromJson(json["userId"]),
//       image: json["image"],
//       editedAt: DateTime.parse(json["edited"]),
//       description: json["description"],
//       likes: List<UserId>.from(json["likes"].map((x) => UserId.fromJson(x))),
//       hidden: json["hidden"],
//       blocked: json["blocked"],
//       tags: List<String>.from(json["tags"].map((x) => x)),
//       taggedUsers: List<TaggedUser>.from(
//           json["taggedUsers"].map((x) => TaggedUser.fromJson(x))),
//       createdAt: DateTime.parse(json["createdAt"]),
//       updatedAt: DateTime.parse(json["updatedAt"]),
//       v: json["__v"],
//       isLiked: json["isLiked"],
//       isSaved: json["isSaved"],
//       CommentCount: json["commentCount"],
//     );
//   }

//   // Add this static method to handle a list of JSON objects
//   static List<FollowersPostModel> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((json) => FollowersPostModel.fromJson(json)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "_id": id,
//       "edited": editedAt.toIso8601String(),
//       "userId": userId.toJson(),
//       "image": image,
//       "description": description,
//       "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
//       "hidden": hidden,
//       "blocked": blocked,
//       "tags": List<dynamic>.from(tags.map((x) => x)),
//       "taggedUsers": List<dynamic>.from(taggedUsers.map((x) => x.toJson())),
//       "createdAt": createdAt.toIso8601String(),
//       "updatedAt": updatedAt.toIso8601String(),
//       "__v": v,
//       "isLiked": isLiked,
//       "isSaved": isSaved,
//       "commentCount": CommentCount,
//     };
//   }
// }

// class UserId {
//   String id;
//   String userName;
//   String email;
//   String? password;
//   String profilePic;
//   String phone;
//   bool online;
//   bool blocked;
//   bool verified;
//   DateTime createdAt;
//   DateTime editedAt;
//   DateTime updatedAt;
//   int v;
//   String? bio;
//   bool isPrivate;
//   String? name;
//   String role;
//   String backGroundImage;

//   UserId({
//     required this.id,
//     required this.editedAt,
//     required this.userName,
//     required this.email,
//     this.password,
//     required this.profilePic,
//     required this.phone,
//     required this.online,
//     required this.blocked,
//     required this.verified,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     this.bio,
//     required this.isPrivate,
//     this.name,
//     required this.role,
//     required this.backGroundImage,
//   });

//   factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//         id: json["_id"],
//         userName: json["userName"],
//         email: json["email"],
//         editedAt: DateTime.parse(json["edited"]),
//         password: json["password"],
//         profilePic: json["profilePic"],
//         phone: json["phone"],
//         online: json["online"],
//         blocked: json["blocked"],
//         verified: json["verified"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         bio: json["bio"],
//         isPrivate: json["isPrivate"],
//         name: json["name"],
//         role: json["role"],
//         backGroundImage: json["backGroundImage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userName": userName,
//         "email": email,
//         "password": password,
//         "profilePic": profilePic,
//         "phone": phone,
//         "online": online,
//         "blocked": blocked,
//         "verified": verified,
//         "edited": editedAt.toIso8601String(),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "bio": bio,
//         "isPrivate": isPrivate,
//         "name": name,
//         "role": role,
//         "backGroundImage": backGroundImage,
//       };
// }
// // enum Role {
// //     user
// // }

// // final roleValues = EnumValues({
// //     "User": Role.user
// // });

// class TaggedUser {
//   String id;
//   String userName;

//   TaggedUser({
//     required this.id,
//     required this.userName,
//   });

//   factory TaggedUser.fromJson(Map<String, dynamic> json) => TaggedUser(
//         id: json["_id"],
//         userName: json["userName"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userName": userName,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

class FollowersPostModel {
  String id;
  UserId userId;
  String image;
  String description;
  List<UserId> likes;
  bool hidden;
  bool blocked;
  List<String> tags;
  List<TaggedUser> taggedUsers;
  int commentCount;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime editedAt;
  int v;
  bool isLiked;
  bool isSaved;

  FollowersPostModel({
    required this.id,
    required this.userId,
    required this.editedAt,
    required this.image,
    required this.description,
    required this.likes,
    required this.hidden,
    required this.blocked,
    required this.tags,
    required this.taggedUsers,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLiked,
    required this.isSaved,
  });

  factory FollowersPostModel.fromJson(Map<String, dynamic> json) {
    return FollowersPostModel(
      id: json["_id"] ?? '',
      userId: UserId.fromJson(json["userId"] ?? {}),
      image: json["image"] ?? '',
      description: json["description"] ?? '',
      likes: (json["likes"] != null)
          ? List<UserId>.from(json["likes"].map((x) => UserId.fromJson(x)))
          : [],
      hidden: json["hidden"] ?? false,
      blocked: json["blocked"] ?? false,
      tags: json["tags"] != null
          ? List<String>.from(json["tags"].map((x) => x))
          : [],
      taggedUsers: json["taggedUsers"] != null
          ? List<TaggedUser>.from(
              json["taggedUsers"].map((x) => TaggedUser.fromJson(x)))
          : [],
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(),
      updatedAt: json["updatedAt"] != null
          ? DateTime.parse(json["updatedAt"])
          : DateTime.now(),
      editedAt: json["edited"] != null
          ? DateTime.parse(json["edited"])
          : DateTime.now(),
      v: json["__v"] ?? 0,
      isLiked: json["isLiked"] ?? false,
      isSaved: json["isSaved"] ?? false,
      commentCount: json["commentCount"] ?? 0,
    );
  }
static List<FollowersPostModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FollowersPostModel.fromJson(json)).toList();
  }





  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "edited": editedAt.toIso8601String(),
      "userId": userId.toJson(),
      "image": image,
      "description": description,
      "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
      "hidden": hidden,
      "blocked": blocked,
      "tags": List<dynamic>.from(tags.map((x) => x)),
      "taggedUsers": List<dynamic>.from(taggedUsers.map((x) => x.toJson())),
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "__v": v,
      "isLiked": isLiked,
      "isSaved": isSaved,
      "commentCount": commentCount,
    };
  }
}

class UserId {
  String id;
  String userName;
  String email;
  String? password;
  String profilePic;
  String phone;
  bool online;
  bool blocked;
  bool verified;
  DateTime createdAt;
  DateTime editedAt;
  DateTime updatedAt;
  int v;
  String? bio;
  bool isPrivate;
  String? name;
  String role;
  String backGroundImage;

  UserId({
    required this.id,
    required this.editedAt,
    required this.userName,
    required this.email,
    this.password,
    required this.profilePic,
    required this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.bio,
    required this.isPrivate,
    this.name,
    required this.role,
    required this.backGroundImage,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"] ?? '',
        userName: json["userName"] ?? '',
        email: json["email"] ?? '',
        password: json["password"],
        profilePic: json["profilePic"] ?? '',
        phone: json["phone"] ?? '',
        online: json["online"] ?? false,
        blocked: json["blocked"] ?? false,
        verified: json["verified"] ?? false,
        editedAt: json["edited"] != null
            ? DateTime.parse(json["edited"])
            : DateTime.now(),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        v: json["__v"] ?? 0,
        bio: json["bio"] ?? '',
        isPrivate: json["isPrivate"] ?? false,
        name: json["name"],
        role: json["role"] ?? 'user',
        backGroundImage: json["backGroundImage"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "phone": phone,
        "online": online,
        "blocked": blocked,
        "verified": verified,
        "edited": editedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "isPrivate": isPrivate,
        "name": name,
        "role": role,
        "backGroundImage": backGroundImage,
      };
}

class TaggedUser {
  String id;
  String userName;

  TaggedUser({
    required this.id,
    required this.userName,
  });

  factory TaggedUser.fromJson(Map<String, dynamic> json) => TaggedUser(
        id: json["_id"] ?? '',
        userName: json["userName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
      };
}
