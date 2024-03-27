import 'package:chatapp1/helper/constans.dart';
import 'package:flutter/material.dart';

class CustomTextFieldNormal extends StatelessWidget {
  const CustomTextFieldNormal({super.key, this.onSubmitted, this.controller});
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: 'Enter Your Message',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: kPrimeryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: kPrimeryColor),
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
              size: 35,
              color: kPrimeryColor,
            ),
          ),
          filled: true,
        ),
      ),
    );
  }
}
