import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:evolve_flutter/features/login/mfa_verification_page.dart';
import 'package:evolve_flutter/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController, _passwordController;
  bool _showPassword = false, _rememberMe = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  _onLoginButtonTapped(ApiClient client) async {
    // final String email = _emailController.text;
    // final String password = _passwordController.text;

    // for testing
    final String email = "muyuhello@gmail.com";
    final String password = "tisGiv-4qudfo-cawmug";

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    final responseBody = await client
        .performRequest(Api.signIn(email: email, password: password));

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MfaVerificationPage(
            email: email,
            password: password,
            mfaMethod: responseBody.mfaMethod,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ApiClientConsumer(
        builder: (context, apiClient) => Scaffold(
              appBar: null,
              body: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _renderLogo(),
                        _renderEmailTextField(),
                        _renderPassword(),
                        _renderRememberMe(),
                        _renderLoginButton(apiClient),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey[900], fontSize: 16.0),
                            children: <TextSpan>[
                              const TextSpan(text: "Don't have a account? "),
                              TextSpan(
                                  text: 'Sign Up',
                                  style: const TextStyle(
                                      color: ColorConstant.primary),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // TODO
                                    }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  void _pressRememberMe(val) {
    setState(() {
      _rememberMe = val;
    });
  }

  Widget _renderLogo() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Widget _renderEmailTextField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: TextConstant.email,
        hintText: TextConstant.emailHintText,
      ),
    );
  }

  Widget _renderPassword() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: TextConstant.password,
        hintText: TextConstant.passwordHintText,
        suffixIcon: GestureDetector(
          child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
    );
  }

  Widget _renderRememberMe() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () => _pressRememberMe(!_rememberMe),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: _pressRememberMe,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: const Text('Remember Me'),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Text(
              TextConstant.forgetPassword,
              textAlign: TextAlign.right,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderLoginButton(ApiClient client) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 30),
      child: CustomTextButton(
        type: CustomButtonType.primary,
        onPressed: () => _onLoginButtonTapped(client),
        text: TextConstant.login,
      ),
    );
  }
}
