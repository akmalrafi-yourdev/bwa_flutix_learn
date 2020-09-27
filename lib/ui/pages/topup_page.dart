part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent pageEvent;

  TopUpPage(this.pageEvent);

  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController(text: 'IDR 0');
  int selectedAmount = 0;

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(ChangeTheme(ThemeData(
          primaryColor: accentColor2,
        )));
    double cardWidth =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 40) / 3;

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);

        return;
      },
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(widget.pageEvent);
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Top Up My Wallet",
                      style: blackTextFont.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: TextField(
                onChanged: (value) {
                  String temp = '';

                  for (int i = 0; i < value.length; i++) {
                    temp += value.isDigit(i) ? value[i] : '';
                  }

                  setState(() {
                    selectedAmount = int.tryParse(temp) ?? 0;
                  });

                  amountController.text = NumberFormat.currency(
                    locale: "id_ID",
                    decimalDigits: 0,
                    symbol: "IDR ",
                  ).format(selectedAmount);

                  amountController.selection = TextSelection.fromPosition(
                      TextPosition(offset: amountController.text.length));
                },
                controller: amountController,
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: greyTextFont,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
              child: Text("Choose by Template", style: blackTextFont),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Wrap(
                spacing: 20,
                runSpacing: 14,
                children: [
                  // TODO : Money Card
                  moneyCard(amount: 25000, width: cardWidth),
                  moneyCard(amount: 50000, width: cardWidth),
                  moneyCard(amount: 100000, width: cardWidth),
                  moneyCard(amount: 150000, width: cardWidth),
                  moneyCard(amount: 250000, width: cardWidth),
                  moneyCard(amount: 500000, width: cardWidth),
                  moneyCard(amount: 1000000, width: cardWidth),
                  moneyCard(amount: 2500000, width: cardWidth),
                  moneyCard(amount: 5000000, width: cardWidth),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) => Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                width: 250,
                height: 45,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  color: mainColor,
                  onPressed: (selectedAmount >= 25000)
                      ? () {
                          context.bloc<PageBloc>().add(
                                GoToSuccessPage(
                                  null,
                                  FlutixTransaction(
                                    userID: (state as UserLoaded).user.id,
                                    title: "Top Up Wallet",
                                    subtitle:
                                        " ${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year} ",
                                    time: DateTime.now(),
                                    amount: selectedAmount,
                                  ),
                                ),
                              );
                        }
                      : null,
                  child: Text(
                    "Top Up My Wallet",
                    style: whiteTextFont.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  MoneyCard moneyCard({int amount, double width}) {
    return MoneyCard(
      width: width,
      amount: amount,
      isSelected: amount == selectedAmount,
      onTap: () {
        setState(
          () {
            if (selectedAmount != amount) {
              selectedAmount = amount;
            } else {
              selectedAmount = 0;
            }

            amountController.text = NumberFormat.currency(
              locale: 'id_ID',
              symbol: "IDR ",
              decimalDigits: 0,
            ).format(selectedAmount);

            amountController.selection = TextSelection.fromPosition(
                TextPosition(offset: amountController.text.length));
          },
        );
      },
    );
  }
}
