library sign_up_page;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_up/bloc/sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController =
      TextEditingController(text: 'test@mail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123321qweffff');
  final TextEditingController _emailController2 =
      TextEditingController(text: 'test@mail.com');
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFormKey2 = GlobalKey<FormFieldState>();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (ctx) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign Up'),
          ),
          body: BlocListener<SignUpBloc, SignUpState>(
            listener: (_, state) {
              if (state is SignUpSuccess) {
                _.go('/root/home');
              }
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextFormField(
                      controller: _emailController,
                      key: _emailFormKey,
                      decoration: InputDecoration(hintText: 'email'),
                      validator: (value) {
                        var r = RegExp(
                            r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$');
                        if (r.hasMatch(value!)) {
                          return null;
                        } else {
                          return 'Email is not valid';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextFormField(
                      controller: _emailController2,
                      key: _emailFormKey2,
                      decoration: InputDecoration(hintText: 'email'),
                      validator: (value) {
                        {
                          var r = RegExp(
                              r'^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$');
                          if (value != _emailController2.text) {
                            return "Emails don't match";
                          }
                          if (r.hasMatch(value!)) {
                            return null;
                          } else {
                            return 'Email is not valid';
                          }
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      key: _passwordFormKey,
                      decoration:
                          InputDecoration(hintText: 'Type in your password'),
                      validator: (value) {
                        {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          if (value.length > 20) {
                            return "Password must be less than 20 characters";
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return "Password must contain a number";
                          }
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: () => {
                        if (_passwordFormKey.currentState!.validate() &&
                            _emailFormKey2.currentState!.validate() &&
                            _emailFormKey.currentState!.validate() &&
                            _emailController.text == _emailController2.text)
                          {
                            ctx.read<SignUpBloc>().add(SignUpEvent(
                                _emailController.text,
                                _passwordController.text))
                            //TODO: Move this to method
                            //TODO: Add indication of error
                          }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
