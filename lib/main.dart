import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isOffline = false;
  late ConnectivityResult _connectivityResult;
  final Location location = Location();

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _listenForConnectivityChanges();
    _getLocation(); // Chama a função para obter a localização no início
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

  Future<LocationData?> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // Verifica se o serviço de localização está habilitado
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null; // Serviço de localização não habilitado
      }
    }

    // Verifica se a permissão foi concedida
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null; // Permissão não concedida
      }
    }

    // Obtém a localização
    LocationData _locationData = await location.getLocation();
    print('Localização: ${_locationData.latitude}, ${_locationData.longitude}');

    // Exibe um pop-up com as coordenadas
    _showLocationPopup(_locationData);
    return _locationData; // Retorna a localização
  }

  void _showLocationPopup(LocationData locationData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Localização do Usuário'),
          content: Text(
            'Latitude: ${locationData.latitude}\n'
            'Longitude: ${locationData.longitude}',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isOffline ? const NoInternet() : const FirstScreen(),
    );
  }
}
