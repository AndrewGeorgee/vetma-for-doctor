import 'package:doctor_of_vetma/presentaion/controller/mainCubit/doctor_cubit.dart';
import 'package:doctor_of_vetma/presentaion/controller/mainCubit/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../core/resources/assets_manger.dart';
import '../../../core/resources/colors.dart';
import '../../../core/resources/routes_manager.dart';
import '../../widget/bottom_with_backgraund.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool isShowPassword = true;
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is CredentialSuccess) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            body: SizedBox(
              height: 280,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Yeay! Welcome Back',
                    style: GoogleFonts.inter(
                        color: ColorManager.prymaryColor,
                        fontSize: 30,
                        decorationStyle: TextDecorationStyle.dotted,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Once again you login successfully into medidoc app',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 20,
                      decorationStyle: TextDecorationStyle.dotted,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BottomWithBackgraund(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, Routes.mainScreenRoute);
                      },
                      text: 'Go to home'),
                ],
              ),
            ),

            titleTextStyle: GoogleFonts.inter(
                color: ColorManager.prymaryColor,
                fontSize: 30,
                decorationStyle: TextDecorationStyle.dotted,
                fontWeight: FontWeight.bold),

            descTextStyle: GoogleFonts.inter(
              fontSize: 15,
              decorationStyle: TextDecorationStyle.dotted,
            ),
            //   autoHide: const Duration(seconds: 30),
            onDismissCallback: (type) {
              debugPrint('Dialog Dissmiss from callback $type');
            },
          ).show();
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
              centerTitle: true,
              title: Text('Login',
                  style: GoogleFonts.inter(
                      color: ColorManager.prymaryColor,
                      fontSize: 25,
                      decorationStyle: TextDecorationStyle.dotted,
                      fontWeight: FontWeight.bold)),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 55,
                      child: Image(
                        image: AssetImage(
                          AssetsManager.logo,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: Text('OF DOCTOR',
                          style: GoogleFonts.courgette(
                              color: ColorManager.prymaryColor,
                              fontSize: 30,
                              decorationStyle: TextDecorationStyle.dotted,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Email is too short';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25)),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          label: const Text('Enter your email'),
                          labelStyle: GoogleFonts.inter(
                              decorationStyle: TextDecorationStyle.dotted,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          prefixIcon: Image.asset(IconManager.emailIcon)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'password is too short';
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
                          label: const Text('Enter your password'),
                          labelStyle: GoogleFonts.inter(
                              decorationStyle: TextDecorationStyle.dotted,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          suffixIcon: Image.asset(IconManager.eyeIcon),
                          prefixIcon: Image.asset(IconManager.passwordIcon)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.forgetPasswordRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.inter(
                                color: ColorManager.prymaryColor,
                                fontSize: 15,
                                decorationStyle: TextDecorationStyle.dotted,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: BottomWithBackgraund(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            DoctorCubit.get(context).signInAsDoctorSubmit(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        text: 'login',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.registerRoute);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t have an account?',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 15),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign Up ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.prymaryColor)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 1.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          '  OR  ',
                          style: GoogleFonts.inter(
                              color: ColorManager.prymaryColor,
                              fontSize: 20,
                              decorationStyle: TextDecorationStyle.dotted,
                              fontWeight: FontWeight.w700),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 1.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(IconManager.googleIcon)),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0) //
                                    ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(IconManager.facebookIcon)),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0) //
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
