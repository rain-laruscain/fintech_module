import 'package:flutter/material.dart';
import 'package:flutter_pro_table/flutter_pro_table.dart';
import 'package:intl/intl.dart';

class Transaction {
  static final DateFormat dateTimeFormat = DateFormat('MM/dd/yyyy - HH:mm:ss');
  static List<Transaction?> global_transactions = [];
  static int global_trans_id = 0;
  String trans_id = "";
  String trans_datetime = "";
  double trans_price = 0.0;

  Transaction({
    this.trans_id = '',
    this.trans_datetime  = '',
    this.trans_price = 0.0,
  });

  Transaction.create(double price){
    trans_id = (global_trans_id++).toString();
    trans_datetime = dateTimeFormat.format(DateTime.now());
    trans_price = price;
    global_transactions?.add(this);
  }
}

class Summary {
  static final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
  static List<Summary?> global_summaries = [];
  List<Transaction>? sum_transactions = [];
  String sum_date = '';
  double sum_gross_profit = 0.0;
  double sum_expenses = 0.0;
  double sum_net_profit = 0.0;

  Summary.create(DateTime date) {
    sum_date = dateFormat.format(date);

    for (Transaction? t in Transaction.global_transactions) {
      // Since both formats start with 'MM/dd/yyyy', startsWith(sum_date) matches directly
      if (t!.trans_datetime.startsWith(sum_date)) {
        addTransaction(t);
      }
    }
    global_summaries.add(this);
  }

  Summary(){
    sum_date = DateTime.now().toString();
  }

  void addTransaction(Transaction transaction) {
    if (transaction != null) {
      sum_transactions?.add(transaction);
      sum_gross_profit += transaction.trans_price;
      sum_net_profit = sum_gross_profit - sum_expenses;
    }
  }

  void setExpense(double expense) {
    sum_expenses = expense;
    sum_net_profit = sum_gross_profit - sum_expenses;
  }
}

ProTable<Summary?> summary_table = ProTable<Summary?>(
  enableSearch: false,
  rowKey: (s) => s!.sum_date,
  columns: [
    ProColumn(
      id: 'sum_date',
      title: 'Date',
      value: (s) => s!.sum_date
    ),
    ProColumn(
      id: 'sum_gross_profit',
      title: 'Gross Profit',
      value: (s) => s!.sum_gross_profit?.toStringAsFixed(2),
    ),
    ProColumn(
      id: 'sum_expenses',
      title: 'Expenses',
      value: (s) => s!.sum_expenses?.toStringAsFixed(2),
    ),
    ProColumn(
      id: 'sum_net_profit',
      title: 'Net Profit',
      value: (s) => s!.sum_net_profit?.toStringAsFixed(2),
    ),
  ],
  rows: Summary.global_summaries
);

ProTable<Transaction?> transaction_table() {
  return ProTable<Transaction?>(
  enableSearch: false,
  rowKey: (t) => t!.trans_id,
  columns: [
    ProColumn(
      id: 'date_time',
      title: 'Date and Time',
      value: (t) => t!.trans_datetime,
    ),
    ProColumn(
      id: 'id',
      title: 'ID',
      value: (t) => t!.trans_id,
    ),
    ProColumn(
      id: 'total_price',
      title: 'Total Price',
      value: (t) => t!.trans_price,
      cellBuilder: (_, t, _) => Text('\$${t!.trans_price.toStringAsFixed(2)}'),
    ),
  ],
  rows: Transaction.global_transactions
  );
}





