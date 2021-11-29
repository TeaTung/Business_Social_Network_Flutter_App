import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(errors.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 14),
          child: formErrorText(
            error: errors[index],
          ),
        );
      }),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/Error.svg',
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 10),
        Text(
          error,
        ),
      ],
    );
  }
}
