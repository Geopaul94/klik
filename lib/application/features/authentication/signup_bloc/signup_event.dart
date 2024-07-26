import 'package:equatable/equatable.dart';

// Assuming SignUpEvent is already defined and extends Equatable
abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnSignupButtonClickedEvent extends SignUpEvent {
  final String userName;
  final String password;
  final String phoneNumber;
  final String email;

  OnSignupButtonClickedEvent({
    required this.userName,
    required this.password,
    required this.phoneNumber,
    required this.email,
  });

  @override
  List<Object> get props => [userName, password, phoneNumber, email];
}
