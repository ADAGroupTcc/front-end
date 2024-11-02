import 'package:flutter/material.dart';
import '../utils/customtextfield.dart';

const Color preto = Color(0xFF0D0D0D);
const Color branco = Color(0xFFFFFAFE);
const Color cinzar = Color(0x4dfffafe);
const Color pretobg = Color(0xFF171717);

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Edit profile page',
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _bioController = TextEditingController();

    return Scaffold(
        backgroundColor: pretobg,
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/bglanita.png',
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10000)),
                                  image: DecorationImage(
                                    image: AssetImage('assets/lanita.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Opacity(
                                    opacity: 1.0,
                                    child: Image.asset(
                                      'assets/personalizeprofile.png',
                                      fit: BoxFit.fitWidth,
                                      width: screenWidth * 0.26,
                                    ),
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
          ),
          Padding(
            padding: EdgeInsets.only(top: 300),
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: 'Nome do usuário',
                  inputType: TextInputType.emailAddress,
                  isobscure: false,
                ),
                CustomTextField(
                  controller: _bioController,
                  label: 'Bio',
                  inputType: TextInputType.visiblePassword,
                  isobscure: true,
                ),
              ],
            ),
          ),
          Positioned(
              top: screenHeight * 0.0465,
              left: screenWidth * 0.0465,
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
          Positioned(
            bottom: screenHeight * 0.0465,
            left: 0,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.064,
                  vertical: screenHeight * 0.02,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.217,
                            vertical: screenHeight * 0.012),
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
                    ))),
          )
        ]));
  }
}
