import 'package:flutter/material.dart';
import '../utils/customtextfield.dart';
import '../sdk/AddaSDK.dart';

const Color preto = Color(0xFF0D0D0D);
const Color branco = Color(0xFFFFFAFE);
const Color cinzar = Color(0x4dfffafe);
const Color pretobg = Color(0xFF242424);

class EditStationAdm extends StatefulWidget {
  const EditStationAdm({super.key});

  @override
  State<EditStationAdm> createState() => _EditStationAdmState();
}

class _EditStationAdmState extends State<EditStationAdm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit profile page',
      home: EditStationAdmPage(
        channelId: ModalRoute.of(context)!.settings.arguments as String,
      ),
    );
  }
}

class EditStationAdmPage extends StatefulWidget {
  final String channelId;

  const EditStationAdmPage({
    super.key,
    required this.channelId, // Add this line
  });

  @override
  State<EditStationAdmPage> createState() => _EditStationAdmPageState();
}

class _EditStationAdmPageState extends State<EditStationAdmPage> {
  final TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  'assets/fullblackwave.png',
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
                                    image: AssetImage('assets/target.png'),
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
                  controller: _groupNameController,
                  label: 'Nome do grupo',
                  inputType: TextInputType.emailAddress,
                  isobscure: false,
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
                    child: 
                   ElevatedButton(
                      onPressed: () async {
                        final newChannelName = _groupNameController.text;
                        final channelId = widget.channelId; // Get the channel ID from the widget
                        final updates = {'name': newChannelName}; // Create a map with the new channel name
                        
                        final AddaSDK _addaSDK = AddaSDK(); // Initialize the AddaSDK instance
                        final updatedChannel = await _addaSDK.updateChannelByID(channelId, updates); // Call the updateChannelByID function
                        
                        if (updatedChannel != null) {
                          // Channel updated successfully
                          print('Channel updated successfully');
                        } else {
                          // Error updating channel
                          print('Error updating channel');
                        }
                      },
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
