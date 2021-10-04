import 'package:test_fix/providers/notification.dart';
import 'package:test_fix/providers/post.dart';

//
class Hepler {
  static NotificationMe mapToNotif(Map mapJson) {
    NotificationMe me = NotificationMe(uid: 'unknow');
    me.uid = mapJson['uid'];
    me.factorId = mapJson['factorId'];
    me.content = mapJson['content'];
    me.dateTime = mapJson['dateTime'];
    return me;
  }

  // TURN in to json to put in firebase
  static Post mapToPost(Map mapJson) {
    Post p = Post(
      postTime: mapJson['postTime'].toDate(),
      id: mapJson['id'],
      uid: mapJson['uid'],
      userAvtUrl: mapJson['userImageUrl'],
      userName: mapJson['userName'],
      content: mapJson['content'],
      likeCount: mapJson['likeCount'],
      isBusinessPost: mapJson['isBusinessPost'],
      comments:  mapJson['comments'],
    );
    return p;
  }
}
