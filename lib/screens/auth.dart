import 'package:degilib/common_widget/custom_input.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../common.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  TextEditingController? _name, _email, _pwd;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  int _currentDisplay = 0;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _pwd = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const SafeArea(
        child: Scaffold(
          body: Loader(),
        ),
      );
    }
    if(_currentDisplay == 0){
      // login
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: isDesktopBrowser ? MediaQuery.of(context).size.width * .75
                  : MediaQuery.of(context).size.width * .50,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Degilib",
                      style: Theme.of(context).textTheme.headline3,),
                    const SizedBox(height: 10,),
                    CustomTextField(_email!, "Email", "", "", false,
                        TextInputType.emailAddress, false, [AutofillHints.email]),
                    const SizedBox(height: 10,),
                    CustomTextField(_pwd!, "Password", "", "", true,
                        TextInputType.visiblePassword, true,
                        [AutofillHints.password]),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: (){},
                        child: const Text("Forgot Password?"),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(errorMsg, style: Theme.of(context)
                          .textTheme.bodyText1?.copyWith(color: Colors.red),),
                    ),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: (){
                          setState((){
                            isLoading = true;
                          });
                          login();
                        },
                        child: Icon(UniversalPlatform.isIOS ?
                        Icons.arrow_forward_ios : Icons.arrow_forward),
                      ),
                    ),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: UniversalPlatform.isIOS,
                        child: CupertinoButton(
                          onPressed: (){
                            setState((){
                              _currentDisplay = 1;
                            });
                          },
                          child: const Text("New? Sign Up"),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: !UniversalPlatform.isIOS,
                        child: TextButton(
                          onPressed: (){
                            setState((){
                              _currentDisplay = 1;
                            });
                          },
                          child: const Text("New? Sign Up"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    // sign up
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: isDesktopBrowser ? MediaQuery.of(context).size.width * .75
            : MediaQuery.of(context).size.width * .50,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: IconButton(
                      onPressed: (){
                        setState((){
                          _currentDisplay = 0;
                        });
                      },
                      icon: UniversalPlatform.isIOS ?
                      Icon(Icons.arrow_back_ios) : Icon(Icons.arrow_back),
                    ),
                    title: Text("Degilib",
                      style: Theme.of(context).textTheme.headline3,),
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(_name!, "Name", "", "", false,
                      TextInputType.name, false, [AutofillHints.name]),
                  const SizedBox(height: 10,),
                  CustomTextField(_email!, "Email", "", "", false,
                      TextInputType.emailAddress, false, [AutofillHints.email]),
                  const SizedBox(height: 10,),
                  CustomTextField(_pwd!, "Password", "", "", true,
                      TextInputType.visiblePassword, true,
                      [AutofillHints.password]),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(errorMsg, style: Theme.of(context)
                        .textTheme.bodyText1?.copyWith(color: Colors.red),),
                  ),
                  const SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: (){
                        setState((){
                          isLoading = true;
                        });
                        signUp();
                      },
                      child: Icon(UniversalPlatform.isIOS ?
                      Icons.arrow_forward_ios : Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async{
    try{
      await fAuth.signInWithEmailAndPassword(
          email: _email!.text, password: _pwd!.text);
      modular.pushReplacementNamed("/home");
    }
    on FirebaseAuthException catch (e){
      print(e.toString());
      setState(() {
        isLoading = false;
        isError = true;
      });
      if(e.code == 'email-already-in-use'){
        setState(() {
          errorMsg = "Email in user, try again or reset your password";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "email-already-in-user"
        });
        print("Email in user, try again or reset your password");
      }
      if(e.code == 'user-not-found'){
        setState(() {
          errorMsg = "Account does not exist";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "account does not exist"
        });
        print("Account does not exist");
      }
      if(e.code == 'wrong-password'){
        setState(() {
          errorMsg = "Wrong password, try again or reset password";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "wrong-password"
        });
        print("Wrong password, try again or reset password");
      }
    }
  }

  void signUp() async{
    if(_pwd!.text.length < 6){
      setState(() {
        isLoading = false;
        isError = true;
      });
      ScaffoldMessenger.of(context)
      .showSnackBar(const
      SnackBar(content: Text("Password need to be 6+ characters"),
      backgroundColor: Colors.red,));
    }
    try{
      User? user = (await fAuth.createUserWithEmailAndPassword(
          email: _email!.text, password: _pwd!.text)).user;
      await user!.updateDisplayName(_name!.text);
      fStore.collection("users").doc(user.uid)
      .set({
        "name": _name!.text,
        "email": _email!.text,
        "uid": user.uid,
      });
      user.sendEmailVerification();
      modular.pushReplacementNamed("/home");
    }
    on FirebaseAuthException catch (e){
      print(e.toString());
      setState(() {
        isLoading = false;
        isError = true;
      });
      if(e.code == 'email-already-in-use'){
        setState(() {
          errorMsg = "Email in user, try again or reset your password";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "email-already-in-user"
        });
        print("Email in user, try again or reset your password");
      }
      if(e.code == 'user-not-found'){
        setState(() {
          errorMsg = "Account does not exist";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "account does not exist"
        });
        print("Account does not exist");
      }
      if(e.code == 'wrong-password'){
        setState(() {
          errorMsg = "Wrong password, try again or reset password";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "wrong-password"
        });
        print("Wrong password, try again or reset password");
      }
    }
  }
}
