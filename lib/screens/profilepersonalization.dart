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

class ProfilePersonalization extends StatelessWidget {
  const ProfilePersonalization({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Profile personalization page',
      home: ProfilePersonalizationPage(),
    );
  }
}

class ProfilePersonalizationPage extends StatelessWidget {
  const ProfilePersonalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
        final User? updatedUser =
            await AddaSDK().updateUserByID(user.id, updates);

        if (updatedUser != null) {
          await LocalCache().saveUserSession(updatedUser);
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
        } else {
          await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Erro ao atualizar"),
                  content:
                      const Text("Ocorreu um erro ao atualizar seu perfil."),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              });
        }
      } catch (e) {
        print("Erro ao atualizar usuário: $e");
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const BackgroundWidget(imagePath: 'assets/profilebackground.png'),
        Align(
          alignment: Alignment.topCenter,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/blackwavetwo.png',
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.064),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'assets/personalizeprofile.png',
                            fit: BoxFit.fitWidth,
                            width: screenWidth * 0.26,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.064),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'assets/personalizeprofile.png',
                            fit: BoxFit.fitWidth,
                            width: screenWidth * 0.12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 180),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.02),
                child: Text(
                  "Personalize seu perfil!",
                  style: TextStyle(
                    fontSize: screenWidth * 0.107,
                    fontWeight: FontWeight.w600,
                    color: branco,
                    fontFamily: 'Amaranth',
                    decoration: TextDecoration.none,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomTextField(
                controller: nicknameController,
                label: 'Nickname',
                inputType: TextInputType.text,
                isobscure: false,
              ),
              CustomTextField(
                controller: bioController,
                label: 'Descrição',
                inputType: TextInputType.text,
                isobscure: false,
              ),
              const SizedBox(height: 45),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.17, bottom: screenHeight * 0.01),
                child: ElevatedButton(
                  onPressed: () => _updateUser(context),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.303,
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
              ),
            ],
          ),
        ),
        Positioned(
          bottom: screenHeight * 0.023,
          left: screenWidth * 0.04,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/voltarbtn.png',
                fit: BoxFit.fitWidth,
                width: screenWidth * 0.1,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
