// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

// import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:async';
// import 'dart:typed_data';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
// import './tableMaterial.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
// import 'package:external_path/external_path.dart';
// import 'package:ext_storage/ext_storage.dart';

// import 'package:path_provider/path_provider.dart';
// import './classX.dart' show X;

class X {
  final String Time;
  final String Speed;
  final String Battery;
  final String BatteryTotalCurrent;
  final String BatteryAvgVoltage;
  final String Battery_1_current;
  final String Battery_2_current;
  final String Battery_3_current;
  final String Battery_1_SOC;
  final String Battery_2_SOC;
  final String Battery_3_SOC;
  final String Battery_1_VOLT;
  final String Battery_2_VOLT;
  final String Battery_3_VOLT;
  final String Throttle_percentage;
  final String Controller_Temp;
  final String Motor_temp;
  final String Motor_DC_Current;
  final String Motor_DC_Voltage;
  final String Motor_AC_Voltage;
  final String Motor_AC_Current;
  final String TRIP_1;
  final String T_sense1;
  final String T_sense2;
  final String T_sense3;
  final String T_sense4;

  X(
      this.Time,
      this.Speed,
      this.Battery,
      this.BatteryTotalCurrent,
      this.BatteryAvgVoltage,
      this.Battery_1_current,
      this.Battery_2_current,
      this.Battery_3_current,
      this.Battery_1_SOC,
      this.Battery_2_SOC,
      this.Battery_3_SOC,
      this.Battery_1_VOLT,
      this.Battery_2_VOLT,
      this.Battery_3_VOLT,
      this.Throttle_percentage,
      this.Controller_Temp,
      this.Motor_temp,
      this.Motor_DC_Current,
      this.Motor_DC_Voltage,
      this.Motor_AC_Voltage,
      this.Motor_AC_Current,
      this.TRIP_1,
      this.T_sense1,
      this.T_sense2,
      this.T_sense3,
      this.T_sense4);

  X.fromJson(Map<String, dynamic> json)
      : Time = json['Time'],
        Speed = json['Speed'],
        Battery = json['Battery'],
        BatteryTotalCurrent = json['BatteryTotalCurrent'],
        BatteryAvgVoltage = json['BatteryAvgVoltage'],
        Battery_1_current = json['Battery_1_current'],
        Battery_2_current = json['Battery_2_current'],
        Battery_3_current = json['Battery_3_current'],
        Battery_1_SOC = json['Battery_1_SOC'],
        Battery_2_SOC = json['Battery_2_SOC'],
        Battery_3_SOC = json['Battery_3_SOC'],
        Battery_1_VOLT = json['Battery_1_VOLT'],
        Battery_2_VOLT = json['Battery_2_VOLT'],
        Battery_3_VOLT = json['Battery_3_VOLT'],
        Throttle_percentage = json['Throttle_percentage'],
        Controller_Temp = json['Controller_Temp'],
        Motor_temp = json['Motor_temp'],
        Motor_DC_Current = json['Motor_DC_Current'],
        Motor_DC_Voltage = json['Motor_DC_Voltage'],
        Motor_AC_Voltage = json['Motor_AC_Voltage'],
        Motor_AC_Current = json['Motor_AC_Current'],
        TRIP_1 = json['TRIP_1'],
        T_sense1 = json['T_sense1'],
        T_sense2 = json['T_sense2'],
        T_sense3 = json['T_sense3'],
        T_sense4 = json['T_sense4'];

