class TaskModel {
  static String collection = "tasks";
  String? id;
  String? title;
  String? description;
  int? priority;
  DateTime? date;
  bool? isDone;
  TaskModel({
    this.date,
    this.description,
    this.id,
    this.isDone,
    this.priority,
    this.title,
  });
  TaskModel.fromJson(Map<String, dynamic> json)
    : this(
        date: json['date'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['date'])
            : null,
        description: json['description'],
        id: json['id'],
        isDone: json['isdone'],
        priority: json['priority'],
        title: json['title'],
      );
  Map<String, dynamic> tojson() {
    final normalizedDate = DateTime(date!.year, date!.month, date!.day);
    return {
      'title': title,
      'priority': priority,
      'isDone': false,
      'id': id,
      'description': description,
      'date': normalizedDate.millisecondsSinceEpoch,
    };
  }
}
