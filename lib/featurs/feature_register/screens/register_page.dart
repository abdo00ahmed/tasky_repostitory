import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_task/core/app_dialogue/app_dialogue.dart';
import 'package:second_task/core/network/states_file.dart';
import 'package:second_task/featurs/auth/data/firebase/auth_firebase_database.dart';
import 'package:second_task/featurs/auth/data/model/user_model.dart';
import 'package:second_task/featurs/feature_register/widgets/custom_reg_textform_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var confirmPassword = TextEditingController();
  var userName1 = TextEditingController();
  var email1 = TextEditingController();
  var password1 = TextEditingController();
  bool isObsecure = true;
  bool isObsecure1 = true;
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
                      "Register",
                      style: TextStyle(
                        //fontFamily: 'Lato',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff24252C).withOpacity(0.87),
                      ),
                    ),
                  ),
                ),
                CustomRegTextformField(
                  keyy: textKey,
                  confirmPasswordd: confirmPassword,
                  passwordd: password1,
                  emaill: email1,
                  usernamee: userName1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: (71 / 812) * screenHeight),
                  child: InkWell(
                    onTap: () async {
                      var user = UserModel(
                        email: email1.text,
                        password: password1.text,
                        userName: userName1.text,
                      );
                      AppDialogue.showLoading(context);
                      if (textKey.currentState!.validate()) {
                        final resultt = await AuthFirebaseDatabase.createUser(
                          user,
                        );
                        switch (resultt) {
                          case Succes<String>():
                            final uid = resultt.data;
                            user.id = uid;
                            await AuthFirebaseDatabase.addUser(user);
                            Navigator.of(context).pop();
                            Navigator.of(
                              context,
                            ).pushNamed("h", arguments: user);
                            break;
                          case Error<String>():
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
                          "Register",
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
                  padding: EdgeInsets.only(bottom: (25 / 812) * screenHeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Color(0xff6E6A7C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Login",
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
