// Import the generated file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningdart/firebase_options.dart';
import 'package:learningdart/views/login_view.dart';
import 'package:learningdart/views/register_view.dart';
import 'package:learningdart/views/verify_email_view.dart';

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
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
            
           final user = FirebaseAuth.instance.currentUser;
          if(user != null){
            if(user.emailVerified == false){
              return const NotesView();            }
            else {
              return const VerifyEmailView();
            }
          }
          else{
            return const LoginView(title: 'Login');
          }
            default : return const CircularProgressIndicator();
          }
        },
      );
  }
}

enum MenuAction {
  logout
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected:(value) {
            print(value);
           } ,
          itemBuilder: (context){
            return const [
             PopupMenuItem<MenuAction>(
              value: MenuAction.logout,
              child:Text('Log out'),
              ),
            ];
          })
        ],
      ),
      body: const Text('Hello world'),
    );
  }
}




 