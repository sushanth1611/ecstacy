import 'package:bloc/bloc.dart';
import 'package:bloc_custom_firebase/logic/models/user_model.dart';
import 'package:bloc_custom_firebase/services/exceptions.dart';
import 'package:bloc_custom_firebase/services/fb_auth_service.dart';
import 'package:bloc_custom_firebase/services/fb_db.dart';
import 'package:equatable/equatable.dart';

part 'onboard_state.dart';

class OnboardCubit extends Cubit<OnboardState> {
  FB_Service fb;
  DataBaseService dataBaseService;

  OnboardCubit({required this.fb, required this.dataBaseService})
      : super(OnboardInitial());

  void signinwithgoogle() async {
    emit(OnboardLoad());
    try {
      bool status = await fb.signInWithGoogle();

      if (status) {
        var user_email = fb.get_user_email();
        bool user = await dataBaseService.verifygoogleuser(user_email);
        print(user);
        if (user) {
          //if an doly if the user exsits
          var user_map = await dataBaseService.getusermap(user_email);
          var user_obj = User.frommap(user_map);
          if (user_obj.attemptedques)
            emit(OnboardHome(user: user_obj));
          else
            emit(OnboardQ(user: user_obj));
        } else
          emit(OnboardRegister());
      }
    } on GoogleLoginError catch (e) {
      emit(OnboardError(msg: e.prefix));
    } on EmailDNError catch (e) {
      print("I am here");
      emit(OnboardError(msg: e.message));
    }
  }

  void reload() {
    print("In reload");
    emit(OnboardInitial());
  }
}
