import 'package:flutter/material.dart';

class ProjectEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const ProjectEditor({
    required this.controller,
    required this.hintText,
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value){
        if(value!.isEmpty){
          return "The field $hintText is missing!";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText
      ),
      maxLines: null,
    );
  }
}