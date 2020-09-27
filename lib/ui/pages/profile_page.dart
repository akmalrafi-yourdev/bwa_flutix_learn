part of 'pages.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Show Sign Out Dialog

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign Out'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to\nsign out?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Cancel',
                  style: blackTextFont.copyWith(fontSize: 14),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Sign Out',
                  style: blackTextFont.copyWith(
                    fontSize: 14,
                    color: failedColor,
                  ),
                ),
                onPressed: () {
                  context.bloc<UserBloc>().add(SignOut());
                  Navigator.of(context).pop();
                  AuthServices.signOut();
                },
              ),
            ],
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage());

        return;
      },
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToMainPage());
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "User Profile",
                      style: blackTextFont.copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  if (userState is UserLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: (userState.user.profilePicture == "")
                                  ? AssetImage("assets/user_pic.png")
                                  : NetworkImage(userState.user.profilePicture),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          userState.user.name,
                          style: blackTextFont.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          userState.user.email,
                          style: greyTextFont.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        // Edit Profile
                        Container(
                          margin: EdgeInsets.only(left: defaultMargin),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToEditProfilePage(userState.user));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/edit_profile.png"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "Edit Profile",
                                      style: blackTextFont.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12),
                              generateDashedDivider(
                                  MediaQuery.of(context).size.width -
                                      2 * defaultMargin),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        // My Wallet
                        GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToWalletPage(GoToProfilePage()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: defaultMargin),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/my_wallet.png"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "My Wallet",
                                      style: blackTextFont.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                generateDashedDivider(
                                    MediaQuery.of(context).size.width -
                                        2 * defaultMargin),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Change Language
                        Container(
                          margin: EdgeInsets.only(left: defaultMargin),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage("assets/language.png"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Change Language",
                                    style: blackTextFont.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              generateDashedDivider(
                                  MediaQuery.of(context).size.width -
                                      2 * defaultMargin),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),

                        // Help Centre
                        Container(
                          margin: EdgeInsets.only(left: defaultMargin),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/help_centre.png"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Help Centre",
                                    style: blackTextFont.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              generateDashedDivider(
                                  MediaQuery.of(context).size.width -
                                      2 * defaultMargin),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),

                        // Rate My Flutix App
                        Container(
                          margin: EdgeInsets.only(left: defaultMargin),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/rate.png"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Rate My Flutix App",
                                    style: blackTextFont.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              generateDashedDivider(
                                  MediaQuery.of(context).size.width -
                                      2 * defaultMargin),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: failedColor,
                              ),
                            ),
                            child: Text(
                              "Sign Out",
                              style: blackTextFont.copyWith(
                                color: failedColor,
                              ),
                            ),
                            onPressed: () {
                              _showMyDialog();
                              // context.bloc<UserBloc>().add(SignOut());
                              // AuthServices.signOut();
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );

    // Alert Dialog
  }
}
