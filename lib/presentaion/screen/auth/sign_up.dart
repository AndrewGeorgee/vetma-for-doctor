import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_of_vetma/presentaion/controller/mainCubit/doctor_cubit.dart';
import 'package:doctor_of_vetma/presentaion/controller/mainCubit/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/resources/assets_manger.dart';
import '../../../core/resources/colors.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../data/database/remote_data_source.dart';
import '../../../data/models/doctor_model.dart';
import '../../widget/bottom_with_backgraund.dart';
import '../../widget/tost.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var feeController = TextEditingController();
  var locationController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var numberOfPhoneController = TextEditingController();

  final passwordController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  String profileUrl = '';
  var confirmPasswordController = TextEditingController();
  bool box = false;
  Future getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          StorageProviderRemoteDataSource.uploadFile(file: _image!)
              .then((value) {
            log('profileUrl');
            print("profileUrl");
            setState(() {
              profileUrl = value;
            });
          });
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  void showDate() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030));
  }

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
                    'Success',
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
                    'Your account has been successfully registered',
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
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      text: 'Login'),
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
              title: Text('Sign Up',
                  style: GoogleFonts.inter(
                      color: ColorManager.prymaryColor,
                      fontSize: 30,
                      decorationStyle: TextDecorationStyle.dotted,
                      fontWeight: FontWeight.bold)),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Name is too short';
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
                            label: const Text('Enter your name'),
                            labelStyle: GoogleFonts.inter(
                                decorationStyle: TextDecorationStyle.dotted,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                            prefixIcon: Image.asset(IconManager.userIcon)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        controller: passwordController,
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
                        height: 15,
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
                            label: const Text('Enter your Email'),
                            labelStyle: GoogleFonts.inter(
                                decorationStyle: TextDecorationStyle.dotted,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                            prefixIcon: Image.asset(IconManager.emailIcon)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        controller: bioController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(25)),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            label: const Text('Enter your bio'),
                            labelStyle: GoogleFonts.inter(
                                decorationStyle: TextDecorationStyle.dotted,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                            prefixIcon: Image.asset(IconManager.emailIcon)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        controller: locationController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(25)),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            label: const Text('Enter your location'),
                            labelStyle: GoogleFonts.inter(
                                decorationStyle: TextDecorationStyle.dotted,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(Icons.location_on_outlined)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        controller: phoneController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(25)),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            label: const Text('Enter your Phone'),
                            labelStyle: GoogleFonts.inter(
                                decorationStyle: TextDecorationStyle.dotted,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(Icons.phone)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: feeController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone is too short';
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
                          label: const Text('Enter your fee'),
                          labelStyle: GoogleFonts.inter(
                              decorationStyle: TextDecorationStyle.dotted,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.attach_money),
                        ),
                      ),
                      ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        leading: Checkbox(
                          activeColor: ColorManager.prymaryColor,
                          side: const BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey,
                              strokeAlign: BorderSide.strokeAlignInside),
                          value: box,
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.5))),
                          onChanged: (value) {
                            setState(() {
                              box = box == false ? true : false;
                            });
                          },
                        ),
                        title: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "By checking this box, you are agreeing to",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "our terms of service",
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                  color: HexColor('65399A')),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: BottomWithBackgraund(
                          onPressed: () {
                            if (passwordController.text.isEmpty) {
                              toast('enter your username');
                              return;
                            }
                            if (passwordController.text.isEmpty) {
                              toast('enter your email');
                              return;
                            }
                            if (passwordController.text.isEmpty) {
                              toast('enter your password');
                              return;
                            }
                            if (passwordController.text.isEmpty) {
                              toast('enter your again password');
                              return;
                            }

                            DoctorCubit.get(context).signUpDoctrSubmit(
                                doctors: Doctors(
                              bio: bioController.text,
                              email: emailController.text,
                              fee: feeController.text,
                              location: locationController.text,
                              name: nameController.text,
                              password: passwordController.text,
                              phote: profileUrl,
                              number: phoneController.text,
                            ));
                          },
                          text: 'Sign up',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: ' have an account?',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Login ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.prymaryColor)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget profileWidget({String? imageUrl, File? image}) {
    print("image value $image");
    if (image == null) {
      if (imageUrl == null) {
        return Image.asset(
          'assets/logo/profile_default.png',
          fit: BoxFit.cover,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl,
          // fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const CircularProgressIndicator())),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
    } else {
      return Image.file(
        image,
        fit: BoxFit.cover,
      );
    }
  }
}
