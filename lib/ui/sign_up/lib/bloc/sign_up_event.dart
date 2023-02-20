part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  final String email;
  final String password;
  const SignUpEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
