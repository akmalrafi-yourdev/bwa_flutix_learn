part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double starSizes;
  final double fontSize;
  final Color color;
  final MainAxisAlignment axisAlignment;

  RatingStars({
    this.voteAverage,
    this.starSizes,
    this.fontSize,
    this.color,
    this.axisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage ~/ 2)
        .round(); // round() berguna untuk membulatkan bilangan

    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        (index < n) ? Icons.star : Icons.star_border,
        color: accentColor2,
        size: starSizes,
      ),
    );

    widgets.add(
      SizedBox(
        width: 4,
      ),
    );

    widgets.add(Text(
      "$voteAverage",
      style: whiteTextFont.copyWith(
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
      ),
    ));

    return Row(
      mainAxisAlignment: axisAlignment,
      children: widgets,
    );
  }
}
