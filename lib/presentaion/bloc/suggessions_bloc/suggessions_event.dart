part of 'suggessions_bloc.dart';

@immutable
sealed class SuggessionsEvent {}
class onSuggessionsIconclickedEvent extends SuggessionsEvent{} 


class RemoveSuggessionUserEvent extends SuggessionsEvent {
  final String userId;

  RemoveSuggessionUserEvent({required this.userId});
}
