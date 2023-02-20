import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network/network.dart';
import 'package:network/objects/data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<GetDataFromServerEvent>((event, emit) async {
      try {
        var data = await NetworkManager.instance.getDataFromServer();
        if (data != null) {
          emit(
            HomeData(data),
          );
        }
      } catch (e) {
        if (e.toString() == Exception('403 exception').toString()) {
          emit(HomeUnauthenticated());
        } else {
          emit(HomeError());
        }
      }
    });

    on<LogOutEvent>(
      (event, emit) async {
        await NetworkManager.instance
            .logOut()
            .onError((Exception error, stackTrace) {
          if (error.toString() == '403 exception') {
            emit(HomeUnauthenticated());
          } else {
            emit(HomeError());
          }
        }).then(
          (value) => emit(
            HomeUnauthenticated(),
          ),
        );
      },
    );
  }
}
