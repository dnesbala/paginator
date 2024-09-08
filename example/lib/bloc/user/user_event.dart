part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class FetchUsersEvent extends UserEvent {
  final int page;
  final int howManyDataToFetch;
  final bool freshStart;

  FetchUsersEvent({
    required this.page,
    this.howManyDataToFetch = 10,
    this.freshStart = false,
  });
}
