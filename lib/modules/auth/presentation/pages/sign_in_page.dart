import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../_shared/constants/app_color.dart';
import '../../../_shared/constants/app_styles.dart';
import '../../../_shared/constants/status.dart';
import '../../../_shared/presentation/extensions/size_extension.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../auth_module.dart';
import '../cubit/sign_in_cubit.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_up';
  static const routePath = '${AuthModule.moduleName}$routeName';

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with Loader, Messages {
  late TextEditingController _fieldEmail;
  late TextEditingController _fieldPassword;
  final formKey = GlobalKey<FormState>();

  var cubit = Modular.get<SignInCubit>();

  @override
  void initState() {
    _fieldEmail = TextEditingController(text: kDebugMode ? 'roberto@teste.com' : '');
    _fieldPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fieldEmail.dispose();
    _fieldPassword.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void _formSubmit() async {
    final formValid = formKey.currentState?.validate() ?? false;

    if (formValid) {
      await cubit.onSignInClicked(email: _fieldEmail.text.trim(), password: _fieldPassword.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenShortestSide = context.screenShortestSide;
    final screenWidth = context.screenWidth;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenShortestSide * .5,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/lanche.png'), fit: BoxFit.cover),
              ),
            ),
          ),
          //
          //
          Container(
            width: screenShortestSide * .5,
            padding: EdgeInsets.only(top: context.percentHeight(.10)),
            child: Image.asset('assets/images/logo.png'),
          ),
          //
          //
          Form(
            key: formKey,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: context.percentWidth(screenWidth < 1300 ? .7 : .30),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FractionallySizedBox(
                          widthFactor: .30,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        //
                        //
                        const SizedBox(height: 20),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Login',
                            style: context.textStyles.textTitle,
                          ),
                        ),
                        //
                        //
                        const SizedBox(height: 20),
                        TextFormField(
                          onFieldSubmitted: (_) => _formSubmit(),
                          controller: _fieldEmail,
                          decoration: InputDecoration(labelText: 'E-Mail'),
                          validator: Validatorless.multiple([
                            Validatorless.required('E-mail is required'),
                            Validatorless.email('E-mail invalid'),
                          ]),
                        ),
                        //
                        //
                        const SizedBox(height: 20),
                        TextFormField(
                          onFieldSubmitted: (_) => _formSubmit(),
                          controller: _fieldPassword,
                          decoration: InputDecoration(labelText: 'Password'),
                          validator: Validatorless.required('Password is required'),
                          obscureText: true,
                        ),
                        //
                        //
                        const SizedBox(height: 30),
                        BlocConsumer<SignInCubit, SignInState>(
                          bloc: cubit,
                          listener: (context, state) {
                            switch (state.status) {
                              case Status.loading:
                                showLoader();
                                break;
                              case Status.failure:
                                hideLoader();
                                showError(state.errorMessage);
                                break;
                              case Status.success:
                                hideLoader();
                                cubit.goToHome();
                                break;
                              case Status.initial:
                              case Status.loaded:
                                break;
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _formSubmit,
                                child: Text('Sing In'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
