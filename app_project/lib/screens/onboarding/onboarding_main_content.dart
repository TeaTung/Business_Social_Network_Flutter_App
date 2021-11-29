import 'package:flutter/material.dart';
import './onboarding_model.dart';
import 'animation.dart';

class OnBoardingMainContent extends StatelessWidget {
  const OnBoardingMainContent({
    Key? key,
    required List<OnBoardingModel> list,
    required this.index,
  })  : _list = list,
        super(key: key);

  final List<OnBoardingModel> _list;
  final index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          FadeAnimation(
            0.9,
            Image.asset(
              _list[index].image,
              height: 320,
              width: 320,
            ),
          ),
          const SizedBox(height: 35),
          FadeAnimation(
            0.5,
            Text(
              _list[index].title,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 12),
          FadeAnimation(
            0.5,
            Text(
              _list[index].text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w300,
                height: 1.3,
                fontSize: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
