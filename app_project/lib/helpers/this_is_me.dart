import 'package:flutter/cupertino.dart';
import 'package:test_fix/providers/user_info.dart';

class MyUser with ChangeNotifier {
  static UserInfoLocal me = UserInfoLocal(uid: "sieunhandienquang", userName: "Tran Duc Tam");
}
