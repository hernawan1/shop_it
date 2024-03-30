import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/common/constant.dart';
import 'package:shop_it/gen/asset.gen.dart';
import 'package:shop_it/src/auth/cubit/auth_cubit.dart';
import 'package:shop_it/src/produk/screen/produk.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureTextPassword = true;
  Color primarys = primary;
  final _formKey = GlobalKey<FormState>();

  void changeObscure() {
    if (obscureTextPassword) {
      setState(() {
        obscureTextPassword = false;
      });
    } else {
      setState(() {
        obscureTextPassword = true;
      });
    }
  }

  void changeColorTitle() {
    setState(() {
      primarys = Colors.red;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthLogin) {
            print(state);
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (_) => const Produk()),
                (route) => false);
          }
        },
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: marginVertical * 6,
                  ),
                  Assets.images.login.image(height: 50),
                  Text(
                    "Shop from our stores with ease",
                    style: textStyle.copyWith(
                      color: grey,
                      fontWeight: semiBold,
                      fontSize: text,
                    ),
                  ),
                  const SizedBox(
                    height: marginVertical * 7,
                  ),
                  TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email Tidak Boleh Kosong!!!";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      changeColorTitle();
                      _formKey.currentState!.validate();
                    },
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 2, color: primary),
                        ),
                        prefixIcon: const Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: primary)),
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: grey),
                        floatingLabelStyle: const TextStyle(color: primary),
                        fillColor: primary,
                        focusColor: primarys),
                  ),
                  const SizedBox(
                    height: marginVertical * 2,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password Tidak Boleh Kosong!!!";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      changeColorTitle();
                      _formKey.currentState!.validate();
                    },
                    obscureText: obscureTextPassword,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 2, color: primary),
                        ),
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: InkWell(
                          onTap: () {
                            changeObscure();
                          },
                          child: obscureTextPassword
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.remove_red_eye_outlined),
                        ),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: primary)),
                        labelStyle: const TextStyle(color: grey),
                        floatingLabelStyle: const TextStyle(color: primary),
                        labelText: 'Password',
                        focusColor: primarys),
                  ),
                  const SizedBox(
                    height: marginVertical * 2,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot Password ?',
                        style:
                            TextStyle(color: grey, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: marginVertical * 2,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login();
                      }
                    },
                    child: Container(
                      width: 100.w,
                      padding: const EdgeInsets.symmetric(
                        vertical: marginVertical * 1,
                      ),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(
                          marginVertical / 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: textStyle.copyWith(
                            color: white,
                            fontWeight: semiBold,
                            fontSize: h4,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: marginVertical * 2,
                  ),
                  Text(
                    "Did'nt have any account? Sign Up Here",
                    style: TextStyle(color: grey, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
