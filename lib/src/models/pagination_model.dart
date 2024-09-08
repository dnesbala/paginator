class PaginationModel<T> {
  final int? statusCode;
  final String? statusMessage;
  final PaginatedData<T>? data;
  final T Function(Map<String, dynamic>) fromJson;

  PaginationModel({
    this.statusCode,
    this.statusMessage,
    this.data,
    required this.fromJson,
  });

  PaginationModel<T> copyWith({
    int? statusCode,
    String? statusMessage,
    PaginatedData<T>? data,
    final T Function(Map<String, dynamic>)? fromJson,
  }) =>
      PaginationModel<T>(
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
        data: data ?? this.data,
        fromJson: fromJson ?? this.fromJson,
      );

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    dynamic fromJsonT,
  ) =>
      PaginationModel<T>(
        statusCode: json["status-code"],
        statusMessage: json["status-message"],
        data: json["data"] == null
            ? null
            : PaginatedData<T>.fromJson(json["data"], fromJsonT),
        fromJson: fromJsonT,
      );
}

class PaginatedData<T> {
  final int? count;
  final int? numPages;
  final int? currentPage;
  final int? nextPage;
  final dynamic previousPage;
  final List<T>? results;
  final dynamic fromJson;

  PaginatedData({
    this.count,
    this.numPages,
    this.currentPage,
    this.nextPage,
    this.previousPage,
    this.results,
    required this.fromJson,
  });

  PaginatedData<T> copyWith({
    int? count,
    int? numPages,
    int? currentPage,
    dynamic nextPage,
    dynamic previousPage,
    List<T>? results,
    final dynamic fromJson,
  }) =>
      PaginatedData<T>(
        count: count ?? this.count,
        numPages: numPages ?? this.numPages,
        currentPage: currentPage ?? this.currentPage,
        nextPage: nextPage ?? this.nextPage,
        previousPage: previousPage ?? this.previousPage,
        results: results ?? this.results,
        fromJson: fromJson ?? this.fromJson,
      );

  factory PaginatedData.fromJson(Map<String, dynamic> json, dynamic fromJson) =>
      PaginatedData<T>(
        count: json["count"],
        numPages: json["num_pages"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
        results: json["results"] == null
            ? []
            : List<T>.from(json["results"]!.map((x) => fromJson(x))),
        fromJson: fromJson,
      );
}
