part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final bool isExpired;

  MainPage({this.bottomNavBarIndex = 0, this.isExpired = false});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    Align topUpIcon() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 48),
          height: 48,
          width: 48,
          child: SizedBox(
            height: 26,
            width: 26,
            child: FloatingActionButton(
              onPressed: () {
                context.bloc<PageBloc>().add(GoToTopUpPage(GoToMainPage()));
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
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(
              color: mainBackground,
            ),
          ),
          PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                bottomNavBarIndex = value;
              });
            },
            children: [
              MoviePage(),
              TicketPage(
                isExpiredTicket: widget.isExpired,
              ),
            ],
          ),
          customBottomNavigationBar(),
          topUpIcon()
        ],
      ),
    );
  }

  Align customBottomNavigationBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: BottomNavBarClipper(),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: mainColor,
            unselectedItemColor: disabledBackground,
            currentIndex: bottomNavBarIndex,
            onTap: (value) {
              setState(() {
                bottomNavBarIndex = value;
                pageController.jumpToPage(value);
              });
            },
            items: [
              BottomNavigationBarItem(
                title: Text("New Movies"),
                icon: Container(
                  height: 20,
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                  child: Image.asset((bottomNavBarIndex == 0)
                      ? "assets/ic_movie.png"
                      : "assets/ic_movie_grey.png"),
                ),
              ),
              BottomNavigationBarItem(
                title: Text("My Tickets"),
                icon: Container(
                  height: 20,
                  margin: EdgeInsets.only(
                    bottom: 6,
                  ),
                  child: Image.asset((bottomNavBarIndex == 1)
                      ? "assets/ic_tickets.png"
                      : "assets/ic_tickets_grey.png"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;

    // throw UnimplementedError();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
