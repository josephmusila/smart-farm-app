// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// displaySnackBar(BuildContext context, String msg) {
//   final snackBar = SnackBar(
//     content: Text(msg),
//     action: SnackBarAction(
//       label: 'Ok',
//       onPressed: () {},
//     ),
//   );
//   Scaffold.of(context).showSnackBar(snackBar);
// }
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     super.initState();
//     getInitLedState(); // Getting initial state of LED, which is by default on
//   }
//
//   String _status = '';
//   String url =
//       'http://192.168.1.200:80/'; //IP Address which is configured in NodeMCU Sketch
//   var response;
//
//   getInitLedState() async {
//     try {
//       response =
//           await http.get(Uri.parse(url), headers: {"Accept": "plain/text"});
//       setState(() {
//         _status = 'On';
//       });
//     } catch (e) {
//       // If NodeMCU is not connected, it will throw error
//       print(e);
//       if (this.mounted) {
//         setState(() {
//           _status = 'Not Connected';
//         });
//       }
//     }
//   }
//   // nn
//
//   toggleLed() async {
//     try {
//       response = await http
//           .get(Uri.parse('${url}led'), headers: {"Accept": "plain/text"});
//       setState(() {
//         _status = response.body;
//         print(response.body);
//       });
//     } catch (e) {
//       // If NodeMCU is not connected, it will throw error
//       print(e);
//       displaySnackBar(context, 'Module Not Connected');
//     }
//   }
//
//   turnOnLed() async {
//     try {
//       response = await http
//           .get(Uri.parse('${url}led/on'), headers: {"Accept": "plain/text"});
//       setState(() {
//         _status = response.body;
//         print(response.body);
//       });
//     } catch (e) {
//       // If NodeMCU is not connected, it will throw error
//       print(e);
//       displaySnackBar(context, 'Module Not Connected');
//     }
//   }
//
//   turnOffLed() async {
//     try {
//       response = await http
//           .get(Uri.parse('${url}led/off'), headers: {"Accept": "plain/text"});
//       setState(() {
//         _status = response.body;
//         print(response.body);
//       });
//     } catch (e) {
//       // If NodeMCU is not connected, it will throw error
//       print(e);
//       displaySnackBar(context, 'Module Not Connected');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       shadowColor: Colors.blue,
//       child: ListView(children: <Widget>[
//         Container(
//           margin: const EdgeInsets.only(bottom: 5, top: 5),
//           child: const Text(
//             'Main Water Pump System',
//             style: TextStyle(
//               color: Colors.blue,
//               decoration: TextDecoration.underline,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Container(
//           child: Text(
//             'Pump Status: $_status',
//             textAlign: TextAlign.center,
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(25.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               // RaisedButton(
//               //   onPressed: toggleLed,
//               //   child: Text('Toggle LED'),
//               // ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.green,
//                 ),
//                 onPressed: turnOnLed,
//                 child: Text('Turn  On'),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.red,
//                 ),
//                 onPressed: turnOffLed,
//                 child: Text('Turn  Off'),
//               ),
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }
