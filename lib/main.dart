import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen'),
      ),
      body: DecoratedBox(
        decoration:BoxDecoration(
          /*
          image: DecorationImage(
            image: AssetImage('web/images/fihh.jpg'),
            fit: BoxFit.fill,
          ),
          */
        ),
        child: Center(
          child: Container(
              height: 500,
              width: 800,
              decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 5, color: Colors.black)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                //left part
                Container(
                  margin: EdgeInsetsGeometry.directional(start: 8),
                  height: 475,
                  width: 410,
                  decoration: BoxDecoration(
                  color: Colors.white, 
                  ),
                child: Column(
                  children: [
                    Text('Hello')
                  ],
                ),
                ),

                //right part
                Container(
                  margin: EdgeInsetsGeometry.directional(end: 8),
                  height: 475,
                  width: 350,
                  decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 5, color: Colors.black)
                  ),
                  child: Column(
                  mainAxisAlignment: .center,
                  children: [

                  //add shit

                    Text(
                    'Yes',
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