import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_of_vetma/presentaion/widget/all_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/resources/icon_broken.dart';
import '../../../data/database/remote_data_source.dart';
import '../../../data/models/doctor_model.dart';
import '../../controller/mainCubit/doctor_cubit.dart';
import '../../widget/bottom_with_backgraund.dart';
import '../../widget/tost.dart';

class EditRofileScreen extends StatefulWidget {
  const EditRofileScreen({super.key});

  @override
  State<EditRofileScreen> createState() => _EditRofileScreenState();
}

class _EditRofileScreenState extends State<EditRofileScreen> {
  File? _image;
  final picker = ImagePicker();
  String? profileUrl;
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DoctorCubit.get(context)
          .getInformation(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          var nameController = TextEditingController(text: user.name);
          var locationController = TextEditingController(text: user.location);
          var bioController = TextEditingController(text: user.bio);
          var phoneController = TextEditingController(text: user.number);
          var prieseController = TextEditingController(text: user.fee);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: leadingBottom(onPressed: () {}),
            ),
            body: SafeArea(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      textHedaer(text: 'Edit Profile'),
                      const SizedBox(height: 5),
                      Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: Container(
                                height: 110,
                                width: 110,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(55)),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(60)),
                                  child: profileWidget(
                                      imageUrl: user.phote, image: _image),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                          ]),
                      const SizedBox(height: 10),
                      textFormFiled(
                          controller: nameController, text: 'Full Name'),
                      const SizedBox(height: 5 + 5),
                      textFormFiled(controller: bioController, text: 'Bio'),
                      const SizedBox(height: 5 + 5),
                      textFormFiled(
                          controller: locationController, text: 'Location'),
                      const SizedBox(height: 5 + 5),
                      textFormFiled(
                          controller: prieseController, text: 'Prises'),
                      const SizedBox(height: 5 + 5),
                      textFormFiled(
                          controller: phoneController, text: 'Number '),
                      const SizedBox(height: 20 + 5),
                      Center(
                        child: BottomWithBackgraund(
                          onPressed: () {
                            BlocProvider.of<DoctorCubit>(context).getUpdateUser(
                              user: Doctors(
                                id: FirebaseAuth.instance.currentUser!.uid,
                                phote: profileUrl ?? user.phote,
                                name: nameController.text,
                                bio: bioController.text,
                                location: locationController.text,
                                fee: prieseController.text,
                                number: phoneController.text,
                              ),
                            );
                          },
                          text: 'Update',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          );
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  // void _updateProfile() {
  //   BlocProvider.of<DoctorCubit>(context).getUpdateUser(
  //     user: Doctors(
  //       id: FirebaseAuth.instance.currentUser!.uid,
  //       phote: profileUrl!,
  //       name: nameController.text,
  //     ),
  //   );
  //   toast("Profile Updated");
  // }

  Widget profileWidget({String? imageUrl, File? image}) {
    print("image value $image");
    if (image == null) {
      if (imageUrl == null) {
        return Image.asset(
          'assets/doctor/onboarding2.png',
          // fit: BoxFit.cover,
        );
      } else {
        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
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

  Widget textFormFiled({
    required TextEditingController controller,
    required String text,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            text,
            style: GoogleFonts.inter(
                decorationStyle: TextDecorationStyle.dotted,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(25)),
            filled: true,
            focusColor: Colors.transparent,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            labelStyle: GoogleFonts.inter(
                decorationStyle: TextDecorationStyle.dotted,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
