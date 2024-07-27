import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/config/const.dart';
import 'package:flutter_coffee_app/data/api.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/screen/login/datepicker.dart';
import 'package:flutter_coffee_app/screen/login/login.dart';
import 'package:gap/gap.dart';

void main() => runApp(const Register());

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedOption = 'Nam';
  FocusNode _focusNodePassword = FocusNode();
  bool _obscureText = true;
  String selectedDate = '';

  Future<UserModel> register() async {
    UserModel user = UserModel(
      id: 0,
      address: "",
      username: _nameController.text,
      password: _passwordController.text,
      fullName: _fullnameController.text,
      email: _emailController.text,
      phoneNumber: _phonenumberController.text,
      roleId: "R3",
      image: "",
    );
    return await ApiService().signUp(user);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_focusNodePassword.hasPrimaryFocus)
        return; // If focus is on text field, don't unfocus
      _focusNodePassword.canRequestFocus = false;
    });
  }

  Future<void> _showOption(BuildContext context) async {
    final option = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: Text('Giới tính của bạn?')),
              ),
              const Divider(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, 'Nam');
                    },
                    child: const Text('Nam'),
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, 'Nữ');
                    },
                    child: const Text('Nữ'),
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, 'Khác');
                    },
                    child: const Text('Khác'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (option != null) {
      setState(() {
        selectedOption = option;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Đăng ký'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Tên đăng nhập',
                  ),
                ),
                const Gap(10),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mật khẩu không được trống';
                    } else if (value.length < 6 || value.length > 15) {
                      return 'Tên đăng nhập phải có 6-15 ký tự';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Mật khẩu',
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
                const Gap(10),
                TextFormField(
                  controller: _fullnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên khách hàng không được trống';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Tên khách hàng',
                  ),
                ),
                const Gap(10),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email không được trống';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Email',
                  ),
                ),
                const Gap(10),
                TextFormField(
                  controller: _phonenumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Số điện thoại không được trống';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Số điện thoại chỉ chứa được số';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: 'Số điện thoại',
                  ),
                ),
                const Gap(10),
                Updatedate(
                  date: selectedDate,
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () {
                    _showOption(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Text(
                            selectedOption,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 69, 69, 69)),
                          ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_down_outlined),
                        ],
                      ),
                    ),
                  ),
                ),
              Gap(20),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          register();
                          showMessage('Đăng ký thành công');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đăng ký thất bại')),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Đăng ký',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
