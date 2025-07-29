import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/auth/registerscreen.dart';
import 'package:task/screens/tripinputscreen.dart';
import 'package:task/widgets/textfield.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => TripInputScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Log-In failed')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  Text(
                    "Welcome To Fuel Economy\n& Mileage Tracker App 🙌",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              CustomTextField(
                controller: emailController,
                labelColor: Colors.white,
                labelText: "Enter the E-mail",
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'E-mail required'
                    : null,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: passwordController,
                labelColor: Colors.white,
                labelText: "Enter the Password",
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'password required'
                    : null,
                keyboardType: TextInputType.text,
                obsecureText: true,
              ),
              SizedBox(height: 30),
              loading
                  ? CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 45),
                            foregroundColor: Colors.black,
                          ),

                          onPressed: _loginUser,
                          child: Text("LOG-IN"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 45),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registerscreen(),
                              ),
                            );
                          },
                          child: Text("Register"),
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
