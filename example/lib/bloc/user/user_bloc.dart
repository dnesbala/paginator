import 'package:bloc/bloc.dart';
import 'package:example/user_list_model.dart';
import 'package:example/user_repo.dart';
import 'package:meta/meta.dart';
import 'package:paginator/paginator.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserRepo userRepo = UserRepo();
    final pagination = Pagination<User>();

    on<FetchUsersEvent>((event, emit) async {
      final response = await pagination.performPagination(
        getFunction: userRepo.fetchUsers,
        fetchLimit: event.howManyDataToFetch,
        freshStart: event.freshStart,
      );

      switch (response.paginationStatus) {
        case PaginationStatus.success:
          emit(UserFetchSuccess(users: response.list, hasReachedEnd: false));
          break;
        case PaginationStatus.successAndReachedMax:
          emit(UserFetchSuccess(users: response.list, hasReachedEnd: true));
          break;
        case PaginationStatus.failure:
          emit(UserFetchFailure(errorMessage: response.errorMessage));
          break;
        default:
          emit(UserFetchFailure(errorMessage: response.errorMessage));
          break;
      }
    });
  }
}
