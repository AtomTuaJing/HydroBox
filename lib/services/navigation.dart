import 'package:flutter/material.dart';
import 'package:hydrobox/pages/account_page.dart';
import 'package:hydrobox/pages/home_page.dart';
import 'package:hydrobox/utils/color_asset.dart';

class Navigation extends StatefulWidget {
  final bool connectionState;
  const Navigation({super.key, required this.connectionState});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // init tabs and current index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      widget.connectionState
          ? const HomePage(connectionState: true)
          : const HomePage(connectionState: false),
      AccountPage()
    ];
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (int Value) {
          setState(() {
            currentIndex = Value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/potted_plant.png",
                  width: 35,
                  color:
                      currentIndex == 0 ? ColorsAsset.primary : Colors.black),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined,
                  size: 35,
                  color:
                      currentIndex == 1 ? ColorsAsset.primary : Colors.black),
              label: "Account"),
        ],
      ),
    );
  }
}
