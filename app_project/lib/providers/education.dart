import 'package:flutter/material.dart';

class Education with ChangeNotifier {
  String id;
  String title;
  DateTime issueYear;
  String organization;

  Education({
    required this.id,
    required this.title,
    required this.issueYear,
    required this.organization,
  });
}
