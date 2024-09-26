import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels_booking/application/hotel_cubit.dart';
import 'package:hotels_booking/presentation/app_theme.dart';
import 'package:hotels_booking/presentation/router/app_router.dart';

import 'injection.dart';

void main() {
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<HotelCubit>()..fetchHotels(),
        )
      ],
      child: MaterialApp.router(
        title: 'Hotels booking',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        routerDelegate: getIt<HotelAppRouter>().delegate(),
        routeInformationParser: getIt<HotelAppRouter>().defaultRouteParser(),
      ),
    );
  }
}
