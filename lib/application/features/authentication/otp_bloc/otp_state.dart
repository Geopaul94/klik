part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}

final class OtpErrorState extends OtpState {
  final String error;

  OtpErrorState({required this.error});
}

final class OtpLoadingState extends OtpState {}

final class OtpSucessState extends OtpState {}
