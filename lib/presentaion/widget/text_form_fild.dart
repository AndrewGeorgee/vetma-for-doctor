import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultFormFieldWidget extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? type;
  String? label;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  GestureTapCallback? onTap;
  FormFieldValidator<String>? validate;
  bool isPassword = false;
  Widget? prefix;
  TextInputType? textInputType;
  Widget? suffix;
  bool autofocus = false;

  DefaultFormFieldWidget({
    super.key,
    required this.textInputType,
    this.controller,
    this.type,
    this.onChange,
    this.onSubmit,
    this.onTap,
    required this.validate,
    required this.autofocus,
    required this.isPassword,
    this.suffix,
    required this.label,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      validator: validate,
      cursorWidth: 1.5,
      style: const TextStyle(
        fontSize: 15,
        letterSpacing: 1.0,
      ),
      autocorrect: true,
      obscureText: isPassword,
      autofocus: autofocus,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(25)),
        fillColor: Colors.black,
        counterStyle: const TextStyle(color: Colors.red),
        hoverColor: Colors.blue,

        contentPadding: const EdgeInsets.only(left: 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        labelText: label,
        suffixIcon: suffix,
        // labelStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

// ignore: must_be_immutable
class DefaultFormFieldWidget2 extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? type;
  String? label;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  GestureTapCallback? onTap;
  FormFieldValidator<String>? validate;
  bool isPassword = false;
  Widget? prefix;
  TextInputType? textInputType;
  Widget? suffix;
  bool autofocus = false;

  DefaultFormFieldWidget2({
    super.key,
    required this.textInputType,
    this.controller,
    this.type,
    this.onChange,
    this.onSubmit,
    this.onTap,
    required this.validate,
    required this.autofocus,
    required this.isPassword,
    this.suffix,
    required this.label,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      validator: validate,
      cursorWidth: 1,
      style: const TextStyle(
        fontSize: 15,
        letterSpacing: 1.0,
      ),
      autocorrect: true,
      obscureText: isPassword,
      autofocus: autofocus,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(25)),
        fillColor: Colors.black,
        counterStyle: const TextStyle(color: Colors.red),
        hoverColor: Colors.blue,

        contentPadding: const EdgeInsets.only(left: 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        labelText: label,
        suffixIcon: suffix,
        prefix: prefix,
        // labelStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
