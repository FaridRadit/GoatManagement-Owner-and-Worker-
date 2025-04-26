import 'package:flutter/material.dart';
import 'package:mitrakambing2/pages/addmitrapage.dart';
import 'package:mitrakambing2/pages/listmitrapage.dart';
// New page for Kambing
import 'package:mitrakambing2/pages/help.dart';
import 'package:mitrakambing2/pages/table.dart'; // Only this import is needed

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ListMitraPage(),
    MitraKambingTable(), // New Page for Mitra and Kambing table
    Help(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mitra Kambing"),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List Mitra',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'Mitra & Kambing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
        ],
      ),
    );
  }
}
