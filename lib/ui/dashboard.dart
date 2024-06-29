import 'package:currency_converter/ui/exchange.dart';
import 'package:currency_converter/ui/home.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  Widget getView(){
    if(_selectedIndex == 0){
      return const Home();
    }else{
      return const Exchange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Currency Converter', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: getView(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Exchange',
          ),
        ],
      ),
    );
  }
}
