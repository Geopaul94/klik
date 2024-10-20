
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klik/application/core/widgets/CustomText.dart';
import 'package:klik/application/core/widgets/customeTypewriterGradientText.dart';
import 'package:klik/application/core/widgets/custome_button.dart';
import 'package:klik/application/core/widgets/custome_snackbar.dart';
import 'package:klik/application/core/widgets/custometextformfield.dart';
import 'package:klik/application/core/widgets/validations.dart';
import 'package:klik/domain/model/userModel.dart';
import 'package:klik/presentaion/bloc/signup/signup_bloc.dart';
import 'package:klik/presentaion/pages/authentication/login/login_page.dart';
import 'package:klik/presentaion/pages/authentication/signup_page/signup_otp.dart';
import 'package:klik/application/core/constants/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: _blocListener,
        builder: _buildForm,
      ),
    );
  }

  void _blocListener(BuildContext context, SignupState state) {
    if (state is SignupSuccesState) {
      customSnackbar(context, 'Success', green);
      _navigateToOtpPage(context);
    } else if (state is SignupErrorState) {
      customSnackbar(context, state.error, red);
    }
  }

  Widget _buildForm(BuildContext context, SignupState state) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildLogo(),
              const SizedBox(height: 16.0),
              _buildTypewriterText(),
              const SizedBox(height: 16.0),
              _buildTextFields(),
              const SizedBox(height: 24.0),
              _buildSubmitButton(size, state),
              const SizedBox(height: 12.0),
              _buildLoginSection(size),
              const SizedBox(height: 80.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset('assets/headline.png'),
      ),
    );
  }

  Widget _buildTypewriterText() {
    return const Center(
      child: TypewriterGradientText(
        text:
            ' " Capture the essence of your most beautiful memories with Klik. Let your clicks tell stories that will last a lifetime, sharing joy and love with every shot. " ',
        style: colorizeTextStyle,
        gradient: gradient,
        speed: Duration(milliseconds: 100),
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: <Widget>[
        userName(),
        const SizedBox(height: 16.0),
        email(),
        const SizedBox(height: 16.0),
        phoneNumber(),
        const SizedBox(height: 16.0),
        password(),
        const SizedBox(height: 16.0),
        confirmPasssword(),
      ],
    );
  }

  CustomTextFormField userName() {
    return CustomTextFormField(
        labelText: 'Username',
        icon: Icons.person_outline,
        controller: _usernameController,
        validator: validateUsername,
      );
  }

  CustomTextFormField email() {
    return CustomTextFormField(
        labelText: 'Email',
        hintText: 'Enter your email address',
        icon: Icons.email_outlined,
        controller: _emailController,
        validator: validateEmail,
      );
  }

  CustomTextFormField phoneNumber() {
    return CustomTextFormField(
        labelText: 'Phone Number',
        hintText: 'Enter your Phone Number',
        icon: Icons.phone_android,
        controller: _phoneController,
        validator: validateMobileNumber,
        keyboardType: TextInputType.phone,
      );
  }

  CustomTextFormField password() {
    return CustomTextFormField(
        labelText: 'Password',
        hintText: 'Enter your password',
        icon: Icons.lock,
        controller: _passwordController,
        obscureText: true,
        validator: validatePassword,
      );
  }

  CustomTextFormField confirmPasssword() {
    return CustomTextFormField(
        labelText: 'Confirm password',
        hintText: 'Enter your password',
        icon: Icons.lock,
        controller: _confirmPasswordController,
        obscureText: true,
      );
  }

  Widget _buildSubmitButton(Size size, SignupState state) {
    if (state is SignupLoadingState) {
      return loadingButton(
        media: size,
        onPressed: () {},
        gradientStartColor: Colors.green,
        gradientEndColor: Colors.blue,
        loadingIndicatorColor: Colors.purple,
      );
    }
    return customButton(
      color: Colors.green,
      media: size,
      buttonText: 'Sign UP',
      onPressed: _onSignupButtonPressed,
    );
  }

  void _onSignupButtonPressed() {
    if (_passwordController.text == _confirmPasswordController.text) {
      if (_formKey.currentState!.validate()) {
        context.read<SignupBloc>().add(
          OnRegisterButtonClickedEvent(
            userName: _usernameController.text,
            password: _passwordController.text,
            phoneNumber: _phoneController.text,
            email: _emailController.text,
          ),
        );
      } else {
        customSnackbar(context, 'Fill All Fields', red);
      }
    } else {
      customSnackbar(context, 'Password mismatch', red);
    }
  }

  Widget _buildLoginSection(Size size) {
    return SizedBox(
      width: size.width * .8,
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Have an account? Then '),
              ),
              Expanded(
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          InkWell(
            onTap: () => _navigateToLoginPage(context),
            child:  const CustomText(
              text: 'Login',
              color: Colors.green,
              fontSize: 22,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToOtpPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterOtp(
          email: _emailController.text,
          user: UserModel(
            userName: _usernameController.text,
            password: _passwordController.text,
            phoneNumber: _phoneController.text,
            emailId: _emailController.text,
          ),
        ),
      ),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
