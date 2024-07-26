import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:klik/application/features/authentication/loginbloc/login_bloc.dart';
import 'package:klik/application/pages/signup_page/signup_page.dart';

void main() {
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
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: SignupPage(),
      ),
      themeMode: ThemeMode.system,
    );
  }
}
