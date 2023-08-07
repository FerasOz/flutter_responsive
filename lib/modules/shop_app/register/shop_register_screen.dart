import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/modules/shop_app/register/cubit/cubit.dart';
import 'package:new_project_flutter/modules/shop_app/register/cubit/states.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, ShopRegisterStates>(
          listener: (context, state){
            if(state is ShopRegisterSuccessState){
              if(state.RegisterModel.status){
                print(state.RegisterModel.message);
                print(state.RegisterModel.data!.token);
                CacheHelper.saveData(key: 'token', value: state.RegisterModel.data!.token).then((value) {
                  token = state.RegisterModel.data!.token!;
                  navigateAndFinish(context, ShopLayout());
                });
              }else{
                print(state.RegisterModel.message);
                showToast(
                    text: '${state.RegisterModel.message}',
                    state: ToastStates.ERROR
                );
              }
            }
          },
          builder: (context, state){
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('Register now to browse our hot offers ...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 25.0,
                          ),
                          defaultFormFeild(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Name must not be empty';
                                }
                              },
                              label: 'Name',
                              prefix: Icons.person_outline
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormFeild(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Email must not be empty';
                                }
                              },
                              label: 'Email',
                              prefix: Icons.email_outlined),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormFeild(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'password is too shot';
                                }
                              },
                              label: 'Password',
                              isPassword: RegisterCubit.get(context).isPassword,
                              suffix: RegisterCubit.get(context).suffix,
                              suffixPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              prefix: Icons.lock_outline
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormFeild(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Phone must not be empty';
                                }
                              },
                              label: 'Phone',
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              prefix: Icons.phone_outlined
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => defaultButton(
                              text: 'Register',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                  );
                                }
                              },
                              radius: 5.0,
                            ),
                            fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
