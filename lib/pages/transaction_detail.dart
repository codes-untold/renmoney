import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:renmoney/widgets/custom_row.dart';

class TransactionDetail extends StatelessWidget {
  TransactionDetail(this.amount, this.date, this.reference, {Key? key})
      : super(key: key);

  String amount;
  String reference;
  String date;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "All Transactions",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: theme.backgroundColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Detailed summary of transaction",
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomRow(false, "Recipient", " "),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomRow(true, "Amount", amount),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomRow(
                            false,
                            "Transaction date",
                            "${DateTime.parse(date).day}"
                                " ${DateFormat.yMMM().format(DateTime.parse(date))}",
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomRow(false, "Reference", reference),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status",
                                style: TextStyle(
                                    color: theme.accentColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              const Text(
                                "Successful",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff65c4ad)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
