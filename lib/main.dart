import 'package:flutter/material.dart';

import 'package:gp_calculator_by_joseph/service_classes/gpa_calculator_UI_service.dart';
import 'package:gp_calculator_by_joseph/pages/pg1_collect_info (HomePage).dart';

void main() {
  runApp(const MainApp());
} // main()


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
} // MainApp


class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme(
          brightness: Brightness.light, 
          primary: /*Colors.purple.shade700*/Colors.green.shade900,//Colors.green.shade500,
          onPrimary: Colors.white,
          secondary:  Colors.red,
          onSecondary:  Colors.orange,
          error:Colors.lightGreen,  
          onError: Colors.lightGreen,
          background:Colors.white,
          onBackground:  Colors.blue.shade900,
          surface: Colors.black,//Colors.lightGreen,
          onSurface: Colors.purple.shade900
          ),//Colors.lightGreen)),

      ),
          
      home:  NeededDataCollectionPage()
    );
  }
}  // MainAppState


class CounterPage extends StatefulWidget {
  CounterPage({super.key});

  int count = 0;

  @override
  State<CounterPage> createState() => _CounterPageState();
} //CounterPage widget class

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
          body: Column(
            children: [
              SizedBox(height: 210,),
              Center(
                            child: Text("Currently at Page ${widget.count}"),
                                   ),
          
              ElevatedButton(
                             onPressed: (){
                                   setState(() {
                                         widget.count >= 1 ? widget.count  -=  1 : null;
                                   });
                             }, 
                             child: Text("Minus")
                             )
            ],
          ),
          floatingActionButton: FloatingActionButton(
                                                         onPressed: (){
                                                              setState( ( ){
                                                                    widget.count += 1;
                                                                     });
                                                                          },
                                                          child: Icon(Icons.add),
                                                         ),
    );
  }
} // Counter Page State Class


// List<DropdownMenuItem<Text>> options = const[
//   DropdownMenuItem(child:Text("UniJos")),
//   DropdownMenuItem(child:Text("University of Nigeria Nsukka(UNN)")),
//   DropdownMenuItem(child:Text("University of Ilorin (UNILORIN)"))
// ];

// class MyTestPage extends StatelessWidget {
//   const MyTestPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool itemSelected = false;
//     dynamic item;

//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 28.0),
//           child: Column(
//             children: [
//               DropdownButton(
//                 items: options,
//                 hint: const Text("Here"),
//                 onChanged: (selection){
//                   item = selection;
//                 },
//                 value: null
//                 ),

//               itemSelected ? Text("${item.toString()}") : const Text("")
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }