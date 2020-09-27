part of 'widgets.dart';

class CreditCard extends StatelessWidget {
  final Credit credit;

  CreditCard(this.credit);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            image: (credit.profilePath == null)
                ? null
                : DecorationImage(
                    image: NetworkImage(
                        imageBaseUrl + "w185" + credit.profilePath),
                  ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          width: 70,
          child: Text(
            credit.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: blackTextFont.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
