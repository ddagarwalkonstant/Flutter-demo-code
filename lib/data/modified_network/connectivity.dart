import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatus {

  static final ConnectionStatus _singleton = ConnectionStatus._internal();


  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController<bool> connectionChangeController =
  StreamController.broadcast();
  Stream<bool> get connectionChange => connectionChangeController.stream;

  //This creates the single instance by calling
  // the `_internal` constructor specified below
  ConnectionStatus._internal();

  //The test to actually see if there is a connection
  //This is what's used to retrieve the instance through the app
  static ConnectionStatus getInstance() => _singleton;

  Future<bool> checkConnection() async {
    final previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }






  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    unawaited(checkConnection());
  }


  //A clean up method to close our StreamController
  //   Because this is meant to exist through
  //   the entire application life cycle this isn't
  //   really an issue
  void dispose()  {
    unawaited(connectionChangeController.close());
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    unawaited(checkConnection());
  }


}
