import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:klik/presentaion/bloc/bottomanav_mainpages.dart/cubit/bottomnavigator_cubit.dart';
import 'package:klik/presentaion/bloc/login/forgorpassword/forgotpassword_bloc.dart';

import 'package:klik/presentaion/bloc/login/login_bloc.dart';
import 'package:klik/presentaion/bloc/signup/signup_bloc.dart';
import 'package:klik/presentaion/bloc/signupotp/signup_otp_bloc.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';
import 'package:klik/presentaion/pages/splashscreen/splashscreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => SignupOtpBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => ForgotpasswordBloc()),
        BlocProvider(create: (context) => BottomnavigatorCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Klik',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: SplashScreen(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
