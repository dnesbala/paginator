class ErrorFailure {
  String? message;
  String? code;

  ErrorFailure({this.message, this.code});

  ErrorFailure.fromJson(Map<String, dynamic> json) {
    message = json['status-message'] ?? "Something went wrong";
    code = json['data'] != null &&
            (json['data'] is Map && json['data']['code'] != null)
        ? json['data']['code']
        : "";
  }
}
