import 'package:addaproject/screens/editstationadm.dart';

import '../screens/profile.dart';
import 'package:addaproject/sdk/LocalCache.dart';
import 'package:flutter/material.dart';
import '../utils/interestshow.dart';
import '../sdk/model/User.dart';
import '../utils/userprofilecard.dart';
import '../sdk/model/Channel.dart';
import '../screens/othersprofile.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color pretobg = Color(0xFF242424);

class GroupInfo extends StatelessWidget {
  final List<UserChannel> groupMembers;
  final Channel channel;
  final User user;

  const GroupInfo({
    super.key,
    required this.groupMembers,
    required this.channel,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Others profile page',
      home: GroupInfoPage(
        groupMembers: groupMembers,
        channel: channel,
        user: user,
      ),
    );
  }
}

class GroupInfoPage extends StatelessWidget {
  final List<UserChannel> groupMembers;
  final User? user;
  final Channel channel;

  GroupInfoPage({
    required this.groupMembers,
    this.user,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isAdmin = true;

    return Scaffold(
      backgroundColor: pretobg,
      body: Stack(
        children: [
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
                                  'assets/target.png',
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${channel.name}",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.075,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (isAdmin)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.02,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditStationAdmPage(
                                      channelId: channel.id,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.167,
                                  vertical: screenHeight * 0.012,
                                ),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side:
                                      const BorderSide(color: branco, width: 2),
                                ),
                              ),
                              child: Text(
                                "Personalizar estação",
                                style: TextStyle(
                                  color: branco,
                                  fontFamily: "Amaranth",
                                  fontSize: screenWidth * 0.06,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.02,
                  ),
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
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            18,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ShowInterest(
                                text: "Interesse $index",
                                imagePath: 'assets/transparenttarget.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.064,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Integrantes",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: groupMembers.map((user) {
                          int index = groupMembers.indexOf(user);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () async {
                                final LocalCache _localCache = LocalCache();
                                final userSession =
                                    await _localCache.getUserSession();
                                if (userSession?.id == user.id) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePage(user: userSession!),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePage(user: userSession!),
                                    ),
                                  );
                                }
                              },
                              child: UserProfileCard(
                                imagePath: 'assets/default_pfp.png',
                                name: '${user.firstName} ${user.lastName}',
                                username: user.nickname,
                                isAdmin: index % 2 == 0,
                              ),
                            ),
                          );
                        }).toList(),
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
