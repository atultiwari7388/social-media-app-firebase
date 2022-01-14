import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Widgets/custom_btn.widget.dart';
import 'package:instagram_clone/Widgets/custom_txt_btn.widget.dart';
import 'package:instagram_clone/Widgets/text_filed_input.dart';
import 'package:instagram_clone/utils/global_var.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              buildAppHeading(),
              SizedBox(height: 60),
              TextFieldInputWidget(
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                icon: IconlyLight.profile,
              ),
              SizedBox(height: 24),
              TextFieldInputWidget(
                hintText: "Enter your password",
                textInputType: TextInputType.visiblePassword,
                textEditingController: _passwordController,
                isPass: true,
                icon: IconlyLight.password,
              ),
              SizedBox(height: 24),
              CustomBtnWidget(
                btnName: "Login",
                onPressed: () => print("Login"),
              ),
              SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Don't have an account ? ",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  CustomTextButtonWidget(
                    onTap: () => print("SignUp Screen"),
                    textName: "Create Account",
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Text buildAppHeading() {
    return Text(
      APPNAME,
      style: GoogleFonts.acme(
        fontSize: 35,
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
