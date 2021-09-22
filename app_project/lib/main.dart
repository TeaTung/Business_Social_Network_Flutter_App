import 'package:app_project/widgets/post_item.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Social Network',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Social Network'),
      ),

      //This code bellow doesn't work correctly
      // body: Container(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: const [
      //       Center(
      //         child: Text('body'),
      //       ),
      //       BottomNavigator(),
      //     ],
      //   ),
      // ),

      //Test post item widget -> OK
      body: const PostItem(),

      //bottomNavigationBar: const BottomNavigator(),
    );
  }
}
