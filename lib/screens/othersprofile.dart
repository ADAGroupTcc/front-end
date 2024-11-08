import 'package:addaproject/sdk/model/Channel.dart';
import 'package:flutter/material.dart';
import '../sdk/model/User.dart';
import '../utils/customtogglebutton.dart';
import '../utils/interestshow.dart';
import '../utils/station.dart';
import '../sdk/AddaSDK.dart';
import '../sdk/model/Categoria.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF171717);

class OthersProfile extends StatelessWidget {
  final UserChannel? user;

  OthersProfile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Others profile page',
      home: OthersProfilePage(user: user!),
    );
  }
}

class OthersProfilePage extends StatefulWidget {
  final UserChannel user;

  const OthersProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _OthersProfilePageState createState() => _OthersProfilePageState();
}

class _OthersProfilePageState extends State<OthersProfilePage> {
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
                        const SizedBox(height: 120),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.064),
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
                                  'assets/default_pfp.png',
                                  fit: BoxFit.cover,
                                  width: screenWidth * 0.26,
                                  height: screenWidth * 0.26,
                                ),
                              ),
                            ),
                          ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "@${widget.user.nickname}",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.023),
                      Text(
                        '${widget.user.firstName} ${widget.user.lastName}',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Inter',
                          color: branco,
                          fontStyle: FontStyle.italic,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        widget.user.description == ""
                            ? "Olá, vamos nos conhecer no Adda!"
                            : "${widget.user.description}", //case user description == " " then show this sentence
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.047,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Inter',
                          color: branco,
                          fontStyle: FontStyle.italic,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                // Seção de interesses
                const SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.064,
                      vertical: screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Interesses",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.023),
                      FutureBuilder(
                        future: AddaSDK().listCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final categoriesResponse = snapshot.data;
                            if (categoriesResponse != null) {
                              List<Categoria> categories =
                                  categoriesResponse.categories;
                              return SizedBox(
                                height: screenHeight * 0.06,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    widget.user.categories.length,
                                    (index) {
                                      Categoria? category =
                                          categories.firstWhere(
                                        (c) =>
                                            c.id ==
                                            widget.user.categories[index],
                                      );
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: ShowInterest(
                                          text: category?.name ?? '',
                                          imagePath:
                                              'assets/transparenttarget.png',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return Text('No categories found');
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.0465,
            left: screenWidth * 0.0465,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
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
        ],
      ),
    );
  }
}
