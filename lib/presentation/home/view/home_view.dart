import 'package:flutter/material.dart';
import 'package:flutter_caching/core.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  Widget build(context, HomeController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Developer Test"),
        bottom: TabBar(
          labelStyle: const TextStyle(
            fontSize: 12,
          ),
          controller: controller.tabController,
          tabs: const [
            Tab(text: "Question 1"),
            Tab(text: "Question 2"),
            Tab(text: "Question 3"),
            Tab(text: "Offline Caching"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          FetchListView(),
          FormView(),
          CounterView(),
          ModeOfflineView()
        ],
      ),
    );
  }

  @override
  State<HomeView> createState() => HomeController();
}
