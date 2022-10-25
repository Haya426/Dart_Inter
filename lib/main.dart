// Import the generated file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningdart/firebase_options.dart';
import 'package:learningdart/views/login_view.dart';
import 'package:learningdart/views/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(), 
      routes: {
        '/register/':(context) => const RegisterView(),
        '/login/':(context) =>  const LoginView(title: 'Login'),
      },
    
  ),
  );
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'),),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
            return const LoginView(title: 'Login');
          // final user = FirebaseAuth.instance.currentUser;
          //     if(user?.emailVerified ?? false)  {
          //      print('you are a verified user');
          //     return const Text('Done');

          //     }
          //     else { 
          //       print('you need to verify your email');
          //   return const VerifyEmailView();
          //     }

            default : return const Text('Loading');
          }
        },
      ),
    );
  }
}
class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Column(children: [
        const Text('please verify your email address:'),
        TextButton(
          onPressed: ()async{
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
        }, 
        child: const Text('email verification'))
      ],
      );
  }
}



 