  Map<String, dynamic> toJson() => {
        'Time': Time,
        'Speed': Speed,
        'Battery': Battery,
        'BatteryTotalCurrent': BatteryTotalCurrent,
        'BatteryAvgVoltage': BatteryAvgVoltage,
        'Battery_1_current': Battery_1_current,
        'Battery_2_current': Battery_2_current,
        'Battery_3_current': Battery_3_current,
        'Battery_1_SOC': Battery_1_SOC,
        'Battery_2_SOC': Battery_2_SOC,
        'Battery_3_SOC': Battery_3_SOC,
        'Battery_1_VOLT': Battery_1_VOLT,
        'Battery_2_VOLT': Battery_2_VOLT,
        'Battery_3_VOLT': Battery_3_VOLT,
        'Throttle_percentage': Throttle_percentage,
        'Controller_Temp': Controller_Temp,
        'Motor_temp': Motor_temp,
        'Motor_DC_Current': Motor_DC_Current,
        'Motor_DC_Voltage': Motor_DC_Voltage,
        'Motor_AC_Voltage': Motor_AC_Voltage,
        'Motor_AC_Current': Motor_AC_Current,
        'TRIP_1': TRIP_1,
        'T_sense1': T_sense1,
        'T_sense2': T_sense2,
        'T_sense3': T_sense3,
        'T_sense4': T_sense4
      };
}

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
  List<Widget> _serialData = [const Text("please wait")];

  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  UsbDevice? _device;
  String yolo = '';
  var data;
  List<List<dynamic>> rows = [];
  bool isCreated = false;
  bool logging = false;
  String _csvName = '';
  int count = 1;
  var sheet;
  var excel;
  // final excel = Excel.createExcel();
  //     final sheet = excel[excel.getDefaultSheet()!];

  // List<dynamic> row = ["Speed", "Battery", "Time"];
  // rows.add(row)

  // ignore: prefer_final_fields, unused_field
  TextEditingController controller = TextEditingController();

  // @override void dispose() {
  //   _textController.dispose();
  //   super.dispose();
  // }

  // Future makeCSV() {
  //   final excel = Excel.createExcel();
  //   final sheet = excel[excel.getDefaultSheet()!];
  //   sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
  //       'Time';
  //   // return null;
  // }

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
    await _port!.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
        _port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));

//     XYZ(data) async {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.storage,
//       ].request();
//       String csv = const ListToCsvConverter().convert(rows);

// // String dir = await ExtStorage.getExternalStoragePublicDirectory(
// //     ExtStorage.DIRECTORY_DOWNLOADS);
// // print("dir $dir");
// // String file = "$dir";

// // String dir = (await getExternalStorageDirectory()).path;
// //   String filePath = "$dir/list.csv";

