class TransactionModel {
  TransactionModel({
    required this.clientTransactions,
  });
  late final List<ClientTransactions> clientTransactions;

  static TransactionModel fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          clientTransactions: List.from(json['clientTransactions'])
              .map((e) => ClientTransactions.fromJson(e))
              .toList());

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['clientTransactions'] =
        clientTransactions.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ClientTransactions {
  ClientTransactions({
    required this.transactionId,
    required this.type,
    required this.amount,
    this.comment,
    required this.entryDate,
    required this.currencyCode,
    required this.balance,
  });
  late final int transactionId;
  late final String? type;
  late final double amount;
  late final String? comment;
  late final String entryDate;
  late final String currencyCode;
  late final String balance;

  ClientTransactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    type = json['type'];
    amount = json['amount'];
    comment = json['comment'];
    entryDate = json['entryDate'];
    currencyCode = json['currencyCode'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['transactionId'] = transactionId;
    _data['type'] = type;
    _data['amount'] = amount;
    _data['comment'] = comment;
    _data['entryDate'] = entryDate;
    _data['currencyCode'] = currencyCode;
    _data['balance'] = balance;
    return _data;
  }
}
