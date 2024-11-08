import 'package:flutter/material.dart';
import 'package:addaproject/sdk/model/User.dart';
import 'package:addaproject/sdk/AddaSDK.dart';
import 'package:addaproject/sdk/LocalCache.dart';
import '../utils/customtextfield.dart';

const Color preto = Color(0xFF0D0D0D);
const Color branco = Color(0xFFFFFAFE);
const Color cinzaClaro = Color(0x4dfffafe);
const Color pretobg = Color(0xFF171717);

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  Future<void> _updateUser(BuildContext context) async {
    LocalCache _localCache = LocalCache();
    User? user = await _localCache.getUserSession();

    if (user == null) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Usuário não encontrado"),
            content: const Text("Não foi possível identificar o usuário logado."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                Navigator.of(context).pop();
              },
              ),
            ],
          );
        },
      );
      return;
    }

    final String nickname = _nameController.text;
    final String description = _bioController.text;

    // Validação do nickname
    final nicknameRegExp = RegExp(r'^[a-zA-Z0-9._]{1,30}$');
    if (!nicknameRegExp.hasMatch(nickname)) {
      final errorMessage = nickname.length > 30
          ? "Máximo 30 caracteres."
          : "Presença de caracter(es) inválido(s). Você pode usar apenas letras, pontos, números ou sublinhados.";

      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Nickname inválido"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return;
    }

    // Validação da descrição
    if (description.length > 150) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Descrição muito longa"),
            content: const Text("Sua descrição deve conter no máximo 150 caracteres."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return;
    }

    final Map<String, dynamic> updates = {
      'nickname': nickname,
      'description': description,
    };

    try {
      if (nickname != "") {
        user.nickname = nickname;
      }

      if (description != "") {
        user.description = description;
      }

      await AddaSDK().updateUserByID(user.id, updates);
      await LocalCache().saveUserSession(user);

      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Perfil atualizado com sucesso"),
            content: const Text("Seu perfil foi atualizado com sucesso"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Erro ao atualizar usuário: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: pretobg,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Parte superior com a imagem de background e ícones
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background de onda (wave)
                  Image.asset(
                    'assets/fullblackwave.png',
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.064),
                          child: CircleAvatar(
                            radius: screenWidth * 0.13,
                            backgroundImage: const AssetImage('assets/default_pfp.png'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.064),
                          child: Image.asset(
                            'assets/personalizeprofile.png',
                            fit: BoxFit.fitWidth,
                            width: screenWidth * 0.101,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      label: 'Nome do usuário',
                      inputType: TextInputType.text,
                      isobscure: false,
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: _bioController,
                      label: 'Bio',
                      inputType: TextInputType.text,
                      isobscure: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.0465,
            left: screenWidth * 0.0465,
            child: GestureDetector(
              onTap: () {
                // Após salvar as alterações
                Navigator.pop(context, true); 
              },
              child: Image.asset(
                'assets/voltarbtn.png',
                fit: BoxFit.fitWidth,
                width: screenWidth * 0.1,
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.07,
            left: screenWidth * 0.064,
            right: screenWidth * 0.064,
            child: ElevatedButton(
              onPressed: () => _updateUser(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.012,
                ),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: branco, width: 2),
                ),
              ),
              child: Text(
                "Salvar alterações",
                style: TextStyle(
                  color: branco,
                  fontFamily: "Amaranth",
                  fontSize: screenWidth * 0.06,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}