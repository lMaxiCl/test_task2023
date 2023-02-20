part of 'sign_in_bloc.dart';

class SignInEvent extends Equatable {
  final String email;
  final String password;
  const SignInEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
