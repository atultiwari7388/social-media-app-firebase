import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Widgets/custom_btn.widget.dart';
import 'package:instagram_clone/Widgets/custom_txt_btn.widget.dart';
import 'package:instagram_clone/Widgets/text_filed_input.dart';
import 'package:instagram_clone/resources/auth_method.resource.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/res_layout.screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login.screen.dart';
import 'package:instagram_clone/utils/global_var.dart';
import 'package:instagram_clone/utils/utils.dart';

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
  final TextEditingController _nameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // selectimage

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().createUserAccount(
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      userName: _usernameController.text,
      file: _image!,
      name: _nameController.text,
    );
    // print(res);
    setState(() {
      _isLoading = false;
    });
    if (res != 'Success') {
      showSnackBar(res, context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildAppHeading(),
                      SizedBox(height: 40),
                      // Profile Screen

                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!),
                                )
                              : CircleAvatar(
                                  radius: 64,
                                  backgroundImage:
                                      AssetImage('assets/profile.png'),
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
                              child: IconButton(
                                onPressed: selectImage,
                                icon: Icon(
                                  IconlyLight.camera,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 34),
                      TextFieldInputWidget(
                        hintText: "Enter your name",
                        textInputType: TextInputType.text,
                        textEditingController: _nameController,
                        icon: IconlyLight.profile,
                      ),
                      SizedBox(height: 24),
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
                        onPressed: signupUser,
                      ),

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
