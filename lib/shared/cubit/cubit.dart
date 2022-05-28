// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sport_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  void changeBottomTab(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      getSportNews();
    }

    if (currentIndex == 2) {
      getScienceNews();
    }
    emit(AppChangeBottomNavState());
  }

  List<dynamic> businessNews = [];
  List<dynamic> sportNews = [];
  List<dynamic> scienceNews = [];
  List<dynamic> search = [];
  void getBusinessNews() {
    emit(AppGetBusinessNewsLoading());
    if (scienceNews.isEmpty) {
      DioHelper.getData(
        path: 'v2/top-headlines',
        query: {
          //country=us&category=business&apiKey=API_KEY
          'country': 'us',
          'category': 'business',
          'apiKey': '4d07a9c95a00428fa2c70d9cd34a6f15',
        },
      ).then((value) {
        emit(AppGetBusinessNewsSuccess());
        businessNews = value!.data['articles'];
        //print(businessNews);
      }).catchError((error) {
        emit(AppGetBusinessNewsFailure(error.toString()));
      });
    } else {
      emit(AppGetBusinessNewsSuccess());
    }
  }

  void getSportNews() {
    emit(AppGetSportsNewsLoading());
    if (scienceNews.isEmpty) {
      DioHelper.getData(
        path: 'v2/top-headlines',
        query: {
          //country=us&category=business&apiKey=API_KEY
          'country': 'us',
          'category': 'sports',
          'apiKey': '4d07a9c95a00428fa2c70d9cd34a6f15',
        },
      ).then((value) {
        emit(AppGetSportsNewsSuccess());
        sportNews = value!.data['articles'];
        //print(businessNews);
      }).catchError((error) {
        emit(AppGetSportsNewsFailure(error.toString()));
      });
    } else {
      emit(AppGetSportsNewsSuccess());
    }
  }

  void getScienceNews() {
    emit(AppGetScienceNewsLoading());
    if (scienceNews.isEmpty) {
      DioHelper.getData(
        path: 'v2/top-headlines',
        query: {
          //country=us&category=business&apiKey=API_KEY
          'country': 'us',
          'category': 'science',
          'apiKey': '4d07a9c95a00428fa2c70d9cd34a6f15',
        },
      ).then((value) {
        emit(AppGetScienceNewsSuccess());
        scienceNews = value!.data['articles'];
        //print(businessNews);
      }).catchError((error) {
        emit(AppGetScienceNewsFailure(error.toString()));
      });
    } else {
      emit(AppGetScienceNewsSuccess());
    }
  }

  void getSearchData(String query) {
    emit(AppGetScienceNewsLoading());
    search = [];
    if (search.isEmpty) {
      DioHelper.getData(
        path: 'v2/everything',
        query: {
          'q': query,
          'apiKey': '4d07a9c95a00428fa2c70d9cd34a6f15',
        },
      ).then((value) {
        emit(AppGetSearchNewsSuccess());
        search = value!.data['articles'];
        //print(businessNews);
      }).catchError((error) {
        emit(AppGetSearchNewsFailure(error.toString()));
      });
    } else {
      emit(AppGetSearchNewsSuccess());
    }
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      print('put $isDark');
      CacheHelper.putBoolean(key: 'isDark', value: isDark)
          .then((value) => emit(AppChangeModeState()));
    }
  }
}
