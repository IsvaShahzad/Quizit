import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/screens/home_page.dart';
import 'package:quiz_app/screens/intro_pages/get_started.dart';
import 'package:quiz_app/screens/login_page.dart';
import 'package:quiz_app/screens/main_pages/login_cubit/login_cubit.dart';
import 'package:quiz_app/screens/main_pages/signup_cubit/signup_cubit.dart';
import 'package:quiz_app/screens/onBoarding_page.dart';
import 'package:quiz_app/screens/sign_up_page.dart';
import 'package:quiz_app/screens/splashScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),

        debugShowCheckedModeBanner: false,
        title: "Quiz App",
        routes: {
          HomePage.id: (context) => HomePage(
            emails: "",
            first: false,
          ),
          OnBoardingPage.id: (context) => OnBoardingPage(),
          GetStartedPage.id: (context) => const GetStartedPage(),
          LogInPage.id: (context) => LogInPage(),
          SignUpPage.id: (context) => SignUpPage(),
          SplashSreen.id: (context) => const SplashSreen(),
        },
        initialRoute: SplashSreen.id,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:panorama_viewer/panorama_viewer.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text("360° View Demo")),
//         body: const Center(
//           child: PanoramaViewer(
//             child: Image(
//               image: NetworkImage(
//                 "https://pannellum.org/assets/images/image1.jpg", // sample 360° image
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//

