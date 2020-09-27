part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  TextEditingController emailController;
  bool isUpdating = false;
  bool isDataEdited = false;
  String profilePath;
  File profileImageFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToProfilePage());

        return;
      },
      child: Scaffold(
        body: ListView(
          children: [
            SafeArea(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToProfilePage());
                              },
                              child: Icon(Icons.arrow_back)),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Edit Profile",
                            style: blackTextFont.copyWith(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: 120,
                      height: 140,
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (profileImageFile != null)
                                    ? FileImage(profileImageFile)
                                    : (profilePath != "")
                                        ? NetworkImage(profilePath)
                                        : AssetImage("assets/user_pic.png"),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                // TODO: Logic Upload Image

                                if (profilePath == "") {
                                  profileImageFile = await getImage();

                                  if (profileImageFile != null) {
                                    profilePath =
                                        basename(profileImageFile.path);
                                  }
                                } else {
                                  profileImageFile = null;
                                  profilePath = "";
                                }

                                setState(() {
                                  isDataEdited = (nameController.text.trim() !=
                                              widget.user.name ||
                                          profilePath !=
                                              widget.user.profilePicture)
                                      ? true
                                      : false;
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    // TODO : Logic Add / Delete Button
                                    image: AssetImage(
                                      (profilePath == "")
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_del_photo.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 48),
                    Container(
                      child: TextField(
                        controller: nameController,
                        onChanged: (value) {
                          // TODO : Check if controller value changed or not

                          setState(() {
                            isDataEdited = ((value.trim() != widget.user.name ||
                                    profilePath != widget.user.profilePicture)
                                ? true
                                : false);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      child: AbsorbPointer(
                        child: TextField(
                          controller: emailController,
                          onChanged: (value) {
                            // TODO : Check if controller value changed or not
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 250,
                      height: 46,
                      child: RaisedButton(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Text(
                          "Reset My Password",
                          style: blackTextFont,
                        ),
                        onPressed: () async {
                          // TODO : Reset Password Function

                          await AuthServices.forgotPassword(widget.user.email);

                          Flushbar(
                            duration: Duration(seconds: 3),
                            backgroundColor: mainColor,
                            flushbarPosition: FlushbarPosition.TOP,
                            message:
                                "Reset Password link has been sent to your email address",
                          )..show(context);
                        },
                      ),
                    ),
                    SizedBox(height: 48),
                    SizedBox(
                      width: 300,
                      height: 46,
                      child: (isUpdating)
                          ? SpinKitFadingCircle(size: 46, color: mainColor)
                          : Container(
                              width: 250,
                              height: 46,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                  color: mainColor,
                                  child: Text(
                                    "Update My Profile",
                                    style: whiteTextFont,
                                  ),
                                  onPressed: (isDataEdited)
                                      ? () async {
                                          // TODO : Update Profile

                                          setState(() {
                                            isUpdating = true;
                                          });

                                          if (profileImageFile != null) {
                                            profilePath = await uploadImage(
                                                profileImageFile);
                                          }

                                          context
                                              .bloc<UserBloc>()
                                              .add(UpdateData(
                                                name: nameController.text,
                                                profileImage: profilePath,
                                              ));

                                          context
                                              .bloc<PageBloc>()
                                              .add(GoToProfilePage());
                                        }
                                      : null),
                            ),
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
}
