import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/customanimation_explore_page_loading.dart';
import 'package:klik/application/core/widgets/custome_loading_progress.dart';
import 'package:klik/presentaion/bloc/explorerposts_bloc/explorerpost_bloc.dart';
import 'package:klik/presentaion/bloc/search_user_bloc/explore_page_search_users_bloc.dart';
import 'package:klik/presentaion/pages/explorer_page/bb/custometextformfield_explore.dart';
import 'package:klik/presentaion/pages/explorer_page/bb/debouncer.dart';
import 'package:klik/presentaion/pages/explorer_page/bb/gridview_widgets.dart';
import 'package:klik/presentaion/pages/profile_page/widgets/loading_animation_and_error_idget.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 700);
  String onchangevalue = '';

  @override
  void initState() {
    super.initState();
    context.read<ExplorerpostBloc>().add(FetchExplorerPostsEvent());
  }

  Future<void> _onRefresh() async {
    context.read<ExplorerpostBloc>().add(FetchExplorerPostsEvent());
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? kwhiteColor
            : black,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back,
              color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Action to go back
          },
        ),
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: <Color>[Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'Explore',
            style: TextStyle(
              fontSize: 24, // Customize font size as needed
              fontWeight: FontWeight.bold,
              color: Colors.white, // Text color is managed by ShaderMask
            ),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(media.width, 60),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: TextFormFieldExplore(
              controller: searchController,
              hintText: 'Search',
              keyboard: TextInputType.text,
              onTextChanged: (String value) {
                setState(() {
                  onchangevalue = value;
                });
                if (value.isNotEmpty) {
                  _debouncer.run(() {
                    context
                        .read<ExplorePageSearchUsersBloc>()
                        .add(OnSearchAllUsersEvent(query: value));
                  });
                }
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<ExplorerpostBloc, ExplorerpostState>(
          builder: (context, state) {
       
            
 if (state is ExplorerpostLoadingState) {
      return   SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child:  SpinningLinesExample()
        ),
      );
    }



 
    
            
             else if (state is ExplorerpostSuccesstate) {
              if (onchangevalue.isEmpty) {
                return postsGridViewWidget(state, media, context, _onRefresh);
              } else {
                return BlocBuilder<ExplorePageSearchUsersBloc,
                    ExplorePageSearchUsersState>(
                  builder: (context, searchState) {
                    if (searchState is ExplorePageSearchUsersLoadingState) {
                      return const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: CustomeLoadingProgressSearch(),
                        ),
                      );
                    } else if (searchState
                        is ExplorePageSearchUserSuccesState) {
                      return searchState.users.isEmpty
                          ? errorStateWidget('No User Found!', greyMeduim)
                          : filteredUsersListView(
                              searchState,
                              media,
                            );
                    } else {
                      return errorStateWidget('No User Found!', greyMeduim);
                    }
                  },
                );
              }
            } else if (state is ExplorerpostErrorState) {
              return fetchExploreErrorReloadWidget(context);
            } else {
              // unexpected states
              return errorStateWidget(
                  'Something went wrong, Try refreshing.', greyMeduim);
            }
          },
        ),
      ),
    );
  }
}
