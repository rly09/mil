import 'package:mil/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profileImageUrl,
  });

  ProfileUser copyWith({
    String? bio,
    String? profileImageUrl,
  }) {
    return ProfileUser(
      uid: uid,
      email: email,
      name: name,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? 'https://i.pravatar.cc/150',
    );
  }
}
