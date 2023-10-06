import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/app/app_refrances.dart';
import 'package:new_project/app/constants.dart';
import 'package:new_project/app/di.dart';
import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:new_project/presentation/register/register_viewmodel.dart';
import 'package:new_project/presentation/resources/color_manager.dart';
import 'package:new_project/presentation/resources/font_manager.dart';
import 'package:new_project/presentation/resources/string_manager.dart';
import 'package:new_project/presentation/resources/styles_manager.dart';
import 'package:new_project/presentation/resources/values_manager.dart';

import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AppPreferences _appPreferences = instance<AppPreferences>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
    _mobileNumberController.addListener(
        () => _viewModel.setMobileNumber(_mobileNumberController.text));
    _viewModel.isUserRegisterSuccessfullyStreamController.stream
        .listen((isRegistered) {
      if (isRegistered) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserRegistered();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManger.white,
      ),
      backgroundColor: ColorManger.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
              child: StreamBuilder<bool>(
                stream: _viewModel.outIsUserNameValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: AppStrings.userName.tr(),
                      labelText: AppStrings.userName.tr(),
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.userNameError.tr(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSize.z12,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CountryCodePicker(
                        onChanged: (country) {
                          _viewModel.setCountryCode(
                              country.dialCode ?? Constants.empty);
                        },
                        initialSelection: '+20',
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        hideMainText: true,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: StreamBuilder<bool>(
                        stream: _viewModel.outIsMobileNumberValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _mobileNumberController,
                            decoration: InputDecoration(
                              hintText: AppStrings.mobileNumber.tr(),
                              labelText: AppStrings.mobileNumber.tr(),
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.mobileNumberInValid.tr(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.z12,
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
                          : AppStrings.emailInValid.tr(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSize.z12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
              child: StreamBuilder<bool>(
                stream: _viewModel.outIsPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: AppStrings.password.tr(),
                      labelText: AppStrings.password.tr(),
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.passwordError.tr(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: AppSize.z12,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
                child: Container(
                  height: AppSize.z50,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.z8)),
                    border: Border.all(color: ColorManger.gray, width: 2),
                  ),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () {
                      _showPicker(context);
                    },
                  ),
                )),
            const SizedBox(
              height: AppSize.z12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
              child: StreamBuilder<bool>(
                stream: _viewModel.outputAreAllValid,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppSize.z40,
                    child: ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              _viewModel.register();
                            }
                          : null,
                      child: Text(
                        AppStrings.register.tr(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppStrings.loginText.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              AppStrings.profilePicture.tr(),
              style: getMediumStyle(
                  color: ColorManger.gray, fontSize: FontSize.s14),
            ),
          ),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outProfilePicture,
            builder: (context, snapshot) {
              return _imagePicketByUser(snapshot.data);
            },
          )),
          Flexible(
            child: SvgPicture.asset(ImageAssets.camera),
          ),
        ],
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: ColorManger.gray,
                    size: AppSize.z18,
                  ),
                  leading: const Icon(Icons.camera),
                  title: Text(AppStrings.gallery.tr()),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: Text(AppStrings.camera.tr()),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _imagePicketByUser(File? pic) {
    if (pic != null && pic.path.isNotEmpty) {
      return Image.file(pic);
    } else {
      return Container();
    }
  }

  void _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image!.path));
  }

  void _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image!.path));
  }
}
