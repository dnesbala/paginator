part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserFetchSuccess extends UserState {
  final List<User> users;
  final bool hasReachedEnd;

  UserFetchSuccess({
    required this.users,
    required this.hasReachedEnd,
  });
}

final class UserFetchFailure extends UserState {
  final String errorMessage;

  UserFetchFailure({required this.errorMessage});
}
