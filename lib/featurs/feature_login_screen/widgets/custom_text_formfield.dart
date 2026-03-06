import 'package:flutter/material.dart';
import 'package:second_task/core/validator_helper/validators.dart';

class CustomTextFormfield extends StatefulWidget {
  GlobalKey<FormState> keyyy;
  TextEditingController passwordd;
  TextEditingController emailll;
  CustomTextFormfield({
    super.key,
    required this.keyyy,
    required this.emailll,
    required this.passwordd,
  });

  @override
  State<CustomTextFormfield> createState() => _CustomTextFormfieldState();
}

class _CustomTextFormfieldState extends State<CustomTextFormfield> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: widget.keyyy,
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
                controller: widget.emailll,
                validator: (email1) => Validator.validateEmail(email1),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff5F33E1)),
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
                controller: widget.passwordd,
                obscureText: isObsecure,
                validator: (password1) => Validator.validatePassword(password1),
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
                    borderSide: BorderSide(color: Color(0xff5F33E1)),
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
    );
  }
}
