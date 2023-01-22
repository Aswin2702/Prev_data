import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pond_12/Graph.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  Query dbRef = FirebaseDatabase.instance.ref().child('quality/2-push');
  List<double> ph = [];
  List<double> tds = [];
  List<double> oxy = [];
  List<double> temp = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prev Data"),),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            Map data = snapshot.value as Map;
            data['key'] = snapshot.key;
            tds.add(data['TDS'].toDouble());
            // oxy.add(data['Oxygen level'].toDouble());
            ph.add(data['pH'].toDouble());
            // temp.add(data['Temperature'].toDouble());
            return Container();
          }
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 400,),
          MaterialButton(
            padding: EdgeInsets.all(18),
            minWidth: 120,
            color: Colors.blue,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>Graph(data: ph,name: "PH")));
            },child: const Text("PH",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 10,),
          MaterialButton(
            color: Colors.blue,
            minWidth: 120,
            padding: EdgeInsets.all(18),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>Graph(data: tds,name: "TDS")));
            },child: const Text("TDS",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 10,),
          MaterialButton(
            color: Colors.blue,
            padding: EdgeInsets.all(18),
            minWidth: 120,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>Graph(data: oxy,name: "Oxygen Level")));
            },child: const Text("Oxygen Level",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 10,),
          MaterialButton(
            color: Colors.blue,
            padding: EdgeInsets.all(18),
            minWidth: 120,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>Graph(data: temp,name: "Temperature")));
            },child: const Text("Temperature",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
