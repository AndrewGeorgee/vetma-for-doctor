import 'dart:async';

import 'package:doctor_of_vetma/core/resources/assets_manger.dart';
import 'package:doctor_of_vetma/presentaion/widget/tost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/routes_manager.dart';
import '../../controller/mainCubit/doctor_cubit.dart';
import '../../controller/mainCubit/doctor_state.dart';
import '../../widget/bottom_with_backgraund.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    startDelay();
  }

  goNext() {
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  Timer? timer;
  startDelay() {
    timer = Timer(const Duration(seconds: 3), goNext);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuussed) {
          return toast('Cheak your email');
        }
        if (state is ForgetPasswordError) {
          toast(state.massage.toString());
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, Routes.getStart);
                },
                icon: const Icon(Icons.keyboard_arrow_left),
                color: Colors.black,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('Forgot Your Password?',
                      style: GoogleFonts.inter(
                          fontSize: 30,
                          decorationStyle: TextDecorationStyle.dotted,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(
                      'Enter your email or your phone number, we will send you confirmation code',
                      style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 20,
                          decorationStyle: TextDecorationStyle.dotted,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Email is too short';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(25)),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        label: const Text('Enter your Email'),
                        labelStyle: GoogleFonts.inter(
                            decorationStyle: TextDecorationStyle.dotted,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        prefixIcon: Image.asset(IconManager.emailIcon)),
                  ),
                  BottomWithBackgraund(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        DoctorCubit.get(context).forgetPassword(
                          email: emailController.text,
                        );
                      }
                    },
                    text: 'Reset Password',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
