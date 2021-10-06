
class NotificationMe {
  DateTime dateTime = DateTime.now();
  String uid;
  String factorId;
  String content;

  NotificationMe({
    required this.uid,
    this.factorId = "1212",
    this.content = "This is a demo",
  });

  static AddNotiToFirebase(NotificationMe MyNoti)async {
    /*await FirebaseFirestore.instance.collection('noti').add(MyNoti.toJSon());*/
  }

  Map<String, dynamic> toJSon() => {
        'uid': uid,
        'datetime': dateTime,
        'factorId': factorId,
        'content': content,
      };
}
