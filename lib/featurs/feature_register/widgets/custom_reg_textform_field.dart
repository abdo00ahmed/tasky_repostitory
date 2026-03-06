import 'package:flutter/material.dart';
import 'package:second_task/core/validator_helper/validators.dart';

class CustomRegTextformField extends StatefulWidget {
  TextEditingController usernamee;
  TextEditingController emaill;
  TextEditingController passwordd;
  TextEditingController confirmPasswordd;
  GlobalKey<FormState> keyy;
  CustomRegTextformField({
    super.key,
    required this.keyy,
    required this.confirmPasswordd,
    required this.passwordd,
    required this.emaill,
    required this.usernamee,
  });

  @override
  State<CustomRegTextformField> createState() => _CustomRegTextformFieldState();
}

class _CustomRegTextformFieldState extends State<CustomRegTextformField> {
  bool isObsecure = true;
  bool isObsecure1 = true;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: widget.keyy,
      child: Column(
        spacing: (40 / 812) * screenHeight,
        children: [
          Column(
            children: [
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Text(
                  "Username",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    color: Color(0xff24252C).withOpacity(0.87),
                  ),
                ),
              ),

              TextFormField(
                controller: widget.usernamee,
                validator: (usernamee) => Validator.validateName(usernamee),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff5F33E1)),
                  ),

                  hint: Text(
                    "enter username...",
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
                controller: widget.emaill,
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
                  " password",
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
                    " password...",
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
                  "comfirm password",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    color: Color(0xff24252C).withOpacity(0.87),
                  ),
                ),
              ),
              TextFormField(
                controller: widget.confirmPasswordd,
                obscureText: isObsecure1,
                validator: (password1) => Validator.validateConfirmPassword(
                  password1,
                  widget.passwordd.text,
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecure1 = !isObsecure1;
                      });
                    },
                    icon: isObsecure1
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff5F33E1)),
                  ),

                  hint: Text(
                    " comfirm password...",
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
