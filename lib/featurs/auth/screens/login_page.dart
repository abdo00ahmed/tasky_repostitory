import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSuccess = false;
  bool isLoading = true;
  var email1 = TextEditingController();
  var password1 = TextEditingController();
  bool isObsecure = true;
  GlobalKey<FormState> textKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              spacing: (50 / 812) * screenHeight,
              children: [
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: (122 / 812) * screenHeight),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        //fontFamily: 'Lato',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff24252C).withOpacity(0.87),
                      ),
                    ),
                  ),
                ),
                Form(
                  key: textKey,
                  child: Column(
                    spacing: (50 / 812) * screenHeight,
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: AlignmentGeometry.topLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff24252C).withOpacity(0.87),
                              ),
                            ),
                          ),

                          TextFormField(
                            controller: email1,
                            validator: (email1) {
                              if (email1!.isEmpty) {
                                return "this field is empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xff5F33E1),
                                ),
                              ),

                              hint: Text(
                                "enter email...",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7F7F7F),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: AlignmentGeometry.topLeft,
                            child: Text(
                              "password",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                color: Color(0xff24252C).withOpacity(0.87),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: password1,
                            obscureText: isObsecure,
                            validator: (password1) {
                              if (password1!.isEmpty) {
                                return "this field is empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObsecure = !isObsecure;
                                  });
                                },
                                icon: isObsecure
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xff5F33E1),
                                ),
                              ),

                              hint: Text(
                                "password...",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7F7F7F),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: (71 / 812) * screenHeight),
                  child: InkWell(
                    onTap: () async {
                      if (textKey.currentState!.validate()) {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        loginUser();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff5F33E1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: (48 / 812) * screenHeight,
                      width: (327 / 375) * screenWidth,

                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: (200 / 812) * screenHeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          color: Color(0xff6E6A7C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "r");
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Color(0xff5F33E1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: isLoading
                ? Text("loading", style: TextStyle(color: Color(0xff5F33E1)))
                : isSuccess
                ? Text("success", style: TextStyle(color: Color(0xff5F33E1)))
                : Text(
                    "Error",
                    style: TextStyle(color: Color.fromARGB(255, 225, 51, 51)),
                  ),
            content: isLoading
                ? CircularProgressIndicator(color: Color(0xff5F33E1))
                : isSuccess
                ? Text("success", style: TextStyle(color: Color(0xff5F33E1)))
                : Text(
                    "Error in email or password ",
                    style: TextStyle(color: Color.fromARGB(255, 225, 51, 51)),
                  ),
          ),
        );
      },
    );

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email1.text,
            password: password1.text,
          );
      setState(() {
        isLoading = !isLoading;
      });
      email1.clear();
      password1.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          isSuccess = !isSuccess;
        });
      } else if (e.code == 'email-already-in-use') {
        print("'email-already-in-use'");
      }
    } catch (e) {
      print(e);
    }
  }
}
