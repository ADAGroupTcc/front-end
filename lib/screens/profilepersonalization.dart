import 'package:addaproject/sdk/model/User.dart';
import 'package:flutter/material.dart';
import '../utils/backgroundwidget.dart';
import '../utils/customtextfield.dart';
import '../utils/menuBar.dart';
import 'package:addaproject/sdk/AddaSDK.dart';
import 'package:addaproject/sdk/LocalCache.dart';
import '../screens/profile.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);
const Color pretobg = Color(0xFF242424);

class ProfilePersonalization extends StatefulWidget {
  const ProfilePersonalization({super.key});

  @override
  State<ProfilePersonalization> createState() => _ProfilePersonalizationState();
}

class _ProfilePersonalizationState extends State<ProfilePersonalization> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile personalization page',
      home: ProfilePersonalizationPage(),
    );
  }
}

class ProfilePersonalizationPage extends StatefulWidget {
  const ProfilePersonalizationPage({super.key});

  @override
  _ProfilePersonalizationPageState createState() => _ProfilePersonalizationPageState();
}

class _ProfilePersonalizationPageState extends State<ProfilePersonalizationPage> {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  Future<void> _updateUser(BuildContext context) async {
    LocalCache _localCache = LocalCache();
    User? user = await _localCache.getUserSession();

    if (user == null) {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Usuário não encontrado"),
              content: const Text(
                  "Não foi possível identificar o usuário logado."),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
      return;
    }

    final String nickname = nicknameController.text;
    final String description = bioController.text;

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
            content: const Text(
                "Sua descrição deve conter no máximo 150 caracteres."),
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
          });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(user: user),
        ),
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
      body: Stack(
        children: [
          // Conteúdo rolável
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/fullblackwave.png',
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: screenHeight * 0.13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.064),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: screenWidth * 0.27,
                                    height: screenWidth * 0.27,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: pretobg,
                                        width: 5.0,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/personalizeprofile.png',
                                        fit: BoxFit.cover,
                                        width: screenWidth * 0.26,
                                        height: screenWidth * 0.26,
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.064),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    'assets/personalizeprofile.png',
                                    fit: BoxFit.fitWidth,
                                    width: screenWidth * 0.101,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Informações do perfil
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Text(
                    "Personalize seu perfil!",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                      fontWeight: FontWeight.w600,
                      color: branco,
                      fontFamily: 'Amaranth',
                      decoration: TextDecoration.none,
                      height: 1,
                    ),
                  ),
                ),
                // Seção de interesses
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                  ),
                  child: CustomTextField(
                    controller: nicknameController,
                    label: 'Nome de usuário',
                    inputType: TextInputType.visiblePassword,
                    isobscure: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                  ),
                  child: CustomTextField(
                    controller: bioController,
                    label: 'Bio',
                    inputType: TextInputType.visiblePassword,
                    isobscure: true,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.14,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () => _updateUser(context),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.31,
                              vertical: screenHeight * 0.012),
                          backgroundColor: branco,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: branco, width: 4),
                          ),
                        ),
                        child: Text(
                          "Continuar",
                          style: TextStyle(
                            color: preto,
                            fontFamily: "Amaranth",
                            fontSize: screenWidth * 0.06,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Positioned(
              top: screenHeight * 0.06,
              left: screenWidth * 0.04,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/voltarbtn.png',
                    fit: BoxFit.fitWidth,
                    width: screenWidth * 0.1,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
