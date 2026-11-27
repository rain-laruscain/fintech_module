import 'package:flutter/material.dart';
import 'package:flutter_pro_table/flutter_pro_table.dart';

class Transaction {
  final String trans_id;
  final String trans_datetime;
  final double trans_price;

  Transaction({
    this.trans_id = '',
    this.trans_datetime  = '',
    this.trans_price = 0.0,
  });
}

class Summary {
  List <Transaction> transactions;
  DateTime? sum_date;
  double? sum_gross_profit;
  double? sum_expenses;
  double? sum_net_profit;

  Summary({
    this.sum_date,
    this.sum_gross_profit,
    this.sum_expenses,
    this.sum_net_profit,
    this.transactions = const [],
  });
}

ProTable<Summary> summary_table = ProTable<Summary>(
  enableSearch: false,
  rowKey: (t) => t.sum_date?.toString() ?? '',
  columns: [
    ProColumn(
      id: 'sum_date',
      title: 'Date',
      value: (t) => t.sum_date?.toString() ?? '',
    ),
    ProColumn(
      id: 'sum_gross_profit',
      title: 'Gross Profit',
      value: (t) => t.sum_gross_profit?.toStringAsFixed(2) ?? '',
    ),
    ProColumn(
      id: 'sum_expenses',
      title: 'Expenses',
      value: (t) => t.sum_expenses?.toStringAsFixed(2) ?? '',
    ),
    ProColumn(
      id: 'sum_net_profit',
      title: 'Net Profit',
      value: (t) => t.sum_net_profit?.toStringAsFixed(2) ?? '',
    ),
  ],
  rows: [
    Summary(sum_date: DateTime(2023, 1, 1), sum_gross_profit: 1000.0,sum_expenses: 500.0, sum_net_profit: 500.0,),
    Summary(sum_date: DateTime(2023, 1, 1), sum_gross_profit: 1000.0,sum_expenses: 500.0, sum_net_profit: 500.0,),
    Summary(sum_date: DateTime(2023, 1, 1), sum_gross_profit: 1000.0,sum_expenses: 500.0, sum_net_profit: 500.0,),
    Summary(sum_date: DateTime(2023, 1, 1), sum_gross_profit: 1000.0,sum_expenses: 500.0, sum_net_profit: 500.0,),
  ],
);

ProTable<Transaction> transactions_table = ProTable<Transaction>(
  enableSearch: false,
  rowKey: (t) => t.trans_id,
  columns: [
    ProColumn(
      id: 'date_time',
      title: 'Date and Time',
      value: (t) => t.trans_datetime,
    ),
    ProColumn(
      id: 'id',
      title: 'ID',
      value: (t) => t.trans_id,
    ),
    ProColumn(
      id: 'total_price',
      title: 'Total Price',
      value: (t) => t.trans_price,
      cellBuilder: (_, t, _) => Text('\$${t.trans_price.toStringAsFixed(2)}'),
    ),
  ],
  rows: [
    Transaction(trans_id: '1', trans_datetime: '2023-01-01 12:00', trans_price: 100.0),
    Transaction(trans_id: '2', trans_datetime: '2023-01-02 13:30', trans_price: 150.5),
    Transaction(trans_id: '3', trans_datetime: '2023-01-03 15:45', trans_price: 200.75),
  ],
);

void main() {
  runApp(const MaterialApp(
    home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

double? windowWidth = 1000;
double? windowHeight = 800;
bool display_transactions = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen'),),
      body: DecoratedBox(
        decoration:BoxDecoration(
          image: DecorationImage(
            image: AssetImage('web/images/fihh.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
              height: windowHeight, width: windowWidth,
              decoration: BoxDecoration(
              color: Colors.white, 
              border: Border.all(width: 2, color: Colors.black)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [  
                //left part
                Container(
                  height: windowHeight! * 0.8, width: windowWidth! * 0.5,
                  decoration: BoxDecoration(
                  color: Colors.white, 
                  ),
                  child: Column(
                    children: [
                      // graph
                      Placeholder(
                        fallbackHeight: windowHeight! * 0.3,
                        fallbackWidth: windowWidth! * 0.2,
                      ),
                      // table and graph options
                      Container(
                        margin: EdgeInsetsGeometry.all(10),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Switch(
                            value: display_transactions,
                            onChanged: (bool value) {
                              setState(() {
                                display_transactions = value;
                              });
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(display_transactions ? 'Transactions Table' : 'Summary Table',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          
                        ])
                      ),
                      SizedBox(
                        height: windowHeight! * 0.4,
                        width: windowWidth! * 0.5,
                        child: display_transactions ? transactions_table : summary_table,
                      ),
                    ],
                  ),
                ),

                //right part
                Container(
                  height: windowHeight! * 0.9, width: windowWidth! * 0.4,
                  decoration: BoxDecoration(
                  color: Colors.white, 
                  border: Border.all(width: 2, color: Colors.black)
                  ),
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [

                  //add shit

                    Text('Yes',
                    style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    ElevatedButton(
                    onPressed:(){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondPage()),
                      );
                    }, child: const Text('Calculate Net Profit')
                    ), 
                  ],
                  )
                )
                ]  
              ),
        ),
        
       ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          }, child: const Text('New Instance'))
      ),
    );
  }
}