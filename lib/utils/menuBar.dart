import 'package:addaproject/sdk/model/User.dart';

import '../screens/home.dart';
import '../screens/othersprofile.dart';
import '../screens/profile.dart';
import '../screens/searchingstations.dart';
import 'package:flutter/material.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);

class MenuBarGeneral extends StatefulWidget {
  final int initialIndex; // Novo parâmetro para o índice inicial
  final User? user;

  const MenuBarGeneral({super.key, this.initialIndex = 0, required this.user}); // Definindo um valor padrão

  @override
  MenuBar createState() => MenuBar();
}

class MenuBar extends State<MenuBarGeneral> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Define o índice inicial com base no parâmetro passado
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Lista de telas
  static final List<Widget> _pages = <Widget>[
    const Home(),
    const Placeholder(),
    const OthersProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: preto,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              iconSize: 30.0,
              icon: Icon(
                _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                color: branco,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            const SizedBox(width: 40),
            IconButton(
              iconSize: 30.0,
              icon: Icon(
                _selectedIndex == 2 ? Icons.person : Icons.person_outline,
                color: branco,
              ),
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
          backgroundColor: preto,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SearchingStations()),
            );
          },
          shape: const CircleBorder(
            side: BorderSide(color: branco, width: 2), // Borda fina
          ),
          elevation: 5.0,
          child: const Text(
            "+",
            style: TextStyle(
              color: branco,
              fontSize: 50,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
