import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List latestData = [];
  UsbPort? _port;
  String _status = "Idle";
  List<Widget> _ports = [];
  // ignore: prefer_final_fields
  List<Widget> _serialData = [Text("please wait")];

  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  UsbDevice? _device;

  // ignore: prefer_final_fields, unused_field
  TextEditingController _textController = TextEditingController();

  
  

  Future<bool> _connectTo(device) async {
    _serialData.clear();

    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction!.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port!.close();
      _port = null;
    }

    if (device == null) {
      _device = null;
      setState(() {
        _status = "Disconnected";
      });
      return true;
    }

    _port = await device.create();
    if (await (_port!.open()) != true) {
      setState(() {
        _status = "Failed to open port";
      });
      return false;
    }
    _device = device;

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(_port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));

    _subscription = _transaction!.stream.listen((String line) {
      setState(() {
        // _serialData.add(Text(line));
        _serialData = [Text(line)];
        if (_serialData.length > 20) {
          _serialData.removeAt(0);
        }
      });
    });

    setState(() {
      _status = "Connected";
    });
    return true;
  }

  // Future<bool> requestFilePermission() async {
  //   PermissionStatus result;
  //   // In Android we need to request the storage permission,
  //   // while in iOS is the photos permission
  //   if (Platform.isAndroid) {
  //     result = await Permission.storage.request();
  //     print("platform is android");
  //   } else {
  //     print("platform is not android");
  //   }
  //   return false;
  // }

  void _getPorts() async {
    _ports = [];
    List<UsbDevice> devices = await UsbSerial.listDevices();
    if (!devices.contains(_device)) {
      _connectTo(null);
    }
    print(devices);

    devices.forEach((device) {
      _ports.add(ListTile(
          leading: const Icon(Icons.usb),
          title: Text(device.productName!),
          subtitle: Text(device.manufacturerName!),
          trailing: ElevatedButton(
            child: Text(_device == device ? "Disconnect" : "Connect"),
            onPressed: () {
              print('pressed connect button');
              _connectTo(_device == device ? null : device).then((res) {
                _getPorts();
              });
            },
          )));
    });

    setState(() {
      print(_ports);
    });
  }

  @override
  void initState() {
    super.initState();

    UsbSerial.usbEventStream!.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
  }

  @override
  void dispose() {
    super.dispose();
    _connectTo(null);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(_serialData);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('USB Serial Plugin app'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Text(_ports.isNotEmpty ? "Available Serial Ports" : "No serial devices available", style: Theme.of(context).textTheme.titleLarge),
        ..._ports,
        Text('Status: $_status\n'),
        Text('info: ${_port.toString()}\n'),
        
        Text("Result Data", style: Theme.of(context).textTheme.titleLarge),
      ..._serialData,
        // _serialData.length > 0 ?  Text("Result Data", style: Theme.of(context).textTheme.titleLarge),
        // _serialData[_serialData.length-1]
      ])),
    ));
  }
}
