class AuthenticationModel {
  final String Email;
  final String? userName;
  final int? phoneNumber;
  final password;

  AuthenticationModel({
    required this.Email,
    this.userName,
    this.phoneNumber,
 required   this.password,
  });
}
