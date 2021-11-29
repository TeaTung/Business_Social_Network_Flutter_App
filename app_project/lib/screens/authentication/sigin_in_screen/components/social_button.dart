import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.icon, required this.press})
      : super(key: key);

  final String icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(
          8,
        ),
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}