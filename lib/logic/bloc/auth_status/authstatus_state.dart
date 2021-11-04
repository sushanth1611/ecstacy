part of 'authstatus_cubit.dart';

abstract class AuthstatusState extends Equatable {
  const AuthstatusState();

  @override
  List<Object> get props => [];
}

class unautheticated extends AuthstatusState {}

class Authenticated extends AuthstatusState {
  User user;
  Authenticated({
    required this.user,
  });
}