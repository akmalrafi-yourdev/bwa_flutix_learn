part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  // TODO: implement props
  List<Object> get props => [name];
}

List<Theater> dummyTheaters = [
  Theater("CGV Botani Square"),
  Theater("XXI Cibubur Junction"),
  Theater("Cinema Movie Cibinong"),
  Theater("Akmal Grand Theater"),
];
