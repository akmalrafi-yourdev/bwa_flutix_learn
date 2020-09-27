import 'package:bwa_flutix/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/blocs.dart';
import 'ui/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(create: (_) => MovieBloc()..add(FetchMovie())),
          BlocProvider(create: (_) => TicketBloc()),
          // jangan lupa export di bloc.dart :D
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            home: Wrapper(),
          ),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: RaisedButton(
//                 onPressed: () async {
//                   SignInSignUpResult result = await AuthServices.signUp(
//                       "Akmal RN",
//                       "akmalrafi@gmail.com",
//                       "12345678",
//                       ["Action", "Crime", "Horror"],
//                       "English");

//                   if (result.user == null) {
//                     print(result.message);
//                   } else {
//                     print(result.user.toString());
//                   }
//                 },
//                 child: Text("Sign Up"),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 onPressed: () async {
//                   SignInSignUpResult result = await AuthServices.signIn(
//                     "akmalrafi@gmail.com",
//                     "12345678",
//                   );

//                   if (result.user == null) {
//                     print("Error : " + result.message);
//                   } else {
//                     print(result.user.toString());
//                   }
//                 },
//                 child: Text("Sign In"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
