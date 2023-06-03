import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '/services/connection.dart';
import '/screens/search_screen.dart';
import '/services/lottie_animation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  Color _connectionColor = Colors.black;
  String _connectionMessage = '';

  @override
  void initState() {
    super.initState();
    initConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
        updateConnectionStatus();
      });
    });
  }

  Future<void> initConnectivity() async {
    final connectionInfo = await ConnectionUtil.checkConnection();
    setState(() {
      _connectionStatus = connectionInfo['status'];
      _connectionColor = connectionInfo['color'];
      updateConnectionStatus();
    });
  }

  void updateConnectionStatus() {
    if (_connectionStatus == ConnectivityResult.wifi) {
      _connectionMessage = 'Connected to Wi-Fi';
      _connectionColor = Colors.green;
    } else if (_connectionStatus == ConnectivityResult.mobile) {
      _connectionMessage = 'Connected to Mobile network';
      _connectionColor = Colors.green;
    } else {
      _connectionMessage = 'No internet connection';
      _connectionColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(48),
            alignment: Alignment.center,
            child: Text(
              'Welcome to Gif search!',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    child: Text('Start'),
                  ),
                  SizedBox(height: 20),
                  LottieAnimation(), // Віджет з анімацією Lottie
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(
              'Connection Status: $_connectionMessage',
              style: TextStyle(fontSize: 18, color: _connectionColor),
            ),
          ),
        ],
      ),
    );
  }
}
