class UserApi {
  Future<Map<String, dynamic>> fetchUsers(int page) async {
    // Simulate a delay to mimic network request
    await Future.delayed(const Duration(seconds: 2));

    // Simulate paginated response
    int totalUsers = 50;
    int usersPerPage = 10;
    int numPages = (totalUsers / usersPerPage).ceil();

    if (page > numPages) {
      throw Exception("Page not found");
    }

    List<Map<String, dynamic>> fakeResults = List.generate(
      usersPerPage,
      (index) => {
        'id': (page - 1) * usersPerPage + index + 1,
        'name': 'User ${(page - 1) * usersPerPage + index + 1}'
      },
    );

    Map<String, dynamic> fakeApiResponse = {
      "status-code": 200,
      "status-message": "Success",
      "data": {
        "count": totalUsers,
        "num_pages": numPages,
        "current_page": page,
        "next_page": page < numPages ? page + 1 : null,
        "previous_page": page > 1 ? page - 1 : null,
        "results": fakeResults,
      }
    };

    return fakeApiResponse;
  }
}
