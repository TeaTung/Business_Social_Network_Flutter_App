class User {
  final String uid;
  String userName;
  String avatarUrl;

  String get getAvatarUrl {
    return avatarUrl;
  }

  User(
      {required this.uid,
      required this.userName,
      this.avatarUrl =
          'https://i1.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1'});
}
