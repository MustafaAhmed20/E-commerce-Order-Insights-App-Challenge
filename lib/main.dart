import 'package:flutter/material.dart';

//
import 'package:flapkap/navigator_settings.dart';

//
import 'package:flapkap/viwes/constants/constants.dart';
import 'package:flapkap/viwes/home.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// data
import 'package:flapkap/data/data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp(
          title: 'Orders Challenge',
          debugShowCheckedModeBanner: false,
          navigatorKey: AppNavigationHandler.appNavigatorKey,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              primary: AppColors.primary,
              seedColor: AppColors.primary,
              secondary: AppColors.primary,
            ),
            cardColor: AppColors.primary,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(AppColors.primary),
                // backgroundColor: WidgetStateProperty.all(Colors.green),
                fixedSize: WidgetStateProperty.all(Size(340.w, 50.h)),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                iconColor: WidgetStateProperty.all(AppColors.white),
                textStyle: WidgetStateProperty.all(
                  AppFontsFamilies.cairoTextStyle.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            useMaterial3: true,
            textTheme: AppFontsFamilies.defaultTheme,
          ),
          home: HomePage(),
        );
      },
    );
  }
}
