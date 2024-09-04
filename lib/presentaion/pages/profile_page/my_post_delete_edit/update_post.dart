import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/constants/constants.dart';
import 'package:klik/application/core/widgets/CustomElevatedButton.dart';
import 'package:klik/application/core/widgets/CustomeAppbar.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_bloc.dart';
import 'package:klik/presentaion/bloc/add_post/add_post_state.dart';
import 'package:klik/presentaion/bloc/bottomanav_mainpages.dart/cubit/bottomnavigator_cubit.dart';
import 'package:klik/presentaion/bloc/bottomanav_mainpages.dart/cubit/bottomnavigator_cubit.dart';
import 'package:klik/presentaion/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:klik/presentaion/pages/addpost_page/addphoto.dart';


class UpdatePost extends StatefulWidget {
  const UpdatePost({super.key});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<UpdatePost> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: "New Post",
          titleFontSize:24,
       
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(size.height * 0.005),
                  child: Column(
                    children: [
                      BlocConsumer<AddPostBloc, AddPostState>(
                        listener: (context, state) {
                          if (state is ImagePickedErrorState) {
                            customSnackbar(context, state.error, red);
                          } else if (state is ImageUploadErrorState) {
                            customSnackbar(context, state.error, red);
                          }
                          
                          
                           else if (state is ImageUploadedState) {
                        
                            _noteController.clear();
                        

                           

  
  context.read<BottomnavigatorCubit>().bottomNavigatorButtonClicked(index: 0);



                            context
                                .read<FetchMyPostBloc>()
                                .add(FetchAllMyPostsEvent());

    BlocProvider.of<AddPostBloc>(context)
                                .add(ClearImage());

                                 customSnackbar(
                                context, "Image uploaded successfully!", green);    
                        print("==================+++11") ; }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              if (state is ImagePickedLoadingState)
                                const Center(child: CircularProgressIndicator())
                              else if (state is ImagePickedSuccessState)
                                AddPhotoContainer(
                                  imageFile: state.imageFile,
                                  onRemove: () {
                                    BlocProvider.of<AddPostBloc>(context)
                                        .add(RemoveImage());
                                  },
                                )
                              else
                                const AddPhotoContainer(),
                              SizedBox(height: size.height * 0.02),
                              TextFormField(
                                controller: _noteController,
                                decoration: const InputDecoration(
                                  labelText: 'Add Description....',
                                  labelStyle: TextStyle(color: grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: green),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                maxLines: 3,
                              ),
                              SizedBox(height: size.height * 0.02),
                              BlocBuilder<AddPostBloc, AddPostState>(
                                builder: (context, state) {
                                  if (state is ImageUploadingState) {    FocusScope.of(context).unfocus();
                                    return loadingButton(
                                      media: size,
                                      onPressed: () {},
                                      gradientStartColor: green,
                                      loadingIndicatorColor: purple,
                                      gradientEndColor: blue,
                                    );
                                  }
                                  return CustomElevatedButton(
                                    width: size.width * 1,
                                    height: size.height * 0.065,
                                    onPressed: () async {
                                      if (_noteController.text.trim().length >=
                                              4 &&
                                          state is ImagePickedSuccessState) {
                                        BlocProvider.of<AddPostBloc>(context)
                                            .add(
                                          OnPostButtonClickedEvent(
                                              note: _noteController.text,
                                              imagePath: state.imageFile.path),
                                        );
                                      } else {
                                        customSnackbar(
                                            context,
                                            'Please provide a description with at least 4 characters and an image.',
                                            red);
                                      }
                                    },
                                    text: "Post",
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
