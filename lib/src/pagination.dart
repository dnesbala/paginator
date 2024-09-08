import 'package:dartz/dartz.dart';
import 'package:paginator/paginator.dart';

class Pagination<T> {
  int page = 1;
  List<T> list = [];
  bool hasReachedMax = false;

  static const kDefaultErrorMessage = "Something went wrong";

  Future<PaginationResponse<T>> performPagination({
    required Future<Either<Failure, PaginationModel<T>>> Function({
      int? dataLimit,
      int? page,
    }) getFunction,
    required int fetchLimit,
    bool freshStart = false,
  }) async {
    if (freshStart) {
      page = 1;
      list = [];
      hasReachedMax = false;
    }
    if (hasReachedMax) return PaginationResponse.reachedMax(list);
    final Either<Failure, PaginationModel<T>> response = await getFunction(
      dataLimit: fetchLimit,
      page: page,
    );
    return response.fold(
      (l) => PaginationResponse<T>(
        paginationStatus: PaginationStatus.failure,
        list: list,
        errorMessage: l.message ?? kDefaultErrorMessage,
      ),
      (r) {
        list = [...list, ...?r.data?.results];
        if (r.data?.nextPage == null) {
          hasReachedMax = true;
          return PaginationResponse<T>(
            paginationStatus: PaginationStatus.successAndReachedMax,
            list: list,
          );
        } else {
          page++;
          return PaginationResponse<T>(
            paginationStatus: PaginationStatus.success,
            list: list,
          );
        }
      },
    );
  }
}
