part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTicket;

  TicketPage({this.isExpiredTicket = false});

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets;

  @override
  void initState() {
    super.initState();

    isExpiredTickets = widget.isExpiredTicket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<TicketBloc, TicketState>(
            builder: (context, ticketState) => Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: TicketViewer(
                isExpiredTickets
                    ? ticketState.tickets
                        .where((ticket) =>
                            ticket.dateTime.isBefore(DateTime.now()))
                        .toList()
                    : ticketState.tickets
                        .where((ticket) =>
                            !ticket.dateTime.isBefore(DateTime.now()))
                        .toList(),
              ),
            ),
          ),
          Container(
            height: 120,
            color: accentColor1,
          ),
          SafeArea(
            child: ClipPath(
              clipper: CustomHeaderClipper(),
              child: Container(
                height: 120,
                color: accentColor1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 24, bottom: 38),
                      child: Text(
                        "My Tickets",
                        style: whiteTextFont.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpiredTickets = !isExpiredTickets;
                                });
                              },
                              child: Text(
                                "Newest",
                                style: whiteTextFont.copyWith(
                                  fontSize: 18,
                                  color: !isExpiredTickets
                                      ? Colors.white
                                      : disabledContent,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width / 2,
                              color: !isExpiredTickets
                                  ? accentColor2
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpiredTickets = !isExpiredTickets;
                                });
                              },
                              child: Text(
                                "Oldest",
                                style: whiteTextFont.copyWith(
                                  fontSize: 18,
                                  color: isExpiredTickets
                                      ? Colors.white
                                      : disabledContent,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width / 2,
                              color: isExpiredTickets
                                  ? accentColor2
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 24, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  TicketViewer(this.tickets);

  @override
  Widget build(BuildContext context) {
    var sortedTickets = tickets;
    sortedTickets.sort(
        (ticket1, ticket2) => ticket1.dateTime.compareTo(ticket2.dateTime));

    return ListView.builder(
      itemCount: sortedTickets.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(top: (index == 0) ? 138 : 18),
        child: GestureDetector(
          onTap: () {
            context
                .bloc<PageBloc>()
                .add(GoToTicketDetailPage(sortedTickets[index]));
          },
          child: Row(
            children: [
              Container(
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      imageBaseUrl +
                          "w500" +
                          sortedTickets[index].movieDetail.posterPath,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    2 * defaultMargin -
                    70 -
                    16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sortedTickets[index].movieDetail.title,
                      style: blackTextFont.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      sortedTickets[index].movieDetail.genresAndLanguage,
                      style: greyTextFont.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      sortedTickets[index].theater.name,
                      style: greyTextFont.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
