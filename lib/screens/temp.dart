import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sdk/model/User.dart';

class Temp extends StatefulWidget {
  final User user;
  const Temp({super.key, required this.user});

  @override
  _TempPage createState() => _TempPage(user: user);

}

class _TempPage extends State<Temp> {
  final User user;
   _TempPage({required this.user});

  @override
  Widget build(BuildContext context) {
    print(user.email);
    throw UnimplementedError();
  }
}