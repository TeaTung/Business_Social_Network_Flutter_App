import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_fix/providers/position.dart';
import 'package:test_fix/providers/positions.dart';
import 'package:test_fix/widgets/position_item.dart';

class PositionsSection extends StatefulWidget {
  final String id;
  const PositionsSection({Key? key, required this.id}) : super(key: key);

  @override
  _PositionsSectionState createState() => _PositionsSectionState();
}

class _PositionsSectionState extends State<PositionsSection> {
  @override
  Widget build(BuildContext context) {
    final positions = Provider.of<Positions>(context, listen: false).getListPosition(widget.id);
    return FutureBuilder(
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          List<Position> listPosition = snapshot.data as List<Position>;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 13,
                  horizontal: 13,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About my carrier',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        EvaIcons.chevronRight,
                        color: Color.fromRGBO(248, 145, 71, 1),
                        size: 30,
                      ),
                      onPressed: () {},
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return PositionItem(
                      position: listPosition[index],
                    );
                  },
                  itemCount: listPosition.length,
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text("Error"));
        }
      },
      future: positions,
    );
  }
}
