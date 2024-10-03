// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart';
// import 'package:klik/application/core/widgets/customeAppbar_row.dart';
// import 'package:klik/domain/model/explore_posts_model.dart';
// import 'package:klik/domain/model/saved_post_model.dart';
// import 'package:klik/main.dart';
// import 'package:klik/presentaion/bloc/explorerposts_bloc/explorerpost_bloc.dart';
// import 'package:klik/presentaion/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
// import 'package:multi_bloc_builder/multi_bloc_builder.dart';

// class UserProfileDetails extends StatefulWidget {

// final int initialindex;


//    UserProfileDetails({super.key, required this.initialindex});

//   @override
//   State<UserProfileDetails> createState() => _UserProfileDetailsState();
// }

// class _UserProfileDetailsState extends State<UserProfileDetails> {


// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();


//     context.read<ExplorerpostBloc>().add(FetchExplorerPostsEvent());
//   }
//  List<ExplorePostModel> posts = [];
//   List<SavedPostModel> savedPosts = [];
//   @override
//   Widget build(BuildContext context) {    final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(


// appBar: CustomeAppbarRow(height: height, width: width, title: 'Explore', onBackButtonPressed: () {
  
// },),
// body: MultiBlocBuilder(blocs: [context.watch<ExplorerpostBloc>(),
// context.watch<FetchSavedPostsBloc>()], builder:  (context, state) {
//           var state1 = state[0];
//           var state2 = state[1];
          
          
          
          
          
//           if (state2 is FetchSavedPostsSuccesfulState) {savedPosts=state2.posts;
            
//           }

//           if (state1 is ExplorerpostSuccesstate) {
//             posts=state1.posts;

//             return Column(

//               children: [ListView.builder  (    
                
                
//                 itemCount:  posts.length,
//                 controller: ScrollController(initialScrollOffset: widget.initialindex==0  ?0 :widget.initialindex*450),
//                 itemBuilder: (context, index) {
//                 final post =posts[index];

//                 return 
//               },)],
//             )
            
//           }
//           ),


//     );




    
    
    
    
    
    
    
//     Card(


//     )



//   }
// }