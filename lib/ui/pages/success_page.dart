part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return;
        },
        child: Scaffold(
          body: FutureBuilder(
            future: ticket != null
                ? processingTicketOrder(context)
                : processingTopUp(context),
            builder: (_, snapshot) {
              return (snapshot.connectionState == ConnectionState.done)
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            margin: EdgeInsets.only(bottom: 72),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage((ticket != null)
                                    ? "assets/ticket_done.png"
                                    : "assets/top_up_done.png"),
                              ),
                            ),
                          ),
                          Text(
                            (ticket != null)
                                ? "Happy Watching!"
                                : "Wallet feels stronger!",
                            style: blackTextFont.copyWith(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 12),
                          Text(
                            (ticket != null)
                                ? "You have successfully purchase\na movie ticket. See you there!"
                                : "What is this feeling?\nYour wallet feels stronger than before!",
                            style: blackTextFont.copyWith(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24),
                          Container(
                            height: 45,
                            width: 250,
                            child: RaisedButton(
                              elevation: 0,
                              color: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                (ticket != null)
                                    ? "See My Tickets"
                                    : "See My Wallets",
                                style: blackTextFont.copyWith(
                                    fontSize: 14, color: Colors.white),
                              ),
                              onPressed: () {
                                if (ticket != null) {
                                  context.bloc<PageBloc>().add(
                                        GoToMainPage(
                                          bottomNavBarIndex: 1,
                                        ),
                                      );
                                } else {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToWalletPage(GoToMainPage()));
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Discover new movie? ",
                                style: blackTextFont.copyWith(fontSize: 12),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.bloc<PageBloc>().add(GoToMainPage());
                                },
                                child: Text(
                                  "Go to Home",
                                  style: blackTextFont.copyWith(
                                      fontSize: 12, color: mainColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitFadingCircle(
                            size: 48,
                            color: mainColor,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Processing your order...",
                            style: blackTextFont.copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        ));
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTickets(ticket, transaction.userID));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
