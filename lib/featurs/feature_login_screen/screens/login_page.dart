import 'package:flutter/material.dart';
import 'package:second_task/core/app_dialogue/app_dialogue.dart';
import 'package:second_task/core/network/states_file.dart';
import 'package:second_task/featurs/auth/data/firebase/auth_firebase_database.dart';
import 'package:second_task/featurs/auth/data/model/user_model.dart';
import 'package:second_task/featurs/feature_login_screen/widgets/custom_text_formfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                CustomTextFormfield(
                  keyyy: textKey,
                  emailll: email1,
                  passwordd: password1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: (71 / 812) * screenHeight),
                  child: InkWell(
                    onTap: () async {
                      if (textKey.currentState!.validate()) {
                        AppDialogue.showLoading(context);
                        var user = UserModel(
                          email: email1.text,
                          password: password1.text,
                        );
                        final result = await AuthFirebaseDatabase.loginUser(
                          user,
                        );
                        switch (result) {
                          case Succes<String>():
                            email1.clear();
                            password1.clear();
                            Navigator.of(context).pop();
                            Navigator.of(
                              context,
                            ).pushNamed("h", arguments: user);
                            break;
                          case Error<String>():
                            email1.clear();
                            password1.clear();
                            Navigator.of(context).pop();
                            AppDialogue.showError(context);
                            break;
                        }
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
}
