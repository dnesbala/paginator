import 'dart:convert';

UserListModel userListModelFromJson(String str) =>
    UserListModel.fromJson(json.decode(str));

String userListModelToJson(UserListModel data) => json.encode(data.toJson());

class UserListModel {
  final int statusCode;
  final String statusMessage;
  final UserListData data;

  UserListModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        statusCode: json["status-code"],
        statusMessage: json["status-message"],
        data: UserListData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status-code": statusCode,
        "status-message": statusMessage,
        "data": data.toJson(),
      };
}

class UserListData {
  final int count;
  final int numPages;
  final int currentPage;
  final int nextPage;
  final int previousPage;
  final List<User> results;

  UserListData({
    required this.count,
    required this.numPages,
    required this.currentPage,
    required this.nextPage,
    required this.previousPage,
    required this.results,
  });

  factory UserListData.fromJson(Map<String, dynamic> json) => UserListData(
        count: json["count"],
        numPages: json["num_pages"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
        results: List<User>.from(json["results"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "num_pages": numPages,
        "current_page": currentPage,
        "next_page": nextPage,
        "previous_page": previousPage,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
