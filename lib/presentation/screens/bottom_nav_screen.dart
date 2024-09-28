import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotels_booking/presentation/router/app_router.dart';

@RoutePage()
class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        OverviewRoute(),
        HotelsRoute(),
        FavoritesRoute(),
        AccountRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ' Overview'),
            BottomNavigationBarItem(icon: Icon(Icons.hotel), label: ' Hotels'),
            BottomNavigationBarItem(
                icon: Icon(key: Key('nav_fav'), Icons.favorite),
                label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        );
      },
    );
  }
}
