import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:klik/presentaion/bloc/bottomanav_mainpages.dart/cubit/bottomnavigator_cubit.dart';
import 'package:klik/presentaion/bloc/login/forgorpassword_mailclicked/forgotpassword_bloc.dart';

import 'package:klik/presentaion/bloc/login/login_bloc.dart';
import 'package:klik/presentaion/bloc/login/otp_verification/otp_verify_bloc.dart';
import 'package:klik/presentaion/bloc/login/resetpassword/resetpassword_bloc.dart';
import 'package:klik/presentaion/bloc/signup/signup_bloc.dart';
import 'package:klik/presentaion/bloc/signupotp/signup_otp_bloc.dart';
import 'package:klik/presentaion/bloc/userpost/user_post_bloc.dart';

import 'package:klik/presentaion/pages/splashscreen/splashscreen.dart';
import 'package:klik/presentaion/pages/userpost_page/user_post.dart';

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
        BlocProvider(create: (context) => OtpVerifyBloc()),
        BlocProvider(create: (context) => ResetpasswordBloc()),
        BlocProvider(create: (context) => UserPostBloc()),
        BlocProvider(create: (context) => BottomnavigatorCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Klik',
        // theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: UserPost(),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
