import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

//this class is to checck whether or not the user is connectected to the internet
class NetworkConnectivity {
  NetworkConnectivity.connection();
  static final _instance = NetworkConnectivity.connection();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  // 1.
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      log('$result');
      _checkStatus(result);
    });
  }

// 2.
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();


  // 3
  
}


// _networkConnectivity.myStream.listen((source) {
//       _source = source;
//       print('source $_source');
//       // 1.
//       switch (_source.keys.toList()[0]) {
//         case ConnectivityResult.mobile:
//           string =
//               _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
//           break;
//         case ConnectivityResult.wifi:
//           string =
//               _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
//           break;
//         case ConnectivityResult.none:
//         default:
//           string = 'Offline';
//       }
//       // 2.
//       setState(() {});
//       // 3.
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             string,
//             style: const TextStyle(fontSize: 30),
//           ),
//         ),
//       );
//     });