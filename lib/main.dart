import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:klik/firebase_options.dart';
import 'package:klik/infrastructure/functions/serUserloggedin.dart';
import 'package:klik/presentaion/bloc/Connectivity/connectivity_bloc.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_bloc.dart';

import 'package:klik/presentaion/bloc/bottomanav_mainpages.dart/cubit/bottomnavigator_cubit.dart';
import 'package:klik/presentaion/bloc/comment_bloc/comment_post/comment_post_bloc.dart';
import 'package:klik/presentaion/bloc/comment_bloc/delete_comment_bloc/delete_comment_bloc.dart';
import 'package:klik/presentaion/bloc/comment_bloc/getAllComment/get_all_comment_bloc.dart';
import 'package:klik/presentaion/bloc/edit_user_profile_bloc/edit_user_profile_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_followers_bloc/fetchfollowers_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:klik/presentaion/bloc/get_followers_post_bloc/getfollowers_post_bloc.dart';
import 'package:klik/presentaion/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:klik/presentaion/bloc/login/forgorpassword_mailclicked/forgotpassword_bloc.dart';
import 'package:klik/presentaion/bloc/login/login_bloc.dart';
import 'package:klik/presentaion/bloc/login/otp_verification/otp_verify_bloc.dart';
import 'package:klik/presentaion/bloc/login/resetpassword/resetpassword_bloc.dart';
import 'package:klik/presentaion/bloc/login_user_details/login_user_details_bloc.dart';
import 'package:klik/presentaion/bloc/save_unsave_bloc/save_unsave_bloc.dart';
import 'package:klik/presentaion/bloc/signup/signup_bloc.dart';
import 'package:klik/presentaion/bloc/signupotp/signup_otp_bloc.dart';
import 'package:klik/presentaion/bloc/suggessions_bloc/suggessions_bloc.dart';
import 'package:klik/presentaion/bloc/testbloc/teastbloc_bloc.dart';
import 'package:klik/presentaion/bloc/unfollow_user_bloc/unfollow_user_bloc.dart';
import 'package:klik/presentaion/pages/homepage/homepage.dart';
import 'package:klik/presentaion/pages/nerworkdata/connectivity_listener.dart';
import 'package:klik/presentaion/pages/splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  currentUser = await getUserId();

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
        BlocProvider(create: (context) => AddPostBloc()),
        BlocProvider(create: (context) => BottomnavigatorCubit()),
        BlocProvider(create: (context) => LoginUserDetailsBloc()),
        BlocProvider(create: (context) => FetchFollowersBloc()),
        BlocProvider(create: (context) => FetchFollowersBloc()),
        BlocProvider(create: (context) => FetchMyPostBloc()),
        BlocProvider(create: (context) => FetchSavedPostsBloc()),
        BlocProvider(create: (context) => ConnectivityBloc()),
        BlocProvider(create: (context) => FetchFollowingBloc()),
        BlocProvider(create: (context) => GetfollowersPostBloc()),
        BlocProvider(create: (context) => EditUserProfileBloc()),
        BlocProvider(create: (context) => SuggessionsBloc()),
        BlocProvider(create: (context) => FollowersPostBloc()),
        BlocProvider(create: (context) => UnfollowUserBloc()),
        BlocProvider(create: (context) => CommentPostBloc()),
        BlocProvider(create: (context) => DeleteCommentBloc()),
        BlocProvider(create: (context) => GetCommentsBloc()),
        BlocProvider(create: (context) => LikeUnlikeBloc()),
        BlocProvider(create: (context) => SaveUnsaveBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Klik',
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: const ConnectivityListener(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
