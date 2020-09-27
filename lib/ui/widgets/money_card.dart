part of 'widgets.dart';

class MoneyCard extends StatelessWidget {
  final double width;
  final bool isSelected;
  final int amount;
  final Function onTap;

  MoneyCard(
      {this.width = 90, this.isSelected = false, this.amount = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(
          color: isSelected ? accentColor2 : Colors.transparent,
          border: Border.all(
              color: isSelected ? Colors.transparent : disabledBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "IDR",
              style: greyTextFont,
            ),
            Text(
              NumberFormat.currency(
                locale: "id_ID",
                symbol: '',
                decimalDigits: 0,
              ).format(amount),
              style: blackNumberFont,
            ),
          ],
        ),
      ),
    );
  }
}
