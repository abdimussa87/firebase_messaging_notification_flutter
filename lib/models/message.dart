class Message{
  String title;
  String body;
  String message;
  Message(this.title,this.body,this.message);
  @override
  String toString() {
    // TODO: implement toString
    return "title: $title , body :$body , message: $message";
  }
}