import 'package:dalil/core/functions/custom_toast.dart';
import 'package:dalil/core/functions/navigation.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../auth_cubit/cubit/auth_cubit.dart';
import '../auth_cubit/cubit/auth_state.dart';
import 'terms_and_condition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_text_field.dart';

class CustomSignUp extends StatelessWidget {
  const CustomSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          showToast("Account Created Successfully");
          customReplacementNavigate(context, '/signin');
        } else if (state is SignUpFailureState) {
          showToast(state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.signupformkey,
          child: Column(
            children: [
              CustomTextFormField(
                labelText: AppStrings.fristName,
                onChanged: (firstname) {
                  authCubit.firstName = firstname;
                },
              ),
              CustomTextFormField(
                labelText: AppStrings.lastName,
                onChanged: (lastName) {
                  authCubit.lastName = lastName;
                },
              ),
              CustomTextFormField(
                labelText: AppStrings.emailAddress,
                onChanged: (emailAddress) {
                  authCubit.emailAddress = emailAddress;
                },
              ),
              CustomTextFormField(
                labelText: AppStrings.password,
                suffixIcon: IconButton(
                  icon: Icon(
                    authCubit.obscurePasswordTextValue == true
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    authCubit.obscurePasswordText();
                  },
                ),
                obscureText: authCubit.obscurePasswordTextValue,
                onChanged: (password) {
                  authCubit.password = password;
                },
              ),
              const TermsAndConditionWidget(),
              const SizedBox(height: 88),
              state is SignUpLoadingState
                  ? CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomBtn(
                      color: authCubit.termsAndConditionCheckBoxValue == false
                          ? AppColors.grey
                          : null,
                      onPressed: () {
                        if (authCubit.termsAndConditionCheckBoxValue == true) {
                          if (authCubit.signupformkey.currentState!
                              .validate()) {
                            authCubit.signUpWithEmailAndPassword();
                          }
                        }
                      },
                      text: AppStrings.signUp,
                    ),
            ],
          ),
        );
      },
    );
  }
}