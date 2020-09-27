part of 'pages.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  MovieDetailsPage(this.movie);

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());

        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: MovieServices.getDetails(
              movie), // berasal dari movie, si sumber datanya
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              movieDetail = snapshot.data;
              return FutureBuilder(
                future: MovieServices.getCredit(movie.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    credits = snapshot.data;
                    return Stack(
                      children: [
                        Container(
                          color: mainColor,
                        ),
                        SafeArea(
                          child: Container(
                            color: Colors.white,
                            child: ListView(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 280,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(imageBaseUrl +
                                                  "w780" +
                                                  movie.backdropPath),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 280,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Colors.white.withOpacity(0),
                                              ],
                                              begin: Alignment(0, 0.95),
                                              end: Alignment(0, 0.10),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 16, bottom: 6),
                                      child: Text(
                                        movieDetail.title,
                                        style: blackTextFont.copyWith(
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(movieDetail.genresAndLanguage),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RatingStars(
                                          fontSize: 12,
                                          starSizes: 24,
                                          voteAverage: movieDetail.voteAverage,
                                          axisAlignment:
                                              MainAxisAlignment.center,
                                        ),
                                        Text(
                                            movieDetail.voteAverage.toString()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: defaultMargin),
                                      child: Text(
                                        "Cast & Crews",
                                        style: blackTextFont.copyWith(
                                            fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: credits.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                              left: (index == 0)
                                                  ? defaultMargin
                                                  : 0,
                                              right:
                                                  (index == credits.length - 1)
                                                      ? defaultMargin
                                                      : 16,
                                            ),
                                            child: CreditCard(
                                              credits[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: defaultMargin),
                                      child: Text(
                                        "Storyline",
                                        style: blackTextFont.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: defaultMargin),
                                      child: Text(
                                        movieDetail.overview,
                                        style: blackTextFont,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Container(
                                      width: 250,
                                      height: 45,
                                      child: RaisedButton(
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        onPressed: () {
                                          context.bloc<PageBloc>().add(
                                              GoToSelectSchedulePage(
                                                  movieDetail));
                                        },
                                        child: Text(
                                          "Continue to Book",
                                          style: whiteTextFont,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 32,
                            bottom: 22,
                            left: defaultMargin,
                          ),
                          height: 56,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .bloc<PageBloc>()
                                        .add(GoToMainPage());
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: SpinKitCubeGrid(
                        color: mainColor,
                        size: 36,
                      ),
                    );
                  }
                },
              );
            } else {
              return Center(
                child: SpinKitCubeGrid(
                  color: mainColor,
                  size: 36,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
