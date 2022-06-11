import 'package:bloc_custom_firebase/logic/bloc/auth_status/authstatus_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/gender_cubit/gender_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/location_cubit/location_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/logout/logout_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/number_cubit/numbercubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/onboard/onboard_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/question_controller/question_controller_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/splash/splashscreen_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/theme_cubit/theme_cubit.dart';
import 'package:bloc_custom_firebase/router.dart';
import 'package:bloc_custom_firebase/services/fb_auth_service.dart';
import 'package:bloc_custom_firebase/services/fb_db.dart';
import 'package:bloc_custom_firebase/services/location_serice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/bloc/google_register/google_register_cubit.dart';
import 'logic/bloc/google_register/invite_controller/invite_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GenderCubit()),
        BlocProvider(
            create: (context) => SplashscreenCubit(
                fb_service: FB_Service(), dataBaseService: DataBaseService())),
        BlocProvider(
            create: (context) => LogoutCubit(repossitory: FB_Service())),
        BlocProvider(
            create: (context) => OnboardCubit(
                fb: FB_Service(), dataBaseService: DataBaseService())),
        BlocProvider(
          create: (context) => GoogleRegisterCubit(
              fb_service: FB_Service(), dataBaseService: DataBaseService()),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
            create: (context) =>
                InviteCubit(dataBaseService: DataBaseService())),
        BlocProvider(
            lazy: true,
            create: (context) =>
                LocationCubit(locationService: LocationService())),
        BlocProvider(
            create: (context) => NumberRegistercubit(fb_service: FB_Service())),
        BlocProvider(create: (context) => AuthstatusCubit()),
        BlocProvider(create: (context) => QuestionControllerCubit()),
      ],
      child:
          BlocBuilder<ThemeCubit, ThemeState>(builder: (context, themestate) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          onGenerateRoute: appRouter.onGenerateRoute,
          theme: themestate.themeData,
        );
      }),
    );
  }
}
