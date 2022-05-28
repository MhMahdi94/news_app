// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/home_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/constants/colors.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() {
  bool isDark;
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      isDark = CacheHelper.getBoolean(key: 'isDark')!;
      print('get $isDark');
      runApp(MyApp(
        isDark,
      ));
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(fromShared: isDark)
            ..getBusinessNews(),
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              AppCubit cubit = AppCubit.get(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: Colors.deepOrange,
                  // ignore: prefer_const_constructors
                  appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    elevation: 10,
                    selectedItemColor: Colors.deepOrange,
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: darkColor,
                  appBarTheme: AppBarTheme(
                    backgroundColor: darkColor,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: darkColor,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    elevation: 0,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: darkColor,
                    unselectedItemColor: Colors.grey,
                    elevation: 10,
                    selectedItemColor: Colors.deepOrange,
                  ),
                  textTheme: TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
                home: child,
              );
            },
          ),
        );
      },
      child: HomeLayout(),
      // child: Directionality(
      //   textDirection: TextDirection.rtl,
      //   child: HomeLayout(),
      // ),
    );
  }
}
