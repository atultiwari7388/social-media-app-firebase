import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/Widgets/custom_btn.widget.dart';
import 'package:instagram_clone/Widgets/custom_txt_btn.widget.dart';
import 'package:instagram_clone/Widgets/text_filed_input.dart';
import 'package:instagram_clone/screens/login.screen.dart';
import 'package:instagram_clone/utils/global_var.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
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
              SizedBox(height: 40),
              // Profile Screen

              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fyespunjab.com%2Fwp-content%2Fuploads%2F2019%2F06%2FAkshay-Kumar.jpg&f=1&nofb=1"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        IconlyLight.camera,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34),
              TextFieldInputWidget(
                hintText: "Username",
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
                icon: IconlyLight.profile,
              ),
              SizedBox(height: 24),
              TextFieldInputWidget(
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                icon: IconlyLight.message,
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
              TextFieldInputWidget(
                hintText: "Enter your bio",
                textInputType: TextInputType.text,
                textEditingController: _bioController,
                icon: IconlyLight.infoSquare,
              ),
              SizedBox(height: 24),
              CustomBtnWidget(
                btnName: "Create Account",
                onPressed: () => print("Login"),
              ),

              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Already have an account ? ",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  CustomTextButtonWidget(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                    textName: "Login",
                  ),
                ],
              ),
              // SizedBox(height: 40),
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
