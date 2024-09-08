import 'package:paginator/src/enums/pagination_status.dart';

class PaginationResponse<T> {
  final List<T> list;
  final PaginationStatus paginationStatus;
  final String errorMessage;

  PaginationResponse({
    required this.list,
    required this.paginationStatus,
    this.errorMessage = "",
  });

  factory PaginationResponse.reachedMax(List<T> list) => PaginationResponse(
        paginationStatus: PaginationStatus.successAndReachedMax,
        list: list,
        errorMessage: "",
      );
}
