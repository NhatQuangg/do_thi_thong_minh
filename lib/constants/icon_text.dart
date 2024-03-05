import 'package:flutter/material.dart';

class iconAndText extends StatelessWidget {
  String title;
  final IconData icon;
  double? size;

  TextStyle? textStyle;

  iconAndText(
      {Key? key,
        required this.title,
        required this.icon,
        this.textStyle,
        this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: size,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: textStyle,
        ),
      ],
    );
  }
}
