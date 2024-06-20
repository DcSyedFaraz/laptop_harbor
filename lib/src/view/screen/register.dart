import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _toggleFormType() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (isLogin) {
          await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
        } else {
          await _auth.createUserWithEmailAndPassword(
              email: _email, password: _password);
        }
      } catch (e) {
        // Handle errors here
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isLogin ? 'Login' : 'Register',
                    style: const TextStyle(
                        fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) =>
                        value!.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => _email = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Password can\'t be empty' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(isLogin ? 'Login' : 'Register'),
                  ),
                  TextButton(
                    onPressed: _toggleFormType,
                    child: Text(
                      isLogin ? 'Create an account' : 'Have an account? Login',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
