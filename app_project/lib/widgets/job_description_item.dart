import 'package:flutter/material.dart';
import 'package:test_fix/widgets/title_in_process_detail.dart';

import '../providers/process.dart';
import '../widgets/list_title_process_detail_item.dart';
import '../widgets/list_detail_process_detail.dart';
import 'job_description_in_process_detail_item.dart';

class JobDescriptionItem extends StatelessWidget {
  final ProcessProvider process;

  const JobDescriptionItem({
    Key? key,
    required this.process,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleInProcessDetail(
              title: "About Job",
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 11),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const ListTitleProcessDetailItem(),
                const SizedBox(width: 13),
                ListDetailProcessDetailItem(process: process),
              ],
            ),
            JobDescriptionInProcessDetailItem(
                jobDescription: process.jobDescription),
          ],
        ),
      ),
    );
  }
}
