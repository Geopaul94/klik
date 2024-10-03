part of 'explorerpost_bloc.dart';

@immutable
sealed class ExplorerpostEvent {}


class FetchExplorerPostsEvent extends ExplorerpostEvent{}