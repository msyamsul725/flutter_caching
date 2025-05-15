import 'package:flutter/material.dart';
import 'package:flutter_caching/core.dart';

class HomeController extends State<HomeView>
    with SingleTickerProviderStateMixin {
  static late HomeController instance;
  late HomeView view;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
