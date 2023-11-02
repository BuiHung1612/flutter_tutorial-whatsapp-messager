String lastSeenMessage(lastSeen) {
  DateTime now = DateTime.now();
  Duration differenceDuration =
      now.difference(DateTime.fromMillisecondsSinceEpoch(lastSeen));

  String finalMessage = differenceDuration.inSeconds > 59
      ? differenceDuration.inMinutes > 59
          ? differenceDuration.inDays > 23
              ? "${differenceDuration.inDays} ${differenceDuration.inDays == 1 ? 'day' : 'days'}"
              : "${differenceDuration.inHours} ${differenceDuration.inHours == 1 ? 'hour' : 'hours'}"
          : "${differenceDuration.inSeconds} ${differenceDuration.inSeconds == 1 ? 'second' : 'seconds'}"
      : "few moments";
  return finalMessage;
}
