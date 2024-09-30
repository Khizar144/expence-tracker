import 'package:expencetracker/constants/app_colors.dart';
import 'package:expencetracker/screens/add_expence.dart';
import 'package:expencetracker/screens/dashboard.dart';
import 'package:expencetracker/screens/detail_sceen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Variable to track the selected tab index

  final List<Widget> _pages = [
    Dashboard(),
    DetailScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.basicColor,
      ),
      body: _pages[_selectedIndex], // Display the selected page
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddExpence());
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.add, size: 30, color: Colors.white),
          ),
        ),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       
    );
  }
}
