//This class create individual position to load to positions list in account section
import 'package:flutter/material.dart';

class Position with ChangeNotifier {
  String id;
  DateTime startDate;
  String company;
  String jobTitle;
  DateTime endDate;


  Position({
    required this.company,
    required this.id,
    required this.startDate,
    required this.jobTitle,
    required this.endDate,
  });
}
