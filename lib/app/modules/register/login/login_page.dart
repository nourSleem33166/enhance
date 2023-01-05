import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/register/login/login_controller.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/widgets/raised_button.dart';
import 'package:enhance/app/shared/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool isVisible=false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // controller.emailValidator(emailController.text);
    // controller.passwordValidator(passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/shared/enhance_logo.png",
                  width: 180,
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 35, top: 40),
                  child: Text(
                    LocaleKeys.loginDesc.tr(),
                    style: regularStyle(
                        fontSize: 18,
                        color: EnhanceColors.color(ColorType.primaryTextColor)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: SharedTextField(
                    controller: emailController,validator: controller.emailValidator,
                    // validator: controller.emailValidator,borderTextFieldColor:EnhanceColors.color(ColorType.secondary13) ,
                    textColor: EnhanceColors.color(ColorType.primaryTextColor),
                    borderTextFieldColor:
                        EnhanceColors.color(ColorType.secondary13),
                    suffixIconColor: EnhanceColors.color(ColorType.secondary13),
                    hintText: "someone@example.com",
                    labelText: LocaleKeys.email.tr(),
                    suffixIcon: Icons.email,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: SharedTextField(
                    controller: passwordController,
                    isExpandable: false,
                    // validator: controller.passwordValidator,
                    borderTextFieldColor:
                        EnhanceColors.color(ColorType.secondary13),
                    textColor: EnhanceColors.color(ColorType.primaryTextColor),
                    suffixIconColor: EnhanceColors.color(ColorType.secondary13),
                    obscureText: !isVisible,suffixFunction: (){
                      setState(() {
                        isVisible=!isVisible;
                      });
                  },
                    suffixIcon:isVisible? FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,
                    labelText: LocaleKeys.password.tr(),
                  ),
                ),

                // Align( alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: InkWell(
                //       onTap: () => print("hi"),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(
                //           LocaleKeys.forgotPasswordLabel.tr(),
                //           style: TextStyle(
                //               color:
                //                   EnhanceColors.color(ColorType.secondaryTextColor)),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: InkWell(
                    onTap: () {
                      controller.signUp();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        LocaleKeys.noAccountLabel.tr(),
                        style: regularStyle(
                            color: EnhanceColors.color(
                                ColorType.primaryTextColor)),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Observer(
                          builder: (context) => SharedRaisedButton(
                            text: LocaleKeys.login.tr(),
                            onPressed: () {
                              controller.login(emailController.text, passwordController.text);
                            },
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            color: EnhanceColors.color(ColorType.secondary13),
                            isEnabled: true,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 60),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Text(LocaleKeys.noAccountLabel.tr()),
                //       InkWell(
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(
                //             LocaleKeys.createAccount.tr(),
                //             style: TextStyle(color: Colors.blue),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
