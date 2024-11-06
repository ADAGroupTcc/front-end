import 'dart:async';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  final String url = 'ws://ms-handler-api.onrender.com/ws';
  final String userId;
  late IOWebSocketChannel _channel;
  late StreamSubscription _subscription;
  Function(String)? onMessageReceived;
  Function()? onConnected;
  Function()? onDisconnected;

  WebSocketService({
    required this.userId,
    this.onMessageReceived,
    this.onConnected,
    this.onDisconnected,
  });

  Future<void> connect() async {
    try {
      final socket = await WebSocket.connect(
        url,
        headers: {
          'user_id': userId,
        },
      );

      _channel = IOWebSocketChannel(socket);

      _subscription = _channel.stream.listen(
            (message) {
          if (onMessageReceived != null) {
            onMessageReceived!(message);
          }
        },
        onDone: () {
          if (onDisconnected != null) {
            onDisconnected!();
          }
        },
        onError: (error) {
          print("Erro na conexão WebSocket: $error");
          disconnect();
        },
      );

      if (onConnected != null) {
        onConnected!();
      }
    } catch (e) {
      print("Erro ao conectar ao WebSocket: $e");
    }
  }

  void send(String message) {
    _channel.sink.add(message);
  }

  void disconnect() {
    _subscription.cancel();
    _channel.sink.close(status.goingAway);
  }

  void dispose() {
    disconnect();
  }
}
