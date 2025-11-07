class TodoModel {
  String id;
  String title;
  String desc;
  bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.desc,
     this.isDone = false
     });
}
