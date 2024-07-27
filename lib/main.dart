import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:klik/application/features/authentication/loginbloc/login_bloc.dart';
import 'package:klik/application/features/authentication/signup_bloc/signup_bloc.dart';
import 'package:klik/application/pages/login/login_page.dart';
import 'package:klik/application/pages/signup_page/signup_page.dart';

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



//how to add to the git 


// git remote add origin https://github.com/Geopaul94/klik.git
// git branch -M main
// git push -u origin main


