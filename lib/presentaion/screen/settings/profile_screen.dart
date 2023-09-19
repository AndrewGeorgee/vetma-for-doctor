import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_of_vetma/data/models/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/resources/assets_manger.dart';
import '../../../core/resources/colors.dart';
import '../../../core/resources/icon_broken.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../data/database/remote_data_source.dart';
import '../../controller/mainCubit/doctor_cubit.dart';
import '../../widget/bottom_with_backgraund.dart';
import '../../widget/tost.dart';

class ProfleScrren extends StatefulWidget {
  const ProfleScrren({super.key});

  @override
  State<ProfleScrren> createState() => _ProfleScrrenState();
}

class _ProfleScrrenState extends State<ProfleScrren> {
  File? _image;
  final picker = ImagePicker();
  String? profileUrl;
  Future getImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

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

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              IconManager.emailIcon,
                              width: 30,
                              height: 40,
                              color: ColorManager.prymaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(user.email!,
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              IconManager.userIcon,
                              width: 30,
                              height: 40,
                              color: ColorManager.prymaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(user.bio!,
                                style: GoogleFonts.inter(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 30, color: ColorManager.prymaryColor),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              user.location!,
                              style: GoogleFonts.inter(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(Icons.phone,
                                size: 30, color: ColorManager.prymaryColor),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              user.number!,
                              style: GoogleFonts.inter(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_image != null)
                    Center(
                      child: BottomWithBackgraund(
                        onPressed: () {
                          _updateProfile();
                        },
                        text: 'Update',
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: BottomWithBackgraund(
                      onPressed: () {
                        BlocProvider.of<DoctorCubit>(context).loggedOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.splashRoute, (route) => false);
                      },
                      text: 'L O G O U T',
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  void _updateProfile() {
    BlocProvider.of<DoctorCubit>(context).getUpdateUser(
      user: Doctors(
        id: FirebaseAuth.instance.currentUser!.uid,
        phote: profileUrl!,
      ),
    );
    toast("Profile Updated");
  }

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

  Widget startScreen(Doctors user) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: ColorManager.profile,
            border: Border.all(
              color: ColorManager.profile,
              width: 5.0,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(55)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60)),
                        child:
                            profileWidget(imageUrl: user.phote, image: _image),
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
                const SizedBox(
                  width: 10,
                ),
                Text(
                  user.name!,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
