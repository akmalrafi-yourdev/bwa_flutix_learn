part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  SelectSeatPage(this.ticket);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));

        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: mainColor,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: defaultMargin),
                              padding: EdgeInsets.all(1),
                              child: GestureDetector(
                                onTap: () {
                                  context.bloc<PageBloc>().add(
                                      GoToSelectSchedulePage(
                                          widget.ticket.movieDetail));
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20, right: defaultMargin),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(right: 16),
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        widget.ticket.movieDetail.title,
                                        style: blackTextFont.copyWith(
                                            fontSize: 20),
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.end,
                                      )),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: NetworkImage(imageBaseUrl +
                                              'w154' +
                                              widget.ticket.movieDetail
                                                  .posterPath),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: 280,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/screen.png"),
                            ),
                          ),
                        ),
                        generateSeats(),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: selectedSeats.length > 0
                                ? mainColor
                                : disabledBackground,
                            onPressed: selectedSeats.length > 0
                                ? () {
                                    context.bloc<PageBloc>().add(
                                          GoToCheckoutPage(
                                              widget.ticket.copyWith(
                                            seats: selectedSeats,
                                          )),
                                        );
                                  }
                                : null,
                            child: Icon(
                              Icons.arrow_forward,
                              color: selectedSeats.length > 0
                                  ? Colors.white
                                  : disabledContent,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 64,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberofSeats = [3, 5, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (var i = 0; i < numberofSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            numberofSeats[i],
            (index) => Container(
                margin: EdgeInsets.only(
                    right: index < numberofSeats[i] - 1 ? 16 : 0, bottom: 16),
                child: SelectableBox(
                  "${String.fromCharCode(i + 65)}${index + 1}",
                  width: 52,
                  height: 52,
                  textStyle: whiteNumberFont.copyWith(
                      fontSize: 20, color: Colors.black),
                  isSelected: selectedSeats
                      .contains("${String.fromCharCode(i + 65)}${index + 1}"),
                  onTap: () {
                    String seatNumber =
                        "${String.fromCharCode(i + 65)}${index + 1}";
                    setState(() {
                      if (selectedSeats.contains(seatNumber)) {
                        selectedSeats.remove(seatNumber);
                      } else {
                        selectedSeats.add(seatNumber);
                      }
                    });
                  },
                ))),
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
