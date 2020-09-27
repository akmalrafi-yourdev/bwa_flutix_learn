part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovie(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    client ??= http.Client();

    var response = await http.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = jsonDecode(response.body);
    List result = data['results']; // ['results'] berasal dari API

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();

    var response = await http.get(url);
    var data = jsonDecode(response.body);

    List genres = (data as Map<String, dynamic>)['genres'];
    String language;

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'en':
        language = "English";
        break;
      case 'jp':
        language = "Japanese";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
      // default:
      //   return "";
    }

    return movieID != null
        ? MovieDetail(
            Movie.fromJson(data),
            language: language,
            genres: genres
                .map(
                  (e) => (e as Map<String, dynamic>)['name'].toString(),
                )
                .toList(),
          )
        : MovieDetail(
            movie,
            language: language,
            genres: genres
                .map(
                  (e) => (e as Map<String, dynamic>)['name'].toString(),
                )
                .toList(),
          );
  }

  static Future<List<Credit>> getCredit(int movieId,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey";

    client ??= http.Client();

    var response = await http.get(url);
    var data = jsonDecode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path']))
        .toList();
    // .take(int) untuk mengambil batas cast nya, kalau perlu :D
  }
}
