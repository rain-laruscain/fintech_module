import 'package:flutter/material.dart';
import 'transactions.dart';
import 'package:flutter_pro_table/flutter_pro_table.dart';

void addEntry() {
  error = '';
  try {
    num = double.parse(_getText3.text.toString());
    
  }
  catch(e) {
    numCheck = true;
    error = 'Invalid Entry';
  }

  String newId = _getText1.text.trim();
  if (!numCheck) {
      transactions_list.add(Transaction(trans_id: newId, trans_datetime: '2023-01-04 18:00', trans_price: num));
  }
  numCheck = false;
}

void deleteEntry() {
  transactions_list.removeWhere((item) => item.trans_id == _getText1.text);
}

void main() {
  runApp(
    MaterialApp(
    routes: {
      '/': (context) => const HomePage(),
      '/details': (context) => const SecondPage(),
    }
    )
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// all static goes here

double? windowWidth = 1000;
double? windowHeight = 800;
bool display_transactions = false;
bool numCheck = false;
double num = 0;
String error = '';
final _getText1 = TextEditingController();
  //final _getText2 = TextEditingController();
final _getText3 = TextEditingController();

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
                        child: display_transactions ? transaction_table() : summary_table,
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
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .center,
                    children: [
                    Text('Fill up the ID',style: TextStyle(color: Colors.black),),
                    SizedBox(
                      width: 90,
                      height: 60,
                      child: TextField(
                      controller: _getText1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 4
                    )),
                    Text('Fill up the Price', style: TextStyle(color: Colors.black),),
                    SizedBox(
                      width: 120,
                      height: 60,
                      child: TextField(
                      controller: _getText3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 8
                    )),
                    Text('$error',style: TextStyle(color: Colors.red),),
                    ElevatedButton(
                      onPressed:(){
                        addEntry();
                        setState(() {
                          error = error;
                        });
                      }, child: const Text('Add Entry')
                    ),

                    ElevatedButton(
                      onPressed:(){
                        deleteEntry();
                        setState(() {
                          error = 'deleted';
                        });
                      }, child: const Text('Delete Entry')
                    ),

                    ElevatedButton(
                      onPressed:(){
                        Navigator.pushNamed(
                          context, '/details'
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

