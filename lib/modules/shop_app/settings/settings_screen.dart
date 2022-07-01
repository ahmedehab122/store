import 'package:App/layout/shop_app/cubit/cubit.dart';
import 'package:App/layout/shop_app/cubit/state.dart';
import 'package:App/shared/components/components.dart';
import 'package:App/shared/components/constants.dart';
import 'package:App/shared/cubit/cubit.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).userModel;

          nameController.text = model.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;

          return ConditionalBuilder(

            condition: ShopCubit.get(context).userModel != null,
            builder: (context) {

              return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {
                    //         AppCubit.get(context).changeAppMode();
                    //
                    //       },
                    //
                    //       iconSize: 50,
                    //       icon: Icon(
                    //         Icons.dark_mode,
                    //
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 200,
                    //     ),
                    //     Text(
                    //       'Theme Mode',
                    //
                    //       style: TextStyle(
                    //         color: Colors.black
                    //       ),
                    //       textAlign: TextAlign.center,
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        }
                      },
                      text: 'Update',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'Log Out',
                    ),
                  ],
                ),
              ),
            );
              },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}
