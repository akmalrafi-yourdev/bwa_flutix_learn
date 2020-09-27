part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;

  ComingSoonCard(this.movie, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 212,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageBaseUrl + "w780" + movie.backdropPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: 128,
        height: 212,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0),
            ],
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  movie.title,
                  style: whiteTextFont.copyWith(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              // RatingStars(
              //   voteAverage: movie.voteAverage,
              //   starSizes: 10,
              //   fontSize: 12,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
