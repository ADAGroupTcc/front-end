import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcomescreen.dart';
import 'screens/nointernet.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    runApp(const MyApp());
  } catch (e) {
    print('Erro ao inicializar o Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
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
    return _isOffline ? const NoInternet() : const FirstScreen();
  }
}
