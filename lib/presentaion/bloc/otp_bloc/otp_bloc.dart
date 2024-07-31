import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpVerifyButtonClickedEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpVerifyButtonClickedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
