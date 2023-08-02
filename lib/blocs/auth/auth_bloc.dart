import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mugit/pages/login_page.dart';

import '../../pages/home_page.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      // LoadingDialog.showLoadingDialog(event.context);
      yield AuthLoadingState();
      try {
        // Send the login request to the Django login API
        final response = await http.post(
          Uri.parse('http://192.168.1.10:8000/login/'),
          body: {
            'email': event.username,
            'password': event.password,
          },
        );

        if (response.statusCode == 200) {
          // LoadingDialog.hideLoadingDialog(event.context);
          // Login successful
          // Navigate to the home page
          Navigator.pushNamedAndRemoveUntil(
            event.context,
            HomePage.routeName,
            (route) => false,
          );

          yield AuthLoggedInState();
        } else {
          // Login failed
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final String errorMessage = responseData['error'] ?? 'Login failed.';
          yield AuthErrorState(errorMessage);
        }
      } catch (e) {
        // LoadingDialog.hideLoadingDialog(event.context);
        // Handle error
        yield AuthErrorState('Error occurred while logging in.');
      }
    } else if (event is RegisterEvent) {
      // LoadingDialog.showLoadingDialog(event.context);
      yield AuthLoadingState();
      try {
        // Send the registration request to the Django register API
        final response = await http.post(
          Uri.parse('http://192.168.1.10:8000/register/'),
          body: {
            'email': event.email,
            'password': event.password,
            'username': event.username
          },
        );
        // LoadingDialog.hideLoadingDialog(event.context);
        if (response.statusCode == 201) {
          // Registration successful
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(
              content: Text('Registered successfully'),
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            event.context,
            LoginPage.routeName,
            (route) => false,
          );
          yield AuthLoggedInState();
        } else {
          // Registration failed
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final String errorMessage =
              responseData['error'] ?? 'Registration failed.';
          yield AuthErrorState(errorMessage);
        }
      } catch (e) {
        // LoadingDialog.hideLoadingDialog(event.context);
        // Handle error
        yield AuthErrorState('Error occurred while registering.');
      }
    }
  }
}
