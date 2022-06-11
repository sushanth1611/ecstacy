part of 'onboard_cubit.dart';

abstract class OnboardState extends Equatable {
  const OnboardState();

  @override
  List<Object> get props => [];
}

class OnboardInitial extends OnboardState {}

class OnboardLoad extends OnboardState {}

class OnboardQ extends OnboardState {
  User user;

  OnboardQ({required this.user});
}

class OnboardHome extends OnboardState {
  User user;

  OnboardHome({
    required this.user,
  });
}

class OnboardRegister extends OnboardState {}

class OnboardError extends OnboardState {
  String msg;

  OnboardError({
    required this.msg,
  });
}

