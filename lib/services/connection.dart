import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionUtil {
  static Future<Map<String, dynamic>> checkConnection() async {
    final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      return {'status': 'Connected to WiFi', 'color': Colors.green};
    } else if (connectivityResult == ConnectivityResult.mobile) {
      return {'status': 'Connected to Mobile network', 'color': Colors.green};
    } else {
      return {'status': 'No internet connection', 'color': Colors.red};
    }
  }
}
