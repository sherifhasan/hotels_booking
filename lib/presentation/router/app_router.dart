import 'package:auto_route/auto_route.dart';
import 'package:hotels_booking/presentation/screens/screens.dart';

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
              AutoRoute(page: OverviewRoute.page, path: 'overview'),
              AutoRoute(page: HotelsRoute.page, path: 'hotels'),
              AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
              AutoRoute(page: AccountRoute.page, path: 'account'),
            ]),
      ];
}
