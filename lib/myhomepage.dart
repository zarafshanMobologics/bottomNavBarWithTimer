import 'dart:developer';
import 'package:bottomnavbar_app/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  final List<Widget> bottomBarScreens = const [
    Center(child: Text('Home Screen')),
    Center(child: Text('Search Screen')),
    Center(child: Text('Bookmarks Screen')),
    Center(child: Text('Settings Screen')),
  ];

  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Nav Bar Demo'),
      ),
      body: Obx(() {
        // final controller = Get.find<BottomNavigationController>();
        return bottomBarScreens[controller.pageIndex];
      }), // Default to Home Screen
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: controller.pageIndex,
          onTap: (index) {
            log('init start');
            controller.changePageTab(index);
          },
          items: controller.meet
              ? const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark),
                    label: 'Bookmarks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ]
              : const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark),
                    label: 'Bookmarks',
                  ),
                ],
        );
      }),
    );
  }
}
