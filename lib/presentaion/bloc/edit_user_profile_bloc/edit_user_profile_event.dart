part of 'edit_user_profile_bloc.dart';

@immutable


sealed class EditUserProfileEvent {}


final class OnEditProfileButtonClickedEvent extends EditUserProfileEvent {

  final EditDetailsModel editDetailsModel;


  OnEditProfileButtonClickedEvent({required this.editDetailsModel});

}