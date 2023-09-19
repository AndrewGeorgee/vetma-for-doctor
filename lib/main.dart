// ignore_for_file: unused_import

import 'package:doctor_of_vetma/presentaion/controller/auth/auth_cubit.dart';
import 'package:doctor_of_vetma/presentaion/controller/auth/auth_state.dart';
import 'package:doctor_of_vetma/presentaion/screen/main_screen/main_screen.dart';
import 'package:doctor_of_vetma/presentaion/screen/settings/add_appointment.dart';
import 'package:doctor_of_vetma/presentaion/screen/settings/all_appointment_screen.dart';
import 'package:doctor_of_vetma/presentaion/screen/settings/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/resources/bloc_observer.dart';
import 'core/resources/routes_manager.dart';
import 'injection_container.dart';
import 'presentaion/controller/mainCubit/doctor_cubit.dart';
import 'presentaion/screen/app_start/splach_screen.dart';

void main() async {
  await ServicesLocator().init();
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<DoctorCubit>(create: (_) => sl<DoctorCubit>()),
      ],
 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //  home: const AllAppointment(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerateor.getRoute,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return const MainScreen();
                } else {
                  return const SplachScreen();
                }
              },
            );
          }
        },
      ),
    );
  }
}
