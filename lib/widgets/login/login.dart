import 'package:flutter/material.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:login/config.dart';
import 'package:login/models/login_request_model.dart';
import 'package:login/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;
  late SharedPreferences prefrs;

  @override
  void initState() {
    super.initState();
  }

  void initSharedPreference() async {
    prefrs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: BlurryModalProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/LogoKalettre.jpg",
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(left: 20, top: 50, bottom: 30),
              child: Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              )),
          FormHelper.inputFieldWidget(context, "username", "Username",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Username can't be empty";
            }

            return null;
          }, (onSavedVal) {
            username = onSavedVal;
          },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FormHelper.inputFieldWidget(context, "password", "Password",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Password can't be empty";
              }

              return null;
            }, (onSavedVal) {
              password = onSavedVal;
            },
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white.withOpacity(0.7),
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ))),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton("Login", () {
              if (validateAndSave()) {
                setState(() {
                  isApiCallProcess = true;
                });
                LoginRequestModel model = LoginRequestModel(
                  username: username,
                  password: password,
                );

                APIService.login(model).then((response) => {
                      if (response)
                        {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/list', (route) => false)
                        }
                      else
                        {
                          FormHelper.showSimpleAlertDialog(context,
                              Config.appName, "Invalid Credentials", "OK", () {
                            Navigator.pop(context);
                          })
                        }
                    });
              }
            },
                btnColor: Colors.blue,
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