//       File f = File("file:///storage/emulated/0/Documents/test.csv");
//       f.writeAsString(csv);
//     }

    _subscription = _transaction!.stream.listen((String line) {
      setState(() {
        // _serialData.add(Text(line));
        yolo = line;
        Map<String, dynamic> dataMap = jsonDecode(yolo);
        data = X.fromJson(dataMap);
        rows.add([data]);
        // ignore: unused_local_variable
        //  String csvData = ListToCsvConverter().convert(data);
        _serialData = [Text(line)];
        if (_serialData.length > 20) {
          _serialData.removeAt(0);
        }
        // XYZ(data);
      });
      exportToFlutter(data);
      setState(() {
        isCreated = true;
      });
    });
    ///////////////////////////////////////////////////////////////////////////////////////////////////////

    setState(() {
      _status = "Connected";
    });
    return true;
  }

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

  exportToFlutter(x) async {
    print('entered csv function');
    // if (isCreated == false) {
    //   final excel = Excel.createExcel();
    //   final sheet = excel[excel.getDefaultSheet()!];
    //   sheet
    //       .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
    //       .value = 'Time';
    // }
    // final excel = Excel.createExcel();
    // final sheet = excel[excel.getDefaultSheet()!];
    // sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
    //     'Time';

    //  final excel = Excel.createExcel();

    // sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 1)).value =
    //     'yolo';
    // excel.save(fileName: 'testExcel');
    // if (x.time > 0) {
    //   sheet.appendRow(x.time);
    // }
    // sheet.appendRow(['abhilash', data.Time]);
    if (logging == true) {
      sheet.insertRowIterables([data.Time], count);
      var fileBytes = excel.save();
      File(join("/storage/emulated/0/Download/$_csvName.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);
    }

    // var directory = await getApplicationDocumentsDirectory();

    print('file creation done with name ');
    setState(() {
      isCreated = true;
      count += 1;
    });
  }

  // void getName() {
  //   setState(() {
  //     _csvName = 'abhilalsh';
  //   });
  // }

  void setCreation() {
    excel = Excel.createExcel();
    sheet = excel[excel.getDefaultSheet()!];
    //  var fileBytes = excel.save();

    File(join("/storage/emulated/0/Download/$_csvName.xlsx"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.save()!);
    setState(() {
      count = 1;
      isCreated = true;
      logging = true;
    });
  }

  void stopLogger() {
    setState(() {
      logging = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print('start app');
    // final excel = Excel.createExcel();
    // final sheet = excel[excel.getDefaultSheet()!];
    UsbSerial.usbEventStream!.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
    // sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
    //     'Time';
  }

  @override
  void dispose() {
    controller.dispose();
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
        Text(
            _ports.isNotEmpty
                ? "Available Serial Ports"
                : "No serial devices available",
            style: Theme.of(context).textTheme.titleLarge),
        ..._ports,
        Text('Status: $_status\n'),
        Text('info: ${_port.toString()}\n'),
        TextField(
          controller: controller,
          onSubmitted: (String value) {
            setState(() {
              _csvName = controller.text;
            });
          },
          onChanged: (String value) {
            setState(() {
              _csvName = controller.text;
            });
          },
        ),
        // ElevatedButton(onPressed: exportToFlutter(data), child: const Text('start logging')),
        // ElevatedButton(onPressed: exportToFlutter(data), child: const Text('stop logging')),
        // Text("Result Data", style: Theme.of(context).textTheme.titleLarge),
        // ..._serialData,

        if (yolo.isNotEmpty)
          Text(
            'Time : ' + data.Time,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        if (logging == false && _csvName.length > 2 && _status == 'Connected')
          ElevatedButton(onPressed: setCreation, child: const Text('startLog')),
        if (logging == true)
          ElevatedButton(
            onPressed: stopLogger,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            child: const Text('stopLog'),
          ),
           Text('Speed : ')

        // if (yolo.isNotEmpty) Text('Speed : ' + data.Speed),
        // if (yolo.isNotEmpty) Text('Battery : ' + data.Battery),
        // if (yolo.isNotEmpty)
        //   Text('BatteryTotalCurrent : ' + data.BatteryTotalCurrent),
        // if (yolo.isNotEmpty)
        //   Text('BatteryAvgVoltage : ' + data.BatteryAvgVoltage),
        // if (yolo.isNotEmpty)
        //   Text('Battery_1_current : ' + data.Battery_1_current),
        // if (yolo.isNotEmpty)
        //   Text('Battery_2_current : ' + data.Battery_2_current),
        // if (yolo.isNotEmpty)
        //   Text('Battery_3_current : ' + data.Battery_3_current),
        // if (yolo.isNotEmpty) Text('Battery_1_SOC : ' + data.Battery_1_SOC),
        // if (yolo.isNotEmpty) Text('Battery_2_SOC : ' + data.Battery_2_SOC),
        // if (yolo.isNotEmpty) Text('Battery_3_SOC : ' + data.Battery_3_SOC),
        // if (yolo.isNotEmpty) Text('Battery_1_VOLT : ' + data.Battery_1_VOLT),
        // if (yolo.isNotEmpty) Text('Battery_2_VOLT : ' + data.Battery_2_VOLT),
        // if (yolo.isNotEmpty) Text('Battery_3_VOLT : ' + data.Battery_3_VOLT),
        // if (yolo.isNotEmpty)
        //   Text('Throttle_percentage : ' + data.Throttle_percentage),
        // if (yolo.isNotEmpty) Text('Controller_Temp : ' + data.Controller_Temp),
        // if (yolo.isNotEmpty) Text('Motor_temp : ' + data.Motor_temp),
        // if (yolo.isNotEmpty)
        //   Text('Motor_DC_Current : ' + data.Motor_DC_Current),
        // if (yolo.isNotEmpty)
        //   Text('Motor_DC_Voltage : ' + data.Motor_DC_Voltage),
        // if (yolo.isNotEmpty)
        //   Text('Motor_AC_Voltage : ' + data.Motor_AC_Voltage),
        // if (yolo.isNotEmpty)
        //   Text('Motor_AC_Current : ' + data.Motor_AC_Current),
        // if (yolo.isNotEmpty) Text('TRIP_1 : ' + data.TRIP_1),
        // if (yolo.isNotEmpty) Text('T_sense1 : ' + data.T_sense1),
        // if (yolo.isNotEmpty) Text('T_sense2 : ' + data.T_sense2),
        // if (yolo.isNotEmpty) Text('T_sense3 : ' + data.T_sense3),
        // if (yolo.isNotEmpty) Text('T_sense4 : ' + data.T_sense4),

        // ElevatedButton(
        //     onPressed: exportToFlutter, child: const Text('generate CSV'))

        // if (yolo.isNotEmpty)
        //   Table(
        //     border: TableBorder.all(),
        //     columnWidths: const <int, TableColumnWidth>{
        //       0: IntrinsicColumnWidth(),
        //       1: FlexColumnWidth(),
        //       2: FixedColumnWidth(64),
        //     },
        //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        //     children: <TableRow>[
        //       TableRow(
        //         children: <Widget>[
        //           Container(
        //               height: 32,
        //               width: 152,
        //               // color: Colors.green,
        //               child: const Align(
        //                   alignment: Alignment.center,
        //                   child: Text('Speed',
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       )))),
        //           TableCell(
        //             // verticalAlignment: TableCellVerticalAlignment.top,
        //             child: Container(
        //               height: 32,
        //               width: 32,
        //               // color: Colors.red,
        //               child: Text(data.Speed,
        //                   textAlign: TextAlign.center,
        //                   style: const TextStyle(
        //                     fontSize: 20,
        //                   )),
        //             ),
        //           ),
        //           Container(
        //             height: 64,
        //             // color: Colors.blue,
        //           ),
        //         ],
        //       ),
        //       TableRow(
        //         children: <Widget>[
        //           Container(
        //               height: 32,
        //               width: 152,
        //               // color: Colors.green,
        //               child: const Align(
        //                   alignment: Alignment.center,
        //                   child: Text('Time',
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       )))),
        //           TableCell(
        //             // verticalAlignment: TableCellVerticalAlignment.top,
        //             child: Container(
        //               height: 32,
        //               width: 32,
        //               // color: Colors.red,
        //               child: Text(data.Time,
        //                   textAlign: TextAlign.center,
        //                   style: const TextStyle(
        //                     fontSize: 20,
        //                   )),
        //             ),
        //           ),
        //           Container(
        //             height: 64,
        //             // color: Colors.blue,
        //           ),
        //         ],
        //       ),
        //       TableRow(
        //         children: <Widget>[
        //           Container(
        //               height: 32,
        //               width: 152,
        //               // color: Colors.green,
        //               child: const Align(
        //                   alignment: Alignment.center,
        //                   child: Text('Battery',
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       )))),
        //           TableCell(
        //             // verticalAlignment: TableCellVerticalAlignment.top,
        //             child: Container(
        //               height: 32,
        //               width: 32,
        //               // color: Colors.red,
        //               child: Text(data.Battery,
        //                   textAlign: TextAlign.center,
        //                   style: const TextStyle(
        //                     fontSize: 20,
        //                   )),
        //             ),
        //           ),
        //           Container(
        //             height: 64,
        //             // color: Colors.blue,
        //           ),
        //         ],
        //       ),
        //       TableRow(
        //         children: <Widget>[
        //           Container(
        //               height: 50,
        //               width: 152,
        //               // color: Colors.green,
        //               child: const Align(
        //                   alignment: Alignment.center,
        //                   child: Text('BatteryTotalCurrent',
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                         fontSize: 16,
        //                       )))),
        //           TableCell(
        //             // verticalAlignment: TableCellVerticalAlignment.top,
        //             child: Container(
        //               height: 32,
        //               width: 32,
        //               // color: Colors.red,
        //               child: Text(data.BatteryTotalCurrent,
        //                   textAlign: TextAlign.center,
        //                   style: const TextStyle(
        //                     fontSize: 20,
        //                   )),
        //             ),
        //           ),
        //           Container(
        //             height: 64,
        //             // color: Colors.blue,
        //           ),
        //         ],
        //       ),
        //       TableRow(
        //         children: <Widget>[
        //           Container(
        //               height: 50,
        //               width: 152,
        //               // color: Colors.green,
        //               child: const Align(
        //                   alignment: Alignment.center,
        //                   child: Text('BatteryAvgVoltage',
        //                       textAlign: TextAlign.center,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       )))),
        //           TableCell(
        //             // verticalAlignment: TableCellVerticalAlignment.top,
        //             child: Container(
        //               height: 32,
        //               width: 32,
        //               // color: Colors.red,
        //               child: Text(data.BatteryAvgVoltage,
        //                   textAlign: TextAlign.center,
        //                   style: const TextStyle(
        //                     fontSize: 20,
        //                   )),
        //             ),
        //           ),
        //           Container(
        //             height: 64,
        //             // color: Colors.blue,
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
      ])),
    ));
  }
}
