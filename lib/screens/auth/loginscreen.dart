import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/constants/color_constants.dart';
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: greyColor,
      appBar: AppBar(backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [greyColor, fieldColor],
            begin: Alignment.bottomRight,
            end: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 60),
                            Row(
                              children: [
                                Text(
                                  "Welcome To \nFuel Tracker App 🙌",
                                  style: GoogleFonts.unbounded(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 60),
                            CustomTextField(
                              controller: emailController,
                              backgroundColor: secondaryColor,
                              labelColor: primaryColor,
                              labelText: "Enter the E-mail",
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'E-mail required'
                                  : null,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: passwordController,
                              backgroundColor: secondaryColor,
                              labelColor: primaryColor,
                              labelText: "Enter the Password",
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'password required'
                                  : null,
                              keyboardType: TextInputType.text,
                              obsecureText: true,
                            ),
                            SizedBox(height: 30),
                            loading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 45),
                                      foregroundColor: primaryColor,
                                    ),

                                    onPressed: _loginUser,
                                    child: Text("LOG-IN"),
                                  ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 45),
                                backgroundColor: primaryColor,
                                foregroundColor: secondaryColor,
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
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
