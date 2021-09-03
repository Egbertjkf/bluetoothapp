import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Request Bluetoolth'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String state = "";
  static const methodChannel = MethodChannel('com.example.bluetooth/method');

  //Stream will constantly check bluetooth status
  final Stream<String> checkBlue = (() async* {
    while (true) {
      var result = await methodChannel.invokeMethod('isBluetoothActive');
      result = await methodChannel.invokeMethod('isBluetoothActive');

      yield result.toString();
    }
  })();

  //ask to activate luetooth on android and sendo to configuration on ios
  Future<void> ativaBluetooth() async {
    await methodChannel.invokeListMethod('ativaBluetooth');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: checkBlue,
        builder: (c, snapshot) {
          state = snapshot.data.toString();
          if (state == 'true') {
            return Scaffold(
              body: Card(
                color: Colors.blue,
                child: Center(
                  child: Container(
                    child: Text("Bluetooth is Active!"),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
                body: Container(
              color: Colors.red,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: Text(
                              "Bluetooth is not Active!",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                ativaBluetooth();
                              },
                              child: Text("Click to Activate")),
                        ]),
                  ),
                ),
              ),
            ));
          }
        });
  }
}
