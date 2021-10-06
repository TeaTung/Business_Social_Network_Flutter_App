//This class create individual position to load to positions list in account section
import 'package:flutter/material.dart';

class Position with ChangeNotifier {
  String id;
  String uid;
  DateTime startDate;
  String company;
  String jobTitle;

  DateTime? endDate;
  String? jobDescription;
  String? companyUid;
  String? companyAvt;
  String? companyUrl;

  Position({
    required this.company,
    required this.id,
    required this.uid,
    required this.startDate,
    required this.jobTitle,
    this.jobDescription,
    this.companyUrl,
    this.companyAvt,
    this.companyUid,
    this.endDate,
  });
}
