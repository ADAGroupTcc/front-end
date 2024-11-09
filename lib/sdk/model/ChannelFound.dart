class ChannelFound {
  List<UserChannelFound> users;
  List<String> categories;

  ChannelFound({
    required this.users,
    required this.categories,
  });

  factory ChannelFound.fromJson(Map<String, dynamic> json) {
    final usersRaw = json['users'] as List<dynamic>;
    final categoriesRaw = json['categories'] as List<dynamic>;

    List<UserChannelFound> users = [];
    for (var elem in usersRaw) {
      users.add(UserChannelFound.fromJson(elem));
    }

    List<String> categories = [];
    for (var elem in categoriesRaw) {
      categories.add(elem as String);
    }

    return ChannelFound(users: users, categories: categories);
  }
}

class UserChannelFound {
  String id;
  String firstName;
  String lastName;
  String nickname;

  UserChannelFound({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickname,
  });

  factory UserChannelFound.fromJson(Map<String, dynamic> json) {
    return UserChannelFound(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      nickname: json['nickname'] as String,
    );
  }
}
