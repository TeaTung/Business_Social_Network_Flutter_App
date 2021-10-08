import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/widgets/position_item.dart';

class PositionsSection extends StatefulWidget {
  const PositionsSection({Key? key}) : super(key: key);

  @override
  _PositionsSectionState createState() => _PositionsSectionState();
}

class _PositionsSectionState extends State<PositionsSection> {
  bool isSeeMore = false;
  int loadedItemCount = 2;
  String textButton = 'See more';
  double heightSizedOfSection = 225;

  @override
  Widget build(BuildContext context) {
    Positions positions = Provider.of<Positions>(context);

    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
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
                      loadedItemCount = positions.items.length;
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
        const SizedBox(height: 4),
        AnimatedContainer(
          height: heightSizedOfSection,
          duration: const Duration(milliseconds: 200),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: positions.items[index],
                child: PositionItem(),
              );
            },
            itemCount: loadedItemCount,
          ),
        ),
      ],
    );
  }
}
