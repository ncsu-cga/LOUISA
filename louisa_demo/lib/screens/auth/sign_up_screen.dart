import 'package:flutter/material.dart';
import 'package:louisa_demo/widgets/ui_rounded_button.dart';
import 'package:louisa_demo/utils/style.dart';
import 'package:louisa_demo/services/http_services.dart';
import 'package:louisa_demo/utils/utils.dart';
import 'package:louisa_demo/widgets/ui_appbar_widget.dart';
import 'package:louisa_demo/utils/constant.dart';
import 'package:louisa_demo/screens/surveys/consent/survey_consent_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const id = 'sign_up_screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Form
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  GlobalKey _toolTipKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool _validate = false;
  Map response;
  String _passToolTip = '\u2022 Minimum 1 Upper case\n' +
      '\u2022 Minimum 1 Lower case\n' +
      '\u2022 Minimum 1 Numeric number\n' +
      '\u2022 Minimum 1 Special character\n' +
      'Allow charactors (! @ # \$ & * ~)';

// Common Allow Character ( ! @ # $ & * ~ )';
  static const double containerHeight = 80.0;

  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Builder(
            builder: (context) => Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: containerHeight,
                        child: TextFormField(
                          style: defaultText,
                          autofocus: true,
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: kPrimaryColor,
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            if (!isValidEmail(_email.text))
                              return 'Invalid email';
                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: containerHeight,
                        child: TextFormField(
                          style: defaultText,
                          controller: _pass,
                          obscureText: true,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter password',
                            labelText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                final dynamic tooltip =
                                    _toolTipKey.currentState;
                                tooltip.ensureTooltipVisible();
                              },
                              child: Tooltip(
                                key: _toolTipKey,
                                padding: EdgeInsets.all(10.0),
                                message: _passToolTip,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:
                                    Icon(Icons.info, color: kPrimaryLightColor),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            if (!isValidPassword(val))
                              return 'Invalid password';
                            return null;
                          },
                        ),
                      ),
                      TextFormField(
                          style: defaultText,
                          controller: _confirmPass,
                          obscureText: true,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Confirm password',
                            labelText: 'Confirm password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                          ),
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            if (val != _pass.text) {
                              _confirmPass.text = '';
                              return 'Password doesn\'t match';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                      RoundedButton(
                        title: 'Sign Up',
                        color: kPrimaryColor,
                        onPressed: () async {
                          _validate = _form.currentState.validate();
                          // response = await createUser(
                          //     _email.text, _pass.text, context);
                          // setState(() {
                          //   if (response
                          //       .containsKey(Const.AUTH['USER_CREATED'])) {
                          //     print('set session');
                          //     print(response[Const.AUTH['USER_CREATED']]);
                          //   }
                          // });
                          Navigator.popAndPushNamed(context, ConsentScreen.id);
                        },
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
