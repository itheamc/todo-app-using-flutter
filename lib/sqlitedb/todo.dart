class Todo {
  int id;
  String title;
  String desc;
  bool completed;
  int time;

  // Constructor with named parameter
  // provide time in DateTime.now().millisecondsSinceEpoch
  Todo(
      {this.id = 0,
      required this.title,
      required this.desc,
      this.completed = false,
      required this.time});

  // Function to Convert this object to map
  Map<String, dynamic> toMap() {
    int cmp;
    if (completed) {
      cmp = 1;
    } else {
      cmp = 0;
    }
    return {'_title': title, '_desc': desc, '_completed': cmp, '_time': time};
  }

  // Function to copy
  Todo copy(
      {int? id, String? title, String? desc, bool? completed, int? time}) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        completed: completed ?? this.completed,
        time: time ?? this.time);
  }

  // _todo from map
  static Todo fromMap(Map<String, dynamic> map) {
    int n = map["_completed"] as int;
    bool completed;
    if (n == 0) {
      completed = false;
    } else {
      completed = true;
    }
    return Todo(
      id: map["_id"],
      title: map["_title"],
      desc: map["_desc"],
      completed: completed,
      time: map["_time"],
    );
  }

  // _todos from maps
  static List<Todo> fromMaps(List<Map<String, dynamic>> maps) {
    return maps.map((e) => fromMap(e)).toList();
  }

  // Overriding toString method
  @override
  String toString() {
    return 'Todo(id: $id, title: $title, desc: $desc, completed: $completed, date: ${DateTime.fromMillisecondsSinceEpoch(time)})';
  }
}
