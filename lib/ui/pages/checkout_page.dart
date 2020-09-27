part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  CheckoutPage(this.ticket);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    int total = 26500 * widget.ticket.seats.length;

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));

        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: mainColor,
            ),
            SafeArea(
              child: Container(color: Colors.white),
            ),
            BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              User user = (state as UserLoaded).user;

              return ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: defaultMargin, vertical: 20),
                    child: Column(
                      children: [
                        Container(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .bloc<PageBloc>()
                                        .add(GoToSelectSeatPage(widget.ticket));
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.black),
                                ),
                              ),
                              Align(
                                child: Text(
                                  "Checkout\nMovie",
                                  style: blackTextFont.copyWith(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 32),
                          child: Row(
                            children: [
                              Container(
                                height: 90,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imageBaseUrl +
                                          "w342" +
                                          widget.ticket.movieDetail.posterPath,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          (2 * defaultMargin) -
                                          20 -
                                          90,
                                      child: Text(
                                        widget.ticket.movieDetail.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: blackTextFont.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          (2 * defaultMargin) -
                                          20 -
                                          120,
                                      child: Text(
                                        widget.ticket.movieDetail
                                            .genresAndLanguage,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: blackTextFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: disabledBackground,
                                        ),
                                      ),
                                    ),
                                    RatingStars(
                                      voteAverage:
                                          widget.ticket.movieDetail.voteAverage,
                                      fontSize: 18,
                                      starSizes: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            thickness: 1,
                            color: disabledContent,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ID Order",
                              style: blackTextFont,
                            ),
                            Text(
                              widget.ticket.bookingCode,
                              style: greyNumberFont.copyWith(
                                fontWeight: FontWeight.w300,
                                // color: greynu
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cinema",
                              style: blackTextFont,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                widget.ticket.theater.name,
                                textAlign: TextAlign.right,
                                style: greyNumberFont.copyWith(
                                  fontWeight: FontWeight.w300,
                                  // color: greynu
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date & Time",
                              style: blackTextFont,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                widget.ticket.dateTime.dateAndTime,
                                textAlign: TextAlign.right,
                                style: greyNumberFont.copyWith(
                                  fontWeight: FontWeight.w300,
                                  // color: greynu
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Seat Number(s)",
                              style: blackTextFont,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                widget.ticket.seatInString,
                                textAlign: TextAlign.right,
                                style: greyNumberFont.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price",
                              style: blackTextFont,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "IDR 25.000 x " +
                                    widget.ticket.seats.length.toString(),
                                textAlign: TextAlign.right,
                                style: greyNumberFont.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fee",
                              style: blackTextFont,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "IDR 1.500 x " +
                                    widget.ticket.seats.length.toString(),
                                textAlign: TextAlign.right,
                                style: greyNumberFont.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price",
                              style: blackTextFont,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                NumberFormat.currency(
                                  locale: "id_ID",
                                  symbol: "IDR ",
                                  decimalDigits: 0,
                                ).format(total),
                                textAlign: TextAlign.right,
                                style: greyNumberFont.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Divider(
                            thickness: 1,
                            color: disabledContent,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Your Wallet",
                              style: blackTextFont,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                NumberFormat.currency(
                                  locale: "id_ID",
                                  symbol: "IDR ",
                                  decimalDigits: 0,
                                ).format(user.balance),
                                textAlign: TextAlign.right,
                                style: greyNumberFont.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: user.balance >= total
                                      ? Color(0xFF3E9D9D)
                                      : failedColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          width: 250,
                          height: 48,
                          child: RaisedButton(
                            elevation: 0,
                            color: user.balance >= total
                                ? mainColor
                                : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: user.balance >= total
                                      ? Colors.transparent
                                      : mainColor),
                            ),
                            onPressed: () {
                              if (user.balance >= total) {
                                // bisa bayar
                                FlutixTransaction transaction =
                                    FlutixTransaction(
                                  userID: user.id,
                                  title: widget.ticket.movieDetail.title,
                                  subtitle: widget.ticket.theater.name,
                                  time: DateTime.now(),
                                  amount: -total,
                                  picture: widget.ticket.movieDetail.posterPath,
                                );

                                context.bloc<PageBloc>().add(GoToSuccessPage(
                                    widget.ticket.copyWith(
                                      totalPrice: total,
                                    ),
                                    transaction));
                              } else {
                                // gak bisa bayar
                              }
                            },
                            child: Text(
                              user.balance >= total
                                  ? "Checkout Now!"
                                  : "Top Up My Wallet",
                              style: user.balance >= total
                                  ? whiteTextFont
                                  : whiteTextFont.copyWith(
                                      color: mainColor,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
