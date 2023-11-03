class LastMessageModel {
  final String username;
  final String avatarUrl;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  LastMessageModel(
      {required this.username,
      required this.avatarUrl,
      required this.contactId,
      required this.timeSent,
      required this.lastMessage});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'avatarUrl': avatarUrl,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory LastMessageModel.fromMap(Map<String, dynamic> map) {
    return LastMessageModel(
      username: map['username'],
      avatarUrl: map['avatarUrl'],
      contactId: map['contactId'],
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'],
    );
  }
}
