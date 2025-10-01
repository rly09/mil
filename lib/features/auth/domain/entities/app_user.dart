class AppUser {
  final String uid;
  final String email;
  final String name;
  final String profilePhoto;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    this.profilePhoto = 'https://i.pravatar.cc/150',
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'profilePhoto': profilePhoto,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      email: jsonUser['email'],
      name: jsonUser['name'],
      profilePhoto: jsonUser['profilePhoto'] ?? 'https://i.pravatar.cc/150',
    );
  }
}
