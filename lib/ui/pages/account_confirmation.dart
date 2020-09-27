part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);
  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 22,
                  ),
                  height: 56,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToSplashPage());
                          },
                          child: Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                      Align(
                        child: Text(
                          "Confirm\nNew Account",
                          style: blackTextFont.copyWith(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (widget.registrationData.profileImage == null)
                          ? AssetImage("assets/user_pic.png")
                          : FileImage(widget.registrationData.profileImage),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Hello!",
                  style: blackTextFont.copyWith(
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.registrationData.name,
                  style: blackTextFont.copyWith(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 110,
                ),
                Container(
                  width: 250,
                  height: 50,
                  child: (isSigningUp)
                      ? SpinKitCircle(
                          color: mainColor,
                        )
                      : RaisedButton(
                          elevation: 0,
                          color: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () async {
                            setState(() {
                              isSigningUp = true;
                            });

                            imageFileToUpload =
                                widget.registrationData.profileImage;

                            SignInSignUpResult result =
                                await AuthServices.signUp(
                              widget.registrationData.name,
                              widget.registrationData.email,
                              widget.registrationData.password,
                              widget.registrationData.selectedGenres,
                              widget.registrationData.selectedLanguages,
                            );

                            if (result.user == null) {
                              setState(() {
                                isSigningUp = false;
                              });

                              return Flushbar(
                                duration: Duration(seconds: 3),
                                backgroundColor: failedColor,
                                flushbarPosition: FlushbarPosition.TOP,
                                message: result.message,
                              );
                            }
                          },
                          child: Text(
                            "Create My Account!",
                            style: blackTextFont.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
