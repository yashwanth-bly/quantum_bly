import 'package:core_ui/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginScreenType currentTab = LoginScreenType.login;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.rectangle,
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Social',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'X',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                )
              ],
            ),
          ),
          _ButtonsRow(
            currentTab: currentTab,
            onPageSelected: (LoginScreenType type) {
              setState(() {
                currentTab = type;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: currentTab == LoginScreenType.login
                ? LoginView(
                    onTapSignUp: () {
                      setState(() {
                        currentTab = LoginScreenType.signup;
                      });
                    },
                  )
                : const SignupView(),
          ),
        ],
      ),
    );
  }
}

class _ButtonsRow extends StatelessWidget {
  const _ButtonsRow({
    required this.onPageSelected,
    this.currentTab = LoginScreenType.login,
  });
  final Function(LoginScreenType) onPageSelected;
  final LoginScreenType currentTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleButton(
              name: 'Login',
              selected: currentTab == LoginScreenType.login,
              onTap: () {
                onPageSelected(LoginScreenType.login);
              },
            ),
          ),
          Expanded(
            child: _ToggleButton(
              name: 'Sign up',
              selected: currentTab == LoginScreenType.signup,
              onTap: () {
                onPageSelected(LoginScreenType.signup);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.name,
    this.selected = false,
    required this.onTap,
  });
  final Function() onTap;
  final String name;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: selected ? Colors.red : null,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        child: Center(
            child: Text(
          name,
          style: TextStyle(color: selected ? Colors.white : null),
        )),
      ),
    );
  }
}
