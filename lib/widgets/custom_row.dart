import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  CustomRow(this.isAmount, this.text1, this.text2, {Key? key})
      : super(key: key);

  bool isAmount;
  String text1;
  String text2;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style:
              TextStyle(color: theme.accentColor, fontWeight: FontWeight.w400),
        ),
        Text(
          "${isAmount ? "₦" : ""}$text2",
          style: TextStyle(fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
