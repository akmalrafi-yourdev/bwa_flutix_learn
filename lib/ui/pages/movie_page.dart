part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 28),
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              if (userState is UserLoaded) {
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload).then((downloadUrl) {
                    imageFileToUpload = null;
                    context
                        .bloc<UserBloc>()
                        .add(UpdateData(profileImage: downloadUrl));
                  });
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Stack(
                        children: [
                          SpinKitFadingCircle(
                            color: accentColor2,
                            size: 48,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToProfilePage());
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (userState.user.profilePicture == "")
                                      ? AssetImage("assets/user_pic.png")
                                      : NetworkImage(
                                          userState.user.profilePicture),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin -
                              82,
                          child: Text(
                            userState.user.name,
                            style: whiteTextFont.copyWith(
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: "id_ID",
                            decimalDigits: 0,
                            symbol: "IDR ",
                          ).format(userState.user.balance),
                          style: yellowNumberFont,
                        )
                      ],
                    )
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  color: accentColor2,
                );
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Text(
            "Now Playing",
            style: blackTextFont.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          height: 212,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, state) {
              if (state is MovieLoaded) {
                List<Movie> movies = state.moviess.sublist(0, 10);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index == movies.length - 1) ? defaultMargin : 12,
                    ),
                    child: MovieCard(
                      movies[index],
                      onTap: () {
                        context.bloc<PageBloc>().add(
                              GoToMovieDetailsPage(movies[index]),
                            );
                      },
                    ),
                  ),
                );
              } else {
                return SpinKitChasingDots(
                  color: mainColor,
                  size: 24,
                );
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Text(
            "Browse Movies",
            style: blackTextFont.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoaded) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    userState.user.selectedGenres.length,
                    (index) => BrowseButton(
                      genre: userState.user.selectedGenres[index],
                    ),
                  ),
                ),
              );
            } else {
              return SpinKitCubeGrid(
                color: mainColor,
                size: 24,
              );
            }
          },
        ),
        Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Text(
            "Coming Soon!",
            style: blackTextFont.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          height: 212,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, state) {
              if (state is MovieLoaded) {
                List<Movie> movies = state.moviess.sublist(10, 20);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index == movies.length - 1) ? defaultMargin : 12,
                    ),
                    child: ComingSoonCard(
                      movies[index],
                    ),
                  ),
                );
              } else {
                return SpinKitChasingDots(
                  color: mainColor,
                  size: 24,
                );
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Text(
            "What a Lucky Day!",
            style: blackTextFont.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          child: Column(
            // todo : promo card
            children: dummyPromos
                .map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(
                          defaultMargin, 0, defaultMargin, 16),
                      child: PromoCard(e),
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: 108,
        )
      ],
    );
  }
}
