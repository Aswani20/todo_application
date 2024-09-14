class Task {
  static const String collectionName = "tasks";
  String? id;
  String? title;
  String? description;
  DateTime? date;
  bool? isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            description: data['description'],
            date: DateTime.fromMillisecondsSinceEpoch(data['date']),
            isDone: data['isDone']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date!.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
