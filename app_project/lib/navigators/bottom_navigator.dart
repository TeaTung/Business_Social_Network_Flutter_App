import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: 80,
            color: Colors.black,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(
                    size.width,
                    80,
                  ),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.5,
                  child: SizedBox(
                    height: 65.0,
                    width: 65.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.indigo,
                        child: const Icon(Icons.add),
                        elevation: 0.1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.announcement_rounded),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 50),
                      IconButton(
                        icon: const Icon(Icons.notifications_sharp),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.account_circle_rounded),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 15);
    path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.40, 20);
    path.arcToPoint(
      Offset(size.width * 0.6, 20),
      radius: const Radius.circular(10.0),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 15);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(
      path,
      Colors.black,
      5,
      true,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
