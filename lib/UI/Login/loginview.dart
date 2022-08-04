import 'package:auth_service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/homeview.dart';
import '../signup/signupview.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 68),
                      child: Image.asset(
                        'assets/images/leaffill.png',
                        height: 110,
                        width: 110,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Masukan Identittas akun anda',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Isikan identitas data pribadi anda di akun ini dengan benar',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    'Email atau Nomor Telephone',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                _LoginEmail(emailController: _emailController),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    'Kata Sandi',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                _LoginPassword(passwordController: _passwordController),
                const SizedBox(height: 30.0),
                _SubmitButton(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
                const SizedBox(height: 30.0),
                _CreateAccountButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginEmail extends StatelessWidget {
  _LoginEmail({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Masukan Email'),
        ),
      ),
    );
  }
}

class _LoginPassword extends StatelessWidget {
  _LoginPassword({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: TextField(
          obscureText: true,
          controller: passwordController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukan Password password'),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  _SubmitButton({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  final String email, password;
  final AuthService _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 343,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          onPressed: () async {
            try {
              await _authService.signInWithEmailAndPassword(
                email: email,
                password: password,
              );
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SignUpView(),
          ),
        );
      },
      child: const Text('Create Account'),
    );
  }
}
