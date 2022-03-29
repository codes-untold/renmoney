import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTransactionCard extends StatelessWidget {
  CustomTransactionCard(this.amount, this.comment, this.date, {Key? key})
      : super(key: key);

  String comment;
  String date;
  String amount;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 13),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.primaryColorLight,
              radius: 20,
              child: Icon(
                Icons.arrow_upward,
                color: theme.primaryColor,
                size: 16,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: theme.primaryColorDark,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${DateTime.parse(date).day}"
                    " ${DateFormat.yMMM().format(DateTime.parse(date))}",
                    style: TextStyle(
                        color: theme.accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                  color: amount.contains("-")
                      ? Color(0xffe47673)
                      : Color(0xff65c4Ad)),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
