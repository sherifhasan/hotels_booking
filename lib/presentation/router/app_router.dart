import 'package:auto_route/auto_route.dart';
import 'package:hotels_booking/presentation/screens/bottom_nav_screen.dart';
import 'package:hotels_booking/presentation/screens/favourites_screen.dart';
import 'package:hotels_booking/presentation/screens/home_screen.dart';
import 'package:hotels_booking/presentation/screens/profile_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class HotelAppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            path: '/',
            page: BottomNavRoute.page,
            initial: true,
            children: [
              AutoRoute(page: HomeRoute.page, path: 'home'),
              AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
              AutoRoute(page: ProfileRoute.page, path: 'profile'),
            ]),
      ];
}
