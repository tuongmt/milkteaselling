import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/data/app_provider.dart';
import 'package:flutter_coffee_app/main.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/screen/login/forgetpassword.dart';
import 'package:flutter_coffee_app/screen/login/register.dart';
import 'package:gap/gap.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import '../../data/sharepref.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static Color _selectColor = Colors.orangeAccent;
  static Color _unselectColor = Colors.grey;
  FocusNode _focusNodePassword = FocusNode();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //autoLogin();
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null && prefs.getString('user') != '') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const BottomNav()));
    }
  }

  login() async {
    UserModel user = await ApiService()
        .logIn(_nameController.text, _passwordController.text);
    if (user.id != 0) {
      AppProvider appProvider =
          Provider.of<AppProvider>(context, listen: false);
      appProvider.fetchUserInfo(user.id);
      return true;
    }
    //saveUser(user);

    return false;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_focusNodePassword.hasPrimaryFocus)
        return; // If focus is on text field, don't unfocus
      _focusNodePassword.canRequestFocus = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const Image(
                    width: double.infinity,
                    height: 330,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/milktea_login.png"),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.house_outlined,
                      color: Colors.orangeAccent,
                      size: 24,
                    ),
                    Gap(5),
                    AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('WarmHouse',
                            textStyle: const TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 4.1)),
                      ],
                      totalRepeatCount: 2,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey, // Sử dụng GlobalKey ở đây
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tên đăng nhập không được trống';
                          } else if (value.length < 6 || value.length > 15) {
                            return 'Tên đăng nhập phải có 6-15 ký tự';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _selectColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _unselectColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _unselectColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _selectColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Tên đăng nhập',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const Gap(10),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mật khẩu không được trống';
                          }else if (value.length < 6 || value.length > 15) {
                      return 'Tên đăng nhập phải có 6-15 ký tự';
                    }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _selectColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _unselectColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _unselectColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: _selectColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Mật khẩu',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: _toggle,
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Forgetpass()));
                            },
                            child: const Text(
                              'Quên mật khẩu ?',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                var result = await login();
                                if (result) {
                                  showMessage('Đăng nhập thành công');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BottomNav(),
                                    ),
                                  );
                                }
                              } catch (e) {
                                showMessage('Đăng nhập thất bại');
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.orangeAccent),
                          ),
                          child: const Text(
                            "Đăng nhập",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bạn chưa có tài khoản? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            child: const Text(
                              'Đăng ký ngay',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(25),
            ],
          ),
        ),
      ),
    );
  }
}
