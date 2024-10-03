part of 'explorerpost_bloc.dart';

@immutable
sealed class ExplorerpostState {}

final class ExplorerpostInitial extends ExplorerpostState {}

class ExplorerpostLoadingState extends ExplorerpostState {}

class ExplorerpostSuccesstate extends ExplorerpostState {

  final List<ExplorePostModel>posts;

  ExplorerpostSuccesstate({required this.posts});
}

class ExplorerpostErrorState extends ExplorerpostState {}
