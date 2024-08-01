import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_otp_event.dart';
part 'signup_otp_state.dart';

class SignupOtpBloc extends Bloc<SignupOtpEvent, SignupOtpState> {
  SignupOtpBloc() : super(SignupOtpInitial()) {
    on<SignupOtpEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
