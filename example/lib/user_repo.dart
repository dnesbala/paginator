import 'package:dartz/dartz.dart';
import 'package:example/user_api.dart';
import 'package:example/user_list_model.dart';
import 'package:paginator/paginator.dart';

class UserRepo {
  final UserApi userApi = UserApi();

  Future<Either<Failure, PaginationModel<User>>> fetchUsers(
      {int? dataLimit, int? page}) async {
    try {
      final response = await userApi.fetchUsers(page ?? 1);
      return Right(
        PaginationModel<User>.fromJson(
          response,
          User.fromJson,
        ),
      );
    } catch (err) {
      return Left(Failure(message: err.toString()));
    }
  }
}
