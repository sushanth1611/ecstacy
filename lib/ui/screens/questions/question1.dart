import 'package:bloc_custom_firebase/logic/bloc/google_register/google_register_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/question_controller/question_controller_cubit.dart';
import 'package:bloc_custom_firebase/logic/bloc/theme_cubit/theme_cubit.dart';
import 'package:bloc_custom_firebase/ui/screens/google_register/widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class Question1 extends StatefulWidget {
  const Question1({Key? key}) : super(key: key);

  @override
  _Question1State createState() => _Question1State();
}

//Question about bio
class _Question1State extends State<Question1> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocListener<GoogleRegisterCubit, GoogleRegisterState>(
      listener: (context, state) {
        if (state is GoogleRegisterInitial) {
        } else if (state is GoogleRegisterInterupt) {
          Navigator.pushReplacementNamed(context, FRONT_PAGE);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<ThemeCubit>(context).changetheme();
          },
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<GoogleRegisterCubit>(context).logout();
              },
              icon: Icon(FontAwesomeIcons.powerOff),
            )
          ],
          centerTitle: true,
          title: Text("Ecstacy"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height / 7,
                width: width,
                child: Center(
                    child: Text(
                  "get onboard with us",
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w700),
                )),
              ),
              Container(
                height: height / 2,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                      key: formkey,
                      child: Container(
                        height: (height / (2.5)) * 0.6,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("enter your bio",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                            Text("pls keep it smol and accurate",
                                style: GoogleFonts.montserrat(
                                    fontSize: 13, fontWeight: FontWeight.w400)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.length < 5)
                                    return "enter at leat 5 characters";
                                  else if (value.length >= 20)
                                    return "bio must be <20 characters";
                                  else
                                    return null;
                                },
                                onSaved: (value) {
                                  BlocProvider.of<QuestionControllerCubit>(
                                          context)
                                      .data["bio"] = value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: (height / (2.5)) * 0.4,
                      child: ProgressBar(n: 6, page: 1),
                    )
                  ],
                ),
              ),
              Container(
                height: height / 8,
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                child: InkWell(
                  onTap: () {
                    final isValid = formkey.currentState!.validate();
                    if (isValid) {
                      formkey.currentState!.save();
                      Navigator.pushReplacementNamed(context, QUESTION2);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Next   ",
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Icon(FontAwesomeIcons.signInAlt)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
