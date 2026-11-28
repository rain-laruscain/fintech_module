import 'package:flutter/material.dart';
import 'transactions.dart';

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

void addEntry() {
  error = '';
  try {
    price = double.parse(_getText3.text.toString());
  }
  catch(e) {
    error = 'This is not a price tag.';
    return;
  }
  Transaction.create(price);
}

void editEntry() {
  error = '';
  try {
    price = double.parse(_getText3.text.toString());
    id=_getText1.text;
  }
  catch(e) {
    error = 'This is not a price tag.';
    return;
  }
  Transaction.edit(id, price);
  if (!Transaction.trans_complete) {
    error = 'ID not found.';
    }
  else {
    error = 'Updated!';
  }
}

void deleteEntry() {
  id=_getText1.text;
  Transaction.delete(id);
    if (!Transaction.trans_complete) {
    error = 'ID not found.';
    }
  else {
    error = 'Deleted!';
  }
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
String error = '';
String id = '';
double price = 0;
final _getText1 = TextEditingController();
  //final _getText2 = TextEditingController();
final _getText3 = TextEditingController();

class _HomePageState extends State<HomePage> {

  void errorSet() {
  setState(() {
   error = error;
  });
  }

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
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Column(
                    mainAxisAlignment: .spaceEvenly,
                    crossAxisAlignment: .center,
                    children: [

                    Text('Insert Price:', style: TextStyle(color: Colors.black),),
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

                    Text('Insert ID:',style: TextStyle(color: Colors.black),),
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
                    
                    ElevatedButton(
                      onPressed:(){
                        addEntry();
                        errorSet();
                      }, child: const Text('Add Entry - Place Any Price You Wish!')
                    ),

                    ElevatedButton(
                      onPressed:(){
                        editEntry();
                        errorSet();
                      }, child: const Text('Edit Entry - Insert the Correct ID You Wish to Edit,'
                      +' And Charge a New Price After!')
                    ),

                    ElevatedButton(
                      onPressed:(){
                        deleteEntry();
                        errorSet();
                      }, child: const Text('Delete Entry - Insert the Correct ID You Wish to Delete!')
                    ),

                    Text('$error',style: TextStyle(color: Colors.red),),

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
          }, child: const Text('Go Back'))
      ),
    );
  }
}

