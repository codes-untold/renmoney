import 'package:flutter/material.dart';
import 'package:renmoney/pages/transaction_detail.dart';
import 'package:renmoney/pages/transaction_list.dart';
import 'package:renmoney/themes.dart';

void main() {
  runApp(MaterialApp(
    home: const TransactionList(),
    themeMode: ThemeMode.light,
    theme: AppThemes.lightTheme,
  ));
}
