part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage(
              bottomNavBarIndex: 1,
              isExpired: ticket.dateTime.isBefore(DateTime.now()),
            ));

        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Color(0xFFFAF8FF),
              // color: Colors.grey[500],
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(
                    left: defaultMargin, right: defaultMargin, top: 40),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToMainPage(
                                      bottomNavBarIndex: 1,
                                      isExpired: ticket.dateTime
                                          .isBefore(DateTime.now()),
                                    ));
                              },
                              child: Icon(Icons.arrow_back)),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Ticket Details",
                            style: blackTextFont.copyWith(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: defaultMargin),
                                width: 100,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imageBaseUrl +
                                        "w342" +
                                        ticket.movieDetail.posterPath),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        136,
                                    child: Text(
                                      ticket.movieDetail.title,
                                      style: blackTextFont.copyWith(
                                        fontSize: 20,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    width: MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        136,
                                    child: Text(
                                      ticket.movieDetail.genresAndLanguage,
                                      style:
                                          greyTextFont.copyWith(fontSize: 12),
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RatingStars(
                                        voteAverage:
                                            ticket.movieDetail.voteAverage,
                                        starSizes: 16,
                                        fontSize: 12,
                                      ),
                                      Text(
                                        ticket.movieDetail.voteAverage
                                            .toString(),
                                        style: greyNumberFont.copyWith(
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Cinema",
                                      style:
                                          greyTextFont.copyWith(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ticket.theater.name,
                                        style: blackTextFont.copyWith(
                                            fontSize: 12),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date and Time",
                                      style:
                                          greyTextFont.copyWith(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ticket.dateTime.dateAndTime,
                                        style: blackNumberFont.copyWith(
                                            fontSize: 12),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Seat Number(s)",
                                      style:
                                          greyTextFont.copyWith(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ticket.seatInString,
                                        style: blackNumberFont.copyWith(
                                            fontSize: 12),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ID Order",
                                      style:
                                          greyTextFont.copyWith(fontSize: 12),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        ticket.bookingCode,
                                        style: blackNumberFont.copyWith(
                                            fontSize: 12),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                generateDashedDivider(
                                    MediaQuery.of(context).size.width -
                                        2 * defaultMargin -
                                        40),
                                ClipPath(
                                  clipper: TicketBottomClipper(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name",
                                            style: blackTextFont.copyWith(
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            ticket.name,
                                            style: greyTextFont.copyWith(
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Price",
                                            style: blackTextFont.copyWith(
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            NumberFormat.currency(
                                              locale: "id_ID",
                                              decimalDigits: 0,
                                              symbol: "IDR ",
                                            ).format(
                                              ticket.totalPrice,
                                            ),
                                            style: greyNumberFont.copyWith(
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      QrImage(
                                        version: 6,
                                        foregroundColor: Colors.black,
                                        errorCorrectionLevel:
                                            QrErrorCorrectLevel.M,
                                        padding: EdgeInsets.all(12),
                                        size: 130,
                                        data: ticket.bookingCode,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketTopClipper extends CustomClipper<Path> {
  double radius = 15;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(radius, size.height - radius, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width - radius, size.height - radius,
        size.width, size.height - radius);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketBottomClipper extends CustomClipper<Path> {
  double radius = 15;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width - radius, radius, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(radius, radius, 0, radius);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
