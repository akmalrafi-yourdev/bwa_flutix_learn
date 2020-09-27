part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  // const ThemeState();

  final ThemeData themeData;

  const ThemeState(this.themeData);

  @override
  List<Object> get props => [themeData];
}

// class ThemeInitial extends ThemeState {}
