import 'package:core/bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key, required this.onTapSignUp});
  final VoidCallback onTapSignUp;

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String? invalidEmail;

  String? weakPassword;
  String? invalidPhoneNumber;

  late final TextEditingController userNameController1;

  late final TextEditingController passwordController1;
  late bool click = false;

  @override
  void initState() {
    super.initState();
    userNameController1 = TextEditingController();
    passwordController1 = TextEditingController();
  }

  @override
  void dispose() {
    userNameController1.dispose();
    passwordController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 25),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.red,
                    ),
                  ),
                  const TextField(
                    // controller: userNameController1,
                    // obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'John deo',
                      enabledBorder: UnderlineInputBorder(),
                      labelText: 'Name',
                      suffix: Icon(
                        Icons.person_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextField(
                    controller: userNameController1,
                    // obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Johndeo@gmail.com',
                      errorText: invalidEmail,
                      enabledBorder: const UnderlineInputBorder(),
                      labelText: 'Email',
                      suffix: const Icon(
                        Icons.email_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextField(
                    //controller: passwordController1,
                    //obscureText: true,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Phone Number',
                      errorText: invalidPhoneNumber,
                      hintText: "9876543210",
                      suffix: const Icon(
                        Icons.phone,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextField(
                    controller: passwordController1,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Password',
                      errorText: weakPassword,
                      hintText: "Password",
                      suffix: const Icon(
                        Icons.lock_outline,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (click == true) {
                              click = false;
                            } else {
                              click = true;
                            }
                          });
                        },
                        icon: click == true
                            ? const Icon(
                                Icons.check_box,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.check_box_outline_blank_outlined,
                                color: Colors.red,
                              ),
                      ),
                      const Text.rich(
                        TextSpan(
                          text: 'I agree with ',
                          style: TextStyle(fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'terms and conditions',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTapSignUp,
                        child: const Text(
                          'Sign in!',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        LoginButton(onTap: () => _onTapRegister(context), name: 'Register')
      ],
    );
  }

  void _onTapRegister(BuildContext context) {
    context.read<LoginCubit>().signup(
          email: userNameController1.text,
          password: passwordController1.text,
        );
  }
}
