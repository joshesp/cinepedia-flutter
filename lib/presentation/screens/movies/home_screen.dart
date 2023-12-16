import 'package:flutter/material.dart';

import '../../views/views.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = "homeScreen";
  final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  final List<Widget> viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: pageIndex,
      ),
    );
  }
}
