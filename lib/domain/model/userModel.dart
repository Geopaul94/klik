class UserModel {
  final String userName;
  final String password;
  final String phoneNumber;
  final String emailId;

  UserModel(
      {required this.userName,
      required this.password,
      required this.phoneNumber,
      required this.emailId});


// factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         emailId: json['email']  ,
//         userName: json['userName'],
//         phoneNumber: json['phone'],
//         password: json['password'],
//       );

//   Map<String, dynamic> toJson() => {
//         'email': emailId,
//         'userName': userName,
//         'phone': phoneNumber,
//         'password': password,
//       };
}

