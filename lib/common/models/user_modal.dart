class UserModel {
  final String username;
  final String uid;
  final String avatarUrl;
  final bool active;
  final String phoneNumber;
  final List<String> groupId;
  final int lastSeen;

  UserModel(
      {required this.username,
      required this.uid,
      required this.avatarUrl,
      required this.active,
      required this.phoneNumber,
      required this.groupId,
      required this.lastSeen});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid': uid,
      'avatarUrl': avatarUrl,
      'active': active,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
      'lastSeen': lastSeen
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        username: map['username'] ?? '',
        uid: map['uid'] ?? '',
        avatarUrl: map['avatarUrl'] ?? '',
        active: map['active'] ?? false,
        phoneNumber: map['phoneNumber'] ?? '',
        groupId: List<String>.from(map['groupId']),
        lastSeen: map['lastSeen'] ?? 0);
  }
}
