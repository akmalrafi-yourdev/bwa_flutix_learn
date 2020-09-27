part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDates;
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    dates = List.generate(
        7,
        (index) => DateTime.now().add(
            Duration(days: index))); // memilih hari dari hari ini ke hari ke 7
    selectedDates = dates[0]; // memilih hari ini
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMovieDetailsPage(widget.movieDetail));

        return;
      },
      child: Scaffold(
        body: Container(
            child: Stack(
          children: [
            Container(
              color: mainColor,
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        // top: 32,
                        left: defaultMargin,
                      ),
                      height: 56,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToMovieDetailsPage(widget.movieDetail));
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 16),
                      child: Text(
                        "Choose Date",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: (index == 0) ? defaultMargin : 0,
                                right: (index < dates.length - 1)
                                    ? 16
                                    : defaultMargin),
                            child: DateCard(
                              dates[index],
                              isSelected: selectedDates == dates[index],
                              onTap: () {
                                setState(() {
                                  selectedDates = dates[index];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 16),
                      child: Text(
                        "Choose Cinema",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                    ),
                    Container(
                      // height: 90,
                      child: generateTimeTable(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) => FloatingActionButton(
                            elevation: 0,
                            backgroundColor:
                                (isValid) ? mainColor : disabledContent,
                            child: Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color:
                                  (isValid) ? Colors.white : disabledBackground,
                            ),
                            onPressed: () {
                              if (isValid) {
                                context.bloc<PageBloc>().add(
                                      GoToSelectSeatPage(
                                        Ticket(
                                          widget.movieDetail,
                                          selectedTheater,
                                          DateTime(
                                            selectedDates.year,
                                            selectedDates.month,
                                            selectedDates.day,
                                            selectedTime,
                                          ),
                                          randomAlphaNumeric(12).toUpperCase(),
                                          null,
                                          (state as UserLoaded).user.name,
                                          null,
                                        ),
                                      ),
                                    );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      widgets.add(Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child:
              Text(theater.name, style: blackTextFont.copyWith(fontSize: 20))));

      widgets.add(
        Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: schedule.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 90,
                  margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index < schedule.length - 1) ? 16 : 24),
                  child: SelectableBox(
                    "${schedule[index]}:00",
                    height: 50,
                    isSelected: selectedTheater == theater &&
                        selectedTime == schedule[index],
                    isEnabled: schedule[index] > DateTime.now().hour ||
                        selectedDates.day != DateTime.now().day,
                    onTap: () {
                      setState(() {
                        selectedTheater = theater;
                        selectedTime = schedule[index];
                        isValid = true;
                      });
                    },
                  ),
                );
              },
            )),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
