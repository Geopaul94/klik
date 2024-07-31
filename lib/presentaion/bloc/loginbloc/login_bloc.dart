import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      // Simulate a login process with a REST API
      final response = await http.post(
        Uri.parse('https://example.com/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': event.username,
          'password': event.password,
        }),
      );

      if (response.statusCode == 200) {
        // Assuming the API returns a success status
        yield LoginSuccess();
      } else {
        // Assuming the API returns an error message in the response body
        final error = jsonDecode(response.body)['error'];
        yield LoginFailure(error: error);
      }
    }
  }
}
