import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http/http.dart' as http;
import 'model/Categoria.dart';
import 'model/Message.dart';
import 'model/SessionToken.dart';
import 'model/User.dart';
import 'model/Channel.dart';
import 'package:location/location.dart';

class AddaSDK {
  final String userBaseUrl = "https://ms-users-api.onrender.com";
  final String sessionBaseUrl = "https://ms-session-api.onrender.com";
  final String channelBaseUrl = "https://ms-channel-api.onrender.com";
  final String baseUrl = "https://ms-users-api.onrender.com";
  final String messagesBaseUrl = "https://ms-messages-api.onrender.com";
  final String categoriesBaseUrl = "https://ms-categories-api.onrender.com";
  Dio httpClient = Dio();
  Location location = Location();

  AddaSDK() {
    // Configuração para ignorar a verificação de certificado
    (httpClient.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<User?> createUser(UserCreate newUser) async {
    final body = jsonEncode(newUser.toJson());
    try {
      final response = await httpClient.post(
        '$userBaseUrl/v1/users',
        data: body,
      );
      final dynamic data = await response.data;
      return User.fromJson(data);
    } catch (e) {
      // melhorar depois
      if (e is DioException) {
        throw Exception('${e.response}');
      }
      throw Exception("$e");
    }
  }

  Future<User?> getUserByID(String userId) async {
    try {
      final queryParams = {"user_ids": userId, "show_categories": true};
      final response = await httpClient.get('$baseUrl/v1/users',
          queryParameters: queryParams);
      final users = response.data;
      return User.fromJson(users[0]);
    } catch (e) {
      // melhorar depois
      if (e is DioException) {
        throw Exception('${e.response}');
      }
      throw Exception("$e");
    }
  }

  Future<List<User>?> listUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/v1/users'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
            .toList();
      } else {
        print('Erro ao buscar usuários: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<List<User>?> getUserByName(String name) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/v1/users?name=$name'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => User.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print('Erro ao buscar usuários: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<void> updateUserByID(
      String userId, Map<String, dynamic> updates) async {
    try {
      await httpClient.patch(
        '$userBaseUrl/v1/users/$userId',
        data: jsonEncode(updates),
      );
      return;
    } catch (e) {
      print('Erro inesperado: $e');
      return;
    }
  }

  Future<SessionToken> getAccessToken(String userId) async {
    try {
      final response = await httpClient
          .post('$sessionBaseUrl/v1/users/$userId/session', data: null);
      final dynamic responseBody = await response.data;
      return SessionToken().fromJson(responseBody);
    } catch (e) {
      // melhorar depois
      if (e is DioException) {
        throw Exception('${e.response}');
      }
      throw Exception("$e");
    }
  }

  Future<bool> validateAccessToken(String session, String userId) async {
    try {
      await httpClient.post('$sessionBaseUrl/v1/users/$userId/validate',
          options: Options(headers: {'Authorization': session}));
    } catch (e) {
      e as DioException;
      if (e.response!.statusCode == 401) {
        return false;
      }
    }
    return true;
  }

//////Channel//////

  Future<ChannelResponse> listChannelsByUserId(String userId) async {
    try {
      final headers = {
        "user_id": userId,
      };
      final queryParams = {
        "show_members": true,
      };
      final response = await httpClient.get('$channelBaseUrl/v1/channels',
          queryParameters: queryParams, options: Options(headers: headers));
      return ChannelResponse.fromJson(response.data);
    } catch (e) {
      // melhorar depois
      if (e is DioException) {
        throw Exception('${e.response}');
      }
      throw Exception("$e");
    }
  }

  Future<Channel?> updateChannelByID(
      String channelId, String user_id, Map<String, dynamic> updates) async {
    try {
      final url = Uri.parse('$channelBaseUrl/v1/channels/$user_id/$channelId');

      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Channel.fromJson(data);
      } else {
        print('Erro ao atualizar Channel: ${response.statusCode}');
        print('Updating channel at URI: $url'); // Print the URI
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<List<Channel>?> listUnreadChannels() async {
    final url = Uri.parse('$baseUrl/v1/channels/unread');

    try {
      // Fazer a requisição GET
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      // Verificar a resposta
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Converter o JSON em uma lista de objetos Channel
        return data
            .map((json) => Channel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print('Erro ao buscar canais não lidos: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado ao buscar canais não lidos: $e');
      return null;
    }
  }

//////Messages//////

  Future<List<Message>?> listMessagesByChannelId(String channelId) async {
    try {
      final response = await httpClient
          .get('$messagesBaseUrl/v1/channels/$channelId/messages');
      return MessagesResponse.fromJson(response.data).messages;
    } catch (e) {
      // melhorar depois
      if (e is DioException) {
        throw Exception('${e.response}');
      }
      throw Exception("$e");
    }
  }

  Future<Message?> updateMessageByID(
      String channelId, String messageId, Map<String, dynamic> updates) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/v1/channels/$channelId/messages/$messageId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Message.fromJson(data);
      } else {
        print('Erro ao atualizar Message: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  ///Location

  Future<LocationData?> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    LocationData locationData = await location.getLocation();
    print('Localização: ${locationData.latitude}, ${locationData.longitude}');
    return locationData; // Retorna a localização
  }

  //Categories:
  Future<CategoriesResponse> listCategories() async {
    try {
      final response = await httpClient.get('$categoriesBaseUrl/v1/categories');
      final categories = response.data;
      return CategoriesResponse.fromJson(categories);
    } catch (e) {
      // melhorar depois
      if (e is DioException) {
        throw Exception('${e.response}');
      }
      throw Exception("$e");
    }
  }
}
