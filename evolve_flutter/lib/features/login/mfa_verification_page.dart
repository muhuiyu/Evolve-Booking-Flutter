import 'package:evolve_api/evolve_api.dart';
import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:evolve_flutter/features/core/main_tab_controller.dart';
import 'package:evolve_flutter/helpers/auth_storage.dart';
import 'package:evolve_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class MfaVerificationPage extends StatefulWidget {
  final String email;
  final String password;
  final NotificationMethod mfaMethod;

  const MfaVerificationPage({
    super.key,
    required this.email,
    required this.password,
    required this.mfaMethod,
  });

  @override
  _MfaVerificationPageState createState() => _MfaVerificationPageState();
}

class _MfaVerificationPageState extends State<MfaVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  _onActionTapped(ApiClient client) async {
    final responseBody = await client.performRequest(Api.verifyCode(
        email: widget.email,
        password: widget.password,
        verificationCode: _controller.text));

    // TODO: error handling
    AuthStorage.shared.saveToken(responseBody.token);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainTabController(
              token: responseBody.token, memberships: responseBody.memberships),
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
          padding: PaddingConstant.screenLayoutMarginsguide,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _renderTextField(),
                  _renderActionButton(apiClient),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderTextField() {
    return TextFormField(
      controller: _controller,
      decoration: const InputDecoration(
          labelText: TextConstant.verificationCodeTitle,
          hintText: TextConstant.verificationCodeHintText),
    );
  }

  Widget _renderActionButton(ApiClient client) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 30),
      child: CustomTextButton(
        onPressed: () => _onActionTapped(client),
        type: CustomButtonType.primary,
        text: TextConstant.login,
      ),
    );
  }
}
