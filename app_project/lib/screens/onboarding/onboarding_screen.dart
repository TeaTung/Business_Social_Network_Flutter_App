import 'package:flutter/material.dart';
import './skip_button.dart';
import './onboarding_main_content.dart';
import './onboarding_model.dart';
import 'steps_button.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = 'OnBoardingScreen';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnBoardingModel> _list = OnBoardingModel.list;
  int page = 0;
  var _controller = PageController();

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() {
        page = _controller.page!.round();
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SkipButton(),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemBuilder: (context, index) => OnBoardingMainContent(
                  list: _list,
                  index: index,
                ),
                itemCount: _list.length,
              ),
            ),
            StepsButton(
              page: page,
              list: _list,
              controller: _controller,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
