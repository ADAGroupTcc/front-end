import 'package:addaproject/screens/welcomescreen.dart';
import 'package:addaproject/sdk/model/Categoria.dart';
import 'package:addaproject/sdk/model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../sdk/LocalCache.dart';
import '../utils/backgroundwidget.dart';
import '../utils/customtogglebutton.dart';
import 'package:addaproject/sdk/AddaSDK.dart';

import '../utils/menuBar.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class Interests extends StatelessWidget {
  UserCreate user;
  Interests({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interests page',
      home: InterestsPage(user: user),
    );
  }
}

class InterestsPage extends StatelessWidget {
  final UserCreate user;
  final addaSdk = AddaSDK();
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final Location location = Location();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LocationData? _userLocation;
  final _cache = LocalCache();

  InterestsPage({super.key, required this.user});

  Future<void> _createUser(BuildContext context) async {
    try {
      final selectedCategories = SelectedCategories.selectedCategories;
      if (selectedCategories.length <= 3) {
        throw Exception("Selecione pelo menos três categorias");
      }

      user.categories = selectedCategories;
      if(_userLocation != null) {
        user.location = [_userLocation!.latitude, _userLocation!.longitude];
      }else {
        user.location = [0, 0];
      }

      final createdUser = await AddaSDK().createUser(
        user,
      );

      if(createdUser == null) {
        throw Exception("create user retornou null");
      }

      SelectedCategories.selectedCategories = [];
      SelectedCategories.allCategories = [];
      final authUser = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await _firebaseDatabase
          .ref()
          .child('users/${authUser.user!.uid}')
          .set({'user_id': createdUser.id});

      await _cache.saveUserSession(createdUser);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuBarGeneral(user: createdUser)),
      );
    } catch (e) {
      print("Error creating user: $e");
    }
  }

  void setLocation() async {
    _userLocation = await addaSdk.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    setLocation();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const BackgroundWidget(imagePath: 'assets/profilebackground.png'),

        // Título fixo no topo
        Positioned(
          top: screenHeight * 0.12, // Ajuste conforme necessário
          left: screenWidth * 0.064,
          right: screenWidth * 0.064,
          child: Text(
            "Selecione seus interesses",
            textAlign: TextAlign.center,
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

        // Conteúdo central com rolagem se necessário
        Positioned.fill(
          top: screenHeight * 0.25, // Para evitar sobreposição com o título
          bottom: screenHeight * 0.2, // Para evitar sobreposição com o botão
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: FutureBuilder<CategoriesResponse>(
              future: addaSdk
                  .listCategories(), // Chamando a função da instância addaSdk
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar categorias'));
                } else if (!snapshot.hasData || snapshot.data!.categories.isEmpty) {
                  return Center(child: Text('Nenhuma categoria encontrada'));
                } else {
                  final categories = snapshot.data!.categories;
                  SelectedCategories.allCategories.addAll(categories);
                  return SingleChildScrollView(
                    child: Wrap(
                      spacing: 20.0, // Espaço horizontal entre os itens
                      runSpacing: 15.0, // Espaço vertical entre as linhas
                      children: List.generate(
                        categories.length,
                        (index) {
                          return CustomToggleButton(
                            index: index, // Usando as categorias obtidas
                            imagePath: 'assets/transparenttarget.png',
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),

        // Botão "Criar Conta!" fixo na parte inferior
        Positioned(
          bottom: screenHeight * 0.1, // Ajuste conforme necessário
          left: screenWidth * 0.064,
          right: screenWidth * 0.064,
          child: ElevatedButton(
            onPressed: () {
              _createUser(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.276,
                  vertical: screenHeight * 0.012),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: branco, width: 2),
              ),
            ),
            child: IgnorePointer(
                child: RichText(
              text: TextSpan(
                  text: "Criar Conta!",
                  style: TextStyle(
                    color: branco,
                    fontFamily: "Amaranth",
                    fontSize: screenWidth * 0.06,
                  )),
            )),
          ),
        ),

        // Botão de "Voltar" fixo
        Positioned(
          bottom: screenHeight * 0.023,
          left: screenWidth * 0.04,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
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
