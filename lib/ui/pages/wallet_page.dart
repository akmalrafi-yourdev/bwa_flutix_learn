part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(pageEvent);

        return;
      },
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) => Stack(
            children: [
              //Navbar
              ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(pageEvent);
                              },
                              child: Icon(Icons.arrow_back)),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "My Wallet",
                            style: blackTextFont.copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                        height: 200,
                        width: 360,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: mainColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              spreadRadius: 0,
                              offset: Offset(2, 5),
                            ),
                          ],
                        ),
                      ),
                      ClipPath(
                        clipper: CardShadowClipper(),
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: defaultMargin),
                          height: 220,
                          width: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            38, defaultMargin, 12, defaultMargin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    color: accentColor2,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'IDR ',
                                decimalDigits: 0,
                              ).format((userState as UserLoaded).user.balance),
                              style: whiteNumberFont.copyWith(
                                  fontSize: 28, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Card Holder",
                                      style: whiteTextFont.copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      (userState as UserLoaded).user.name,
                                      style: whiteTextFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ID Holder",
                                      style: whiteTextFont.copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      // "ID Holder",
                                      (userState as UserLoaded)
                                          .user
                                          .id
                                          .substring(0, 12)
                                          .toUpperCase(),
                                      style: whiteNumberFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      "Recent Transactions",
                      style: blackTextFont.copyWith(fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: defaultMargin),
                    child: FutureBuilder(
                      future: FlutixTransactionServices.getTransaction(
                          (userState as UserLoaded).user.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return transactionColumn(
                            snapshot.data,
                            MediaQuery.of(context).size.width -
                                2 * defaultMargin -
                                86,
                          );
                        } else {
                          return SpinKitFadingCircle(
                            size: 48,
                            color: mainColor,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () {
                      context
                          .bloc<PageBloc>()
                          .add(GoToTopUpPage(GoToWalletPage(pageEvent)));
                    },
                    elevation: 0,
                    child: Icon(
                      MdiIcons.walletPlus,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    backgroundColor: accentColor2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column transactionColumn(List<FlutixTransaction> transactions, double width) {
    transactions.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));

    return Column(
      children: transactions
          .map((transaction) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TransactionCard(transaction, width),
              ))
          .toList(),
    );
  }
}

class CardShadowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
