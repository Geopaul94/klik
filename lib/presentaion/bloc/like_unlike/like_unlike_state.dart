part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeState {}

final class LikeUnlikeInitial extends LikeUnlikeState {}


class LikePostLoadingState extends LikeUnlikeState{}
class LikePostSuccessfullState extends LikeUnlikeState{}
class LikePostErrorState extends LikeUnlikeState{}


class UnlikePostLoadingState extends LikeUnlikeState{}
class UnlikePostSuccessfullState extends LikeUnlikeState{}
class UnlikePostErrorState extends LikeUnlikeState{}
