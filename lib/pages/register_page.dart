// register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/register';
  @override
  Widget build(BuildContext context) {
    final double registerTextSize = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/sign_up.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: registerTextSize,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 85)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BlocProvider(
                      create: (context) => AuthBloc(),
                      child: RegisterForm(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    final double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    final double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    final double sizedBoxHeight = MediaQuery.of(context).size.height * 0.008;

    final IconData emailIcon = Icons.email_outlined;
    final IconData passwordIcon = Icons.lock_outline_rounded;

    final double iconOpacity = 0.4;
    final double inputFieldOpacity = 0.6;

    final TextStyle buttonTextStyle =
        TextStyle(fontWeight: FontWeight.w800, fontSize: 16);

    final TextStyle linkButtonStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Opacity(
                opacity: iconOpacity,
                child: Icon(emailIcon),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Opacity(
                  opacity: inputFieldOpacity,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: sizedBoxHeight),
          Row(
            children: [
              Opacity(
                opacity: iconOpacity,
                child: Icon(Icons.person_outline),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Opacity(
                  opacity: inputFieldOpacity,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: ' Username',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: sizedBoxHeight),
          Row(
            children: [
              Opacity(
                opacity: iconOpacity,
                child: Icon(passwordIcon),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Opacity(
                  opacity: inputFieldOpacity,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ),
              ),
            ],
          ),

          // New confirm password field
          SizedBox(height: sizedBoxHeight),
          Row(
            children: [
              Opacity(
                opacity: iconOpacity,
                child: Icon(passwordIcon),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Opacity(
                  opacity: inputFieldOpacity,
                  child: TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Connecting...',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                );
              } else if (state is AuthErrorState) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          SizedBox(height: sizedBoxHeight),
          Wrap(
            alignment: WrapAlignment.start, // Horizontal alignment
            crossAxisAlignment: WrapCrossAlignment.center, // Vertical alignment
            runSpacing:
                -15, // Adjust this value to control vertical spacing between lines
            children: [
              Text(
                'By signing in you agree to our',
                style: TextStyle(color: Color.fromARGB(222, 145, 145, 145)),
              ),
              SizedBox(width: 2),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Terms & Conditions',
                  style: linkButtonStyle,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                'and',
                style: TextStyle(color: Color.fromARGB(222, 145, 145, 145)),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Privacy Policy',
                  style: linkButtonStyle,
                ),
              ),
            ],
          ),
          SizedBox(height: sizedBoxHeight),
          Container(
            width: buttonWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: () {
                final String email = _emailController.text;
                final String password = _passwordController.text;
                final String username = _usernameController.text;
                final String confirmPassword = _confirmPasswordController.text;

                if (password == confirmPassword) {
                  authBloc.add(RegisterEvent(
                    email,
                    password,
                    context,
                    username,
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Password and Confirm Password must match!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Sign Up',
                style: buttonTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: sizedBoxHeight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(188, 117, 117, 117)),
              ),
              SizedBox(
                width: 5,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginPage.routeName,
                    (route) => false,
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Login',
                  style: linkButtonStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
