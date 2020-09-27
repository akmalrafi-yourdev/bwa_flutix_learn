part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    context.bloc<ThemeBloc>().add(
          ChangeTheme(
            ThemeData().copyWith(primaryColor: accentColor2),
          ),
        );
    return WillPopScope(
      onWillPop: () {
        // agar bisa back ke splash screen
        context.bloc<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 70,
                    ),
                    child: Image.asset("assets/logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Text(
                      "Welcome Back,\nExplorer!",
                      style: blackNumberFont.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(value);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      hintText: "Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        isPasswordValid = value.length >= 5;
                      });
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot Password? ",
                        style: greyTextFont,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Recover it now!",
                          style: purpleTextFont,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  SizedBox(
                    height: 72,
                    child: Center(
                      child: isSigningIn
                          ? SpinKitChasingDots(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              onPressed: isEmailValid && isPasswordValid
                                  ? () async {
                                      setState(() {
                                        isSigningIn = true;
                                      });

                                      SignInSignUpResult result =
                                          await AuthServices.signIn(
                                              emailController.text,
                                              passwordController.text);

                                      if (result.user == null) {
                                        setState(() {
                                          isSigningIn = false;
                                        });

                                        Flushbar(
                                          duration: Duration(seconds: 5),
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          backgroundColor: failedColor,
                                          message: result.message,
                                        )..show(context);
                                      }
                                      //  else {
                                      //   context
                                      //       .bloc<PageBloc>()
                                      //       .add(GoToMainPage());
                                      // }
                                    }
                                  : null,
                              child: Icon(
                                Icons.arrow_forward,
                                color: isEmailValid && isPasswordValid
                                    ? Colors.white
                                    : disabledBackground,
                              ),
                              backgroundColor: isEmailValid && isPasswordValid
                                  ? mainColor
                                  : disabledContent,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Start as a fresh account? ",
                        style: greyTextFont,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Let's sign you up!",
                          style: purpleTextFont,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
