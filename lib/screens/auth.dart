import 'package:degilib/common_widget/custom_input.dart';
import 'package:degilib/common_widget/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

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

  final pwdResetSnackBar = const SnackBar(content: Text("Password Reset email sent"));

  @override
  void initState() {
    if(fAuth.currentUser != null){
      modular.navigate("/home");
    }
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
              width: MediaQuery.of(context).size.width * .75,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Degilib",
                      style: Theme.of(context).textTheme.headline3,),
                    const SizedBox(height: 10,),
                    CustomTextField(_email!, "Email", "", "", false,
                        TextInputType.emailAddress, false, const [AutofillHints.email]),
                    const SizedBox(height: 10,),
                    CustomTextField(_pwd!, "Password", "", "", true,
                        TextInputType.visiblePassword, true,
                        const [AutofillHints.password]),
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Text("Forgot Password?"),
                                    const SizedBox(height: 10,),
                                    CustomTextField(_email!,
                                        "Registered Email", "", "", false,
                                        TextInputType.emailAddress, false,
                                        const [AutofillHints.email]),
                                    const SizedBox(height: 10,),
                                    Visibility(
                                      visible: !UniversalPlatform.isIOS,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          fAuth.sendPasswordResetEmail(
                                              email: _email!.text);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                          .showSnackBar(pwdResetSnackBar);
                                        },
                                        child: const Text("Submit"),
                                      ),
                                    ),
                                    Visibility(
                                      visible: UniversalPlatform.isIOS,
                                      child: CupertinoButton(
                                        onPressed: (){
                                          fAuth.sendPasswordResetEmail(
                                              email: _email!.text);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(pwdResetSnackBar);
                                        },
                                        child: const Text("Submit"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          );
                        },
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
            width: MediaQuery.of(context).size.width * .75,
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
                      const Icon(Icons.arrow_back_ios) : const Icon(Icons.arrow_back),
                    ),
                    title: Text("Degilib",
                      style: Theme.of(context).textTheme.headline3,),
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(_name!, "Name", "", "", false,
                      TextInputType.name, false, const [AutofillHints.name]),
                  const SizedBox(height: 10,),
                  CustomTextField(_email!, "Email", "", "", false,
                      TextInputType.emailAddress, false, const [AutofillHints.email]),
                  const SizedBox(height: 10,),
                  CustomTextField(_pwd!, "Password", "", "", true,
                      TextInputType.visiblePassword, true,
                      const [AutofillHints.password]),
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
      final userNamePref = await SharedPreferences.getInstance();
      final userEmailPref = await SharedPreferences.getInstance();

      if(userNamePref.getString("name") == null ||
          userEmailPref.getString("email") == null){
        await userNamePref.setString("name", "${fAuth.currentUser?.displayName}");
        await userEmailPref.setString("email", "${fAuth.currentUser?.email}");
      }

      navigateMethod();
    }
    on FirebaseAuthException catch (e){
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
      }
      if(e.code == 'user-not-found'){
        setState(() {
          errorMsg = "Account does not exist";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "account does not exist"
        });
      }
      if(e.code == 'wrong-password'){
        setState(() {
          errorMsg = "Wrong password, try again or reset password";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "wrong-password"
        });
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
      List<String> nameSplit = _name!.text.split(" ");
      List<String> nameSearch = [];

      for(int i = 0; i < nameSplit.length; i++){
        for(int j = 1; j < nameSplit[i].length + 1; j++){
          nameSearch.add(nameSplit[i].substring(0, j).toLowerCase());
        }
      }

      fStore.collection("users").doc(user.uid)
      .set({
        "name": toBeginningOfSentenceCase(_name!.text),
        "email": _email!.text,
        "uid": user.uid,
        "search_field": nameSearch,
      });
      // user.sendEmailVerification();
      // modular.pushReplacementNamed("/home");
      final userNamePref = await SharedPreferences.getInstance();
      final userEmailPref = await SharedPreferences.getInstance();

      if(userNamePref.getString("name") == null ||
          userEmailPref.getString("email") == null){
        await userNamePref.setString("name", _name!.text);
        await userEmailPref.setString("email", _email!.text);
      }
      navigateMethod();
    }
    on FirebaseAuthException catch (e){
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
      }
      if(e.code == 'user-not-found'){
        setState(() {
          errorMsg = "Account does not exist";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "account does not exist"
        });
      }
      if(e.code == 'wrong-password'){
        setState(() {
          errorMsg = "Wrong password, try again or reset password";
        });
        fAnalytics.logEvent(name: "authentication error", parameters: {
          "type": "wrong-password"
        });
      }
    }
  }

  void navigateMethod(){
    modular.pushNamedAndRemoveUntil("/home", (route) => route.isFirst);
  }
}
