part of 'pages.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 136,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 70,
                bottom: 16,
              ),
              child: Text(
                "New Experience",
                style: blackTextFont.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              child: Text(
                "Watch a new movie much\neasier than any before",
                style: greyTextFont.copyWith(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 46,
              width: 250,
              margin: EdgeInsets.only(
                top: 70,
                bottom: 20,
              ),
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: mainColor,
                onPressed: () async {
                  context.bloc<PageBloc>().add(
                        GoToRegistrationPage(
                          RegistrationData(),
                        ),
                      );
                },
                child: Text(
                  "Get Started!",
                  style: whiteTextFont,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account? ",
                    style: greyTextFont,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.bloc<PageBloc>().add(GoToLoginPage());
                    },
                    child: Text(
                      "Sign in",
                      style: purpleTextFont,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
