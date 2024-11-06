import 'package:addaproject/screens/acceptstation.dart';
import 'package:addaproject/sdk/LocalCache.dart';
import 'package:addaproject/sdk/model/User.dart';
import 'package:addaproject/utils/menuBar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/nointernet.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cache = LocalCache();
  
  try {
    await Firebase.initializeApp();
    final res = await cache.getUserSession();
    if (res == null) {
      runApp(const MyApp());
    } else {
      runApp(MenuBarGeneral(user: res));
    }
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
    return _isOffline ? const NoInternet() : MenuBarGeneral(user: User(firstName: 'Gabriel', lastName: 'Lopes', email: 'gabriellopes.gl2805@gmail.com', nickname: 'biellok4sso', cpf: '24158608830', categories: []),);
  }
}

//