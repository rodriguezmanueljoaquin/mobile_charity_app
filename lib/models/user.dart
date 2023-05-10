class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String? avatarURL;
  final String id;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarURL,
    required this.id,
  });

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, lastName: $lastName, email: $email, avatarURL: $avatarURL, id: $id)';
  }
}
