import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/presentaion/bloc/bloc/signup_bloc.dart';

import 'package:klik/presentaion/bloc/loginbloc/login_bloc.dart';

import 'package:klik/presentaion/pages/login/entermailid.dart';
import 'package:klik/presentaion/pages/login/login_page.dart';
import 'package:klik/presentaion/pages/login/reset_password_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Klik',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignupBloc(),
          ),
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
        ],
        child: LoginPage(),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
