import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/Message.dart';
import 'model/User.dart';
import 'model/Channel.dart';

abstract interface class IAddaSDK {
  Future<User?> getUserByID(String userId);
  Future<Channel?> getChannelByID(String channelId);
}

class AddaSDK implements IAddaSDK {
  final String baseUrl = "{{ms-users-api-host}}"; //URL FAKE

//////Users//////

  @override
  Future<User?> getUserByID(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/v1/users/$userId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        print('Erro ao buscar usuário: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
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

  Future<User?> createUser(User newUser) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/v1/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'first_name': newUser.firstName,
          'last_name': newUser.lastName,
          'email': newUser.email,
          'description': newUser.description,
          'nickname': newUser.nickname,
          'cpf': newUser.cpf,
          'categories': newUser.categories.map((cat) => cat.toJson()).toList(),
          'isDenunciated': newUser.isDenunciated
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        print('Erro ao criar usuário: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<User?> updateUserByID(
      String userId, Map<String, dynamic> updates) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/v1/users/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        print('Erro ao atualizar usuário: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

//////Channel//////

  @override
  Future<Channel?> getChannelByID(String channelId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/v1/channels/$channelId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Channel.fromJson(data);
      } else {
        print('Erro ao buscar Channel: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<List<Channel>?> getChannelByName(String name) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/v1/channels?name=$name'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => Channel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print('Erro ao buscar canais: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<List<Channel>?> listChannelsByUser(String userId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/v1/channels?member=$userId'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => Channel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print(
            'Erro ao buscar canais para o usuário $userId: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<Channel?> createChannel(Channel newChannel) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/v1/channels'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': newChannel.name,
          'description': newChannel.description,
          'members': newChannel.members.map((member) => member.id).toList(),
          'admins': newChannel.admins.map((admin) => admin.id).toList(),
          'imageUrl': newChannel.imageUrl
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Channel.fromJson(data);
      } else {
        print('Erro ao criar Channel: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
    }
  }

  Future<Channel?> updateChannelByID(
      String channelId, Map<String, dynamic> updates) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/v1/channels/$channelId'),
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

  Future<List<Message>?> listMessagesByChannel(String channelId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/v1/channels/$channelId/messages'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((msgJson) => Message.fromJson(msgJson as Map<String, dynamic>))
            .toList();
      } else {
        print('Erro ao buscar Messages: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro inesperado: $e');
      return null;
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

  Future<bool> sendMessage({
    required String channelId,
    required String senderId,
    required String type,
    required String content,
  }) async {
    final url = Uri.parse('$baseUrl/v1/channels/$channelId/messages');

    // Criar o corpo da requisição
    final body = jsonEncode({
      'sender_id': senderId,
      'type': type,
      'content': content,
    });

    try {
      // Fazer a requisição POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Verificar a resposta
      if (response.statusCode == 201) {
        print('Message enviada com sucesso');
        return true;
      } else {
        print('Erro ao enviar Message: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro inesperado ao enviar Message: $e');
      return false;
    }
  }

  Future<bool> deleteUnreadMessages() async {
    final url = Uri.parse('$baseUrl/v1/messages/unread');

    try {
      // Fazer a requisição DELETE
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
      });

      // Verificar a resposta
      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Messages não lidas deletadas com sucesso.');
        return true;
      } else {
        print('Erro ao deletar Messages não lidas: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Erro inesperado ao deletar Messages não lidas: $e');
      return false;
    }
  }
}
