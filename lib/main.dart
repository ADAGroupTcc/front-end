import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'screens/welcomescreen.dart';
import 'screens/nointernet.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inicializando o Firebase
    await Firebase.initializeApp();
    runApp(const MyApp());
  } catch (e) {
    print('Erro ao inicializar o Firebase: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isOffline = false;
  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _listenForConnectivityChanges();
  }

  void _updateConnectivityState(ConnectivityResult result) {
    setState(() {
      _connectivityResult = result;
      _isOffline = _connectivityResult == ConnectivityResult.none;
    });
  }

  Future<void> _checkInitialConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectivityState(connectivityResult);
  }

  void _listenForConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectivityState(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isOffline ? const NoInternet() : const FirstScreen(),
    );
  }
}
