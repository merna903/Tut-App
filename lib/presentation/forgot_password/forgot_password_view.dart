import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_project/app/di.dart';
import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:new_project/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:new_project/presentation/resources/assets_manager.dart';
import 'package:new_project/presentation/resources/color_manager.dart';
import 'package:new_project/presentation/resources/string_manager.dart';
import 'package:new_project/presentation/resources/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {

  final ForgotPasswordViewModel _viewModel = instance<ForgotPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
              ?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.forgotPassword();
          }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Center(
                child: Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
              ),
              const SizedBox(
                height: AppSize.z20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.email.tr(),
                        labelText: AppStrings.email.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.emailError.tr(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.z60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsEmailValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.z40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                          _viewModel.forgotPassword();
                        }
                            : null,
                        child: Text(
                          AppStrings.resetPassword.tr(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.z8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
                child: TextButton(
                  onPressed: () {
                    _viewModel.forgotPassword();
                  },
                  child: Text(
                    AppStrings.resend.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
