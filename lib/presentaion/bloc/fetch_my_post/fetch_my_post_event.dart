
part of 'fetch_my_post_bloc.dart';

@immutable
sealed class FetchMyPostEvent {}

final class FetchAllMyPostsEvent extends FetchMyPostEvent {}

final class OnMyPostDeleteButtonPressedEvent extends FetchMyPostEvent {
  final String postId;

  OnMyPostDeleteButtonPressedEvent({required this.postId});
}

final class OnEditPostButtonClicked extends FetchMyPostEvent {
  final dynamic image;
  final String imageUrl;
  final String description;
  final String postId;

  OnEditPostButtonClicked({
    required this.image,
    required this.description,
    required this.postId,
    required this.imageUrl,
  });
}
