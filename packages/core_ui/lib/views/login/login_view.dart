import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    required this.onTapSignUp,
  });

  final VoidCallback onTapSignUp;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? userNameError;

  String? passwordError;

  late final TextEditingController userNameController;

  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 5.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 5  horizontally
                    5.0, // Move to bottom 5 Vertically
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'SignIn into your account',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: userNameController,
                    // obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Johndeo@gmail.com',
                      errorText: userNameError,
                      enabledBorder: const UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Password',
                        errorText: passwordError,
                        hintText: "Password"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 24),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.red),
                  ),
                ),
                const Text(
                  'Login with',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<LoginCubit>().googleSignIn();
                        },
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset('assets/img.png')),
                      ),
                      // const SizedBox(
                      //   width: 30,
                      // ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: SizedBox(
                      //       height: 30,
                      //       width: 30,
                      //       child: Image.asset('assets/img_1.png')),
                      // ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTapSignUp,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        LoginButton(onTap: () => _onTapSubmit(context), name: 'Login')
      ],
    );
  }

  void _onTapSubmit(BuildContext context) {
    context.read<LoginCubit>().login(
          email: userNameController.text,
          password: passwordController.text,
        );
  }
}
