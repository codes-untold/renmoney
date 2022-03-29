import 'package:flutter/material.dart';
import 'package:renmoney/models/transaction_model.dart';
import 'package:renmoney/network/api_routes.dart';
import 'package:renmoney/network/api_service.dart';
import 'package:renmoney/pages/transaction_detail.dart';
import 'package:renmoney/utilities/services.dart';
import 'package:renmoney/widgets/custom_transaction_card.dart';
import 'package:spring/spring.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool isScreenLoading = false;
  List<ClientTransactions> clientTransactions = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        isScreenLoading = true;
      });
      fetchTransactionList().then((value) {
        setState(() {
          isScreenLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: isScreenLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: theme.primaryColor,
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: theme.primaryColorDark,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "All Transactions",
                      style: TextStyle(
                          color: theme.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Spring.slide(
                              slideType: SlideType.slide_in_left,
                              animDuration:
                                  Duration(milliseconds: 1000 + (index * 250)),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TransactionDetail(
                                                    clientTransactions[index]
                                                        .amount
                                                        .toString(),
                                                    clientTransactions[index]
                                                        .entryDate,
                                                    clientTransactions[index]
                                                        .transactionId
                                                        .toString())));
                                  },
                                  child: CustomTransactionCard(
                                      clientTransactions[index]
                                          .amount
                                          .toString(),
                                      clientTransactions[index].comment ?? "",
                                      clientTransactions[index].entryDate)),
                            ),
                          );
                        },
                        itemCount: clientTransactions.length,
                      ),
                    )
                  ],
                ),
        )));
  }

  Future<void> fetchTransactionList() async {
    var resCategories = await ApiService.get<TransactionModel>(
        ApiRoutes.baseUrl,
        converter: TransactionModel.fromJson);

    if (resCategories.message!.toLowerCase() == "successful") {
      for (int i = 0; i < resCategories.data!.clientTransactions.length; i++) {
        clientTransactions.add(resCategories.data!.clientTransactions[i]);
      }
    } else {
      TransactionService().showTopToast("error fetching data");
    }
  }
}
