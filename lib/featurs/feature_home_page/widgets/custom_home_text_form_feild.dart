import 'package:flutter/material.dart';
import 'package:second_task/core/media_query_helper/media_query.dart';

class CustomHomeTextFormFeild extends StatefulWidget {
  GlobalKey<FormState> textKey;
  TextEditingController? title = TextEditingController();
  TextEditingController? desc = TextEditingController();
  CustomHomeTextFormFeild({
    super.key,
    this.desc,
    required this.textKey,
    this.title,
  });

  @override
  State<CustomHomeTextFormFeild> createState() =>
      _CustomHomeTextFormFeildState();
}

class _CustomHomeTextFormFeildState extends State<CustomHomeTextFormFeild> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.textKey,
      child: Column(
        spacing: context.calcHeight(12),
        children: [
          TextFormField(
            onChanged: (value) {
              print("Writing in title: $value");
              print("Controller text: ${widget.title?.text}");
            },
            controller: widget.title,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "This field can not be empty";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff979797)),
              ),
              hintText: "Task title",
              hintStyle: TextStyle(color: Color(0xff6E6A7C).withOpacity(0.87)),
            ),
          ),

          TextFormField(
            onChanged: (value) {
              print("Writing in title: $value");
              print("Controller text: ${widget.desc?.text}");
            },
            controller: widget.desc,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "This field can not be empty";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff979797)),
              ),
              hintText: "Description",
              hintStyle: TextStyle(color: Color(0xff6E6A7C).withOpacity(0.87)),
            ),
          ),
        ],
      ),
    );
  }
}
