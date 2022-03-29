import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionService {
  void showTopToast(String? msg,
      {Color? bgColor,
      Color? textColor,
      double? textSize,
      Toast? toastLength,
      ToastGravity? toastGravity}) {
    Fluttertoast.showToast(
        msg: msg!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff7765c4),
        textColor: Colors.white,
        fontSize: textSize ?? 16.0);
  }
}
