class Failure {
  String? message;
  String? code;

  Failure({this.message, this.code});

  Failure.fromJson(Map<String, dynamic> json) {
    message = json['status-message'] ?? "Something went wrong";
    code = json['data'] != null &&
            (json['data'] is Map && json['data']['code'] != null)
        ? json['data']['code']
        : "";
  }
}
