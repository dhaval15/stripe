import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:extras/extras.dart';
import 'package:stripe/src/api/api.dart';
import 'package:stripe/src/widgets/widgets.dart';
import 'package:toast/toast.dart';

import 'screens.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailIdController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox().expand(2),
                Text(
                  'Login',
                  style: context.headline4,
                ).center(),
                SizedBox().expand(1),
                TextFormField(
                  controller: _emailIdController,
                  decoration: InputDecoration(
                    labelText: 'EmailId',
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 24),
                FlatButton(
                  color: context.primary,
                  child: Text('Login').textColor(context.canvas),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => LoadingDialog());
                    final result = await AuthApi().signIn(
                        _emailIdController.text, _passwordController.text);
                    Navigator.of(context).pop();
                    if (result is User) {
                      Navigator.of(context).pushReplacementNamed(Screens.HOME);
                    } else
                      Toast.show(result.toString(), context);
                  },
                ),
                SizedBox().expand(2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
