import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network/network.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      await NetworkManager.instance.signUp(event.email, event.password).onError(
        (error, stackTrace) {
          emit(
            SignUpServerError(),
          );
          emit(SignUpInitial());
        },
      ).then((value) {
        if (value != null) emit(SignUpSuccess());
      }).whenComplete(
        () => emit(
          SignUpInitial(),
        ),
      );
    });
  }
}
