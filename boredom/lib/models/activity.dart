class Activity {
  final String activity;

  Activity({required this.activity});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      activity: json['activity'],
    );
  }
}
