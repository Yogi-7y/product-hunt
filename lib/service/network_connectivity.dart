import 'package:connectivity/connectivity.dart';

abstract class NetworkConnectivity {
  Future<bool> get isConnected;
}

class NetworkConnectivityChecker implements NetworkConnectivity {
  final Connectivity connectivity = Connectivity();

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();

    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }
}
