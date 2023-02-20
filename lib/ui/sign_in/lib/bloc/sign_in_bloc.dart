import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network/network.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(SignInLoading());
      await NetworkManager.instance.signIn(event.email, event.password).onError(
        (error, stackTrace) {
          emit(
            SignInServerError(),
          );
          emit(SignInInitial());
        },
      ).then((value) {
        if (value != null) emit(SignInSuccess());
      }).whenComplete(
        () => emit(
          SignInInitial(),
        ),
      );
    });
  }
}
