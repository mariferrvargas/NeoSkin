import 'dart:async';
import 'dart:convert';
//import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<BluetoothDevice> _devices = [];
  late BluetoothConnection connection;
  String adr = "00:21:07:00:50:69"; // my bluetooth device MAC Adres
  String recData = "0";

  late Timer _timer;
  String _timeString = "";

  @override
  void initState() {
    // _startTimer();  automatic
    super.initState();
    _loadDevices();
  }


  Future<void> _loadDevices() async {
    List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance
        .getBondedDevices();

    setState(() {
      _devices = devices;
    });
  }


  //----------------------------
  Future<void> sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      connection.output.add(bytes);
      await connection.output.allSent;
      if (kDebugMode) {
        // print('Data sent successfully');
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  // data RECEIVED --------------

  Future<void> receiveData() async {
    connection.input!.listen((Uint8List data) {
      //Data entry point
      setState(() {
        recData=ascii.decode(data);
        //var n1 = int.parse('-42');
      });
    });
  }
  //--------------------------------------

// TIMER START-----------
  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      receiveData();

    });
  }

  // TIMER STOP--------------------------------------
  Future<void> _stopTimer() async {
    setState(() {
    });
    _timer.cancel();
  }

//---------------------------------------------
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("--- Heart rate monitor with BlueTooth-----"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("MAC Adress: 00:21:07:00:50:69"),

                ElevatedButton(child: Text("Connect"), onPressed: () {
                  connect(adr);
                },),

                const SizedBox(height: 30.0,),

                const Text("HR: ",style: TextStyle(fontSize: 55.0),),
                Text(recData,style: TextStyle(fontSize: 90.0),),

                const SizedBox(height: 10.0,),
                // Text(_timeString),
                const SizedBox(height: 10.0,),

                ElevatedButton(child: Text("Stop timer"), onPressed: () {
                  _stopTimer();
                },),
                const SizedBox(height: 10.0,),

                ElevatedButton(child: Text("Start timer"), onPressed: () {
                  _startTimer();
                },),

              ],
            ),
          ),

        )

    );
  }

  Future connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      // sendData('111');
      //durum="Connected to the device";

    } catch (exception) {
      // durum="Cannot connect, exception occured";
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }

// --------------**************data gonder
//Future send(Uint8List data) async {
//connection.output.add(data);
// await connection.output.allSent;
// }

}
//------------*********** data gonder end