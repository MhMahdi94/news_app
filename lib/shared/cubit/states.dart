abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppGetBusinessNewsLoading extends AppStates {}

class AppGetBusinessNewsSuccess extends AppStates {}

class AppGetBusinessNewsFailure extends AppStates {
  final String error;

  AppGetBusinessNewsFailure(this.error);
}

class AppGetSportsNewsLoading extends AppStates {}

class AppGetSportsNewsSuccess extends AppStates {}

class AppGetSportsNewsFailure extends AppStates {
  final String error;

  AppGetSportsNewsFailure(this.error);
}

class AppGetScienceNewsLoading extends AppStates {}

class AppGetScienceNewsSuccess extends AppStates {}

class AppGetScienceNewsFailure extends AppStates {
  final String error;

  AppGetScienceNewsFailure(this.error);
}

class AppGetSearchNewsLoading extends AppStates {}

class AppGetSearchNewsSuccess extends AppStates {}

class AppGetSearchNewsFailure extends AppStates {
  final String error;

  AppGetSearchNewsFailure(this.error);
}
