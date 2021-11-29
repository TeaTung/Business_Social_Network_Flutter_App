import 'package:flutter/material.dart';

import 'onboarding_model.dart';

class StepsButton extends StatefulWidget {
  StepsButton({
    Key? key,
    required this.page,
    required List<OnBoardingModel> list,
    required PageController controller,
  })
      : _list = list,
        _controller = controller,
        super(key: key);

  int page;
  final List<OnBoardingModel> _list;
  final PageController _controller;
  @override
  State<StepsButton> createState() => _StepsButtonState();
}

class _StepsButtonState extends State<StepsButton> {



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: Stack(
        children: [
          Container(
            width: 75,
            height: 75,
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(
                Color.fromRGBO(248, 145, 71, 1),
              ),
              value: (widget.page + 1) / (widget._list.length + 1),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                if (widget.page < widget._list.length && widget.page != widget._list.length - 1) {
                  setState(() {
                    widget.page = widget.page + 1;
                  });
                  widget._controller.animateToPage(
                    widget.page,
                    duration: const Duration(microseconds: 1000),
                    curve: Curves.easeInCirc,
                  );
                } else {}
              },
              child: Container(
                width: 65,
                height: 65,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(248, 145, 71, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 26,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
