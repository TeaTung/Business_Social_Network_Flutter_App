import 'package:flutter/cupertino.dart';
import 'package:test_fix/providers/user.dart';

class MyUser with ChangeNotifier {
  static User me = User(id: "sieunhandienquang", userName: "Tran Duc Tam");
}
