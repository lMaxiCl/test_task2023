import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/ui/home/lib/home_page_root.dart';
import 'package:test_task/ui/sign_in/lib/siggn_in_page_root.dart';
import 'package:test_task/ui/sign_up/lib/sign_up_page_root.dart';
import 'package:test_task/ui/theme_setup_util.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  late final StreamSubscription _authSubscription;
  // String _redirectRoute = '/root/home';

  @override
  void initState() {
    // _authSubscription = NetworkManager.authStream.listen((event) {
    //   if (event != null) {
    //     setState(() {
    //       _redirectRoute = '/root/home';
    //     });
    //   } else {
    //     setState(() {
    //       _redirectRoute = '/';
    //     });
    //   }
    // }, onError: (user, stacktrace) => print('error'));
    super.initState();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeSetupUtil.setupTheme(),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const InitialPage(),
            // redirect: (context, state) => _redirectRoute,
          ),
          GoRoute(
            path: '/root/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => SignInPage(),
          ),
          GoRoute(
            path: '/signup',
            builder: (context, state) => SignUpPage(),
          ),
        ],
      ),
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () => context.go('/login'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: ElevatedButton(
                  child: const Text('SignUp'),
                  onPressed: () => context.go('/signup'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
