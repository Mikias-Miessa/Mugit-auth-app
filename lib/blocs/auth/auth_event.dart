import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// import 'home_page.dart';
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  final BuildContext context;
  LoginEvent(this.username, this.password, this.context);

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final BuildContext context;

  RegisterEvent(this.email, this.password, this.context, this.username);

  @override
  List<Object> get props => [email, password, username];
}
