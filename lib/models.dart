class Pill {
  final String name;
  final DateTime time;
  final int frequency;

  Pill({required this.name, required this.time, required this.frequency});

  @override
  String toString() {
    return '$name - ${time.hour}:${time.minute} - Every $frequency hours';
  }
}
