part of 'models.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final String posterPath;
  final String backdropPath;

  Movie({
    @required this.id,
    @required this.title,
    @required this.voteAverage,
    @required this.overview,
    @required this.posterPath,
    @required this.backdropPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        title: json['title'],
        voteAverage: (json['vote_average'] as num)
            .toDouble(), // kembalian dari api kadang int atau double, harus di cast seperti ini
        overview: json['overview'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
      );

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        title,
        voteAverage,
        overview,
        posterPath,
        backdropPath,
      ];
}
