library home_page;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetDataFromServerEvent()),
      child: Builder(builder: (ctx) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: BlocConsumer<HomeBloc, HomeState>(
              listener: (_, state) {
                if (state is HomeUnauthenticated) {
                  _.go('/');
                }
              },
              builder: (_, state) {
                switch (state.runtimeType) {
                  case HomeData:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Logged In as: ${(state as HomeData).data.data}'),
                          ElevatedButton(
                              onPressed: () async {
                                _.read<HomeBloc>().add(LogOutEvent());
                              },
                              child: Text('Log out'))
                        ],
                      ),
                    );
                  case HomeLoading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case HomeError:
                    return const Center(
                      child: Text('error'),
                    );
                  default:
                    return Container();
                }
              },
            ));
      }),
    );
  }
}
