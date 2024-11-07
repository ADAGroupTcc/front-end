import 'package:addaproject/screens/editprofile.dart';
import 'package:addaproject/sdk/model/User.dart';
import 'package:flutter/material.dart';
import '../sdk/LocalCache.dart';
import '../utils/customtogglebutton.dart';
import '../screens/profilepersonalization.dart';
import '../sdk/AddaSDK.dart';
import '../utils/interestshow.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF171717);

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile page',
      home: ProfilePage(user: user),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final LocalCache _localCache = LocalCache();
    final userSession = await _localCache.getUserSession();
    if (userSession != null) {
      final AddaSDK sdk = AddaSDK();
      final User? user = await sdk.getUserByID(userSession.id);
      setState(() {
        _user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: pretobg,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/blackwave.png',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.064, top: screenHeight * 0.12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: screenWidth * 0.27,
                      height: screenWidth * 0.27,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: pretobg, width: 5.0),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/default_pfp.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.064,
                  vertical: screenHeight * 0.015),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "@${_user?.nickname}",
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
                    "${_user?.firstName} ${_user?.lastName}",
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
                    "${_user?.description?.isNotEmpty == true ? _user!.description : 'Olá, vamos nos conhecer no Adda!'}",
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
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.2,
                          vertical: screenHeight * 0.012),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: branco, width: 2),
                      ),
                    ),
                    child: Text(
                      "Personalizar perfil",
                      style: TextStyle(
                        color: branco,
                        fontFamily: "Amaranth",
                        fontSize: screenWidth * 0.055,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
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
                  SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          14,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ShowInterest(
                                text: "Interesse $index",
                                imagePath: 'assets/transparenttarget.png',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
