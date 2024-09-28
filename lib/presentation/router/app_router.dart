import 'package:auto_route/auto_route.dart';
import 'package:hotels_booking/presentation/screens/screens.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class HotelAppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Main Bottom Navigation Route
        AutoRoute(
          path: '/dashboard',
          page: BottomNavRoute.page,
          initial: true,
          children: [
            AutoRoute(page: OverviewRoute.page, path: 'overview'),
            AutoRoute(page: HotelsRoute.page, path: 'hotels'),
            AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
            AutoRoute(page: AccountRoute.page, path: 'account'),
          ],
        ),
      ];
}
