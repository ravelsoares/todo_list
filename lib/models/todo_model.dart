class Todo {
  String? title;
  String? description;
  bool isCheck;

  Todo(
      {this.title, this.description, this.isCheck = false});

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        isCheck = json['isCheck'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCheck' : isCheck,
    };
  }

}
