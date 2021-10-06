import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/educations.dart';
import 'package:test_fix/widgets/education_item.dart';

class EducationsSection extends StatefulWidget {
  const EducationsSection({Key? key}) : super(key: key);

  @override
  _EducationsSectionState createState() => _EducationsSectionState();
}

class _EducationsSectionState extends State<EducationsSection> {
  bool isSeeMore = false;
  int loadedItemCount = 2;
  String textButton = 'See more';
  double heightSizedOfSection = 230;

  @override
  Widget build(BuildContext context) {
    Educations educations = Provider.of<Educations>(context);

    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Position & Experience',
                style: Theme.of(context).textTheme.headline1!,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (loadedItemCount == 2) {
                      loadedItemCount = educations.items.length;
                      textButton = 'See less';
                      heightSizedOfSection = 440;
                    } else {
                      loadedItemCount = 2;
                      textButton = 'See more';
                      heightSizedOfSection = 230;
                    }
                  });
                },
                child: Text(
                  textButton,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        AnimatedContainer(
          height: heightSizedOfSection,
          duration: const Duration(milliseconds: 200),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: educations.items[index],
                child: EducationItem(),
              );
            },
            itemCount: loadedItemCount,
          ),
        ),
      ],
    );
  }
}
