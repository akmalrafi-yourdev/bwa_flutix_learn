part of 'widgets.dart';

class TransactionCard extends StatelessWidget {
  final FlutixTransaction transactions;
  final double width;

  TransactionCard(this.transactions, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 70,
            height: 90,
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (transactions.picture == null)
                    ? AssetImage("assets/bg_topup.png")
                    : NetworkImage(
                        imageBaseUrl + "w500" + transactions.picture),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactions.title,
                style: blackTextFont.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'IDR ',
                  decimalDigits: 0,
                ).format(
                  transactions.amount < 0
                      ? -transactions.amount
                      : transactions.amount,
                ),
                style: whiteTextFont.copyWith(
                  color: transactions.amount < 0 ? failedColor : mainColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                transactions.subtitle,
                style: blackTextFont.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
