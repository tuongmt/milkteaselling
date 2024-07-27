import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/models/user_model.dart';
import 'package:flutter_coffee_app/screen/login/datepicker.dart';

import 'package:image_picker/image_picker.dart';

import 'package:gap/gap.dart';

class Updateinfo extends StatefulWidget {
  final UserModel userModel;
  const Updateinfo({super.key, required this.userModel});

  @override
  State<Updateinfo> createState() => _UpdateinfoState();
}

class _UpdateinfoState extends State<Updateinfo> {
  final _imageSize = 80.0;
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _profilePicture;
  String selectedOption = 'Nam';
  String selectedDate = "01/02/2003";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _updateImage(XFile? image) {
    setState(() {
      _profilePicture = image;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phonenumberController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.userModel.fullName;
    _phonenumberController.text = widget.userModel.phoneNumber;
    _dobController.text = '25/12/2003';
    _emailController.text = widget.userModel.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thông tin cá nhân'),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => const Register()));
          //   },
          // ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                      width: _imageSize,
                      height: _imageSize,
                      child: Center(
                        child: GestureDetector(
                          onTap: () => _showPickerDialog(context),
                          child: _profilePicture != null
                              ? Image.file(
                                  File(_profilePicture!.path),
                                  fit: BoxFit.cover,
                                  width: _imageSize,
                                  height: _imageSize,
                                )
                              : Image.asset(
                                  'assets/images/avatar.jpg',
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.image),
                                  fit: BoxFit.cover,
                                  width: _imageSize,
                                  height: _imageSize,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tên khách hàng không được trống';
                      }
                      return null;
                    },
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Tên khách hàng',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Số điện thoại không được trống';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Số điện thoại chỉ chứa được số';
                      }
                      return null;
                    },
                    controller: _phonenumberController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Số điện thoại'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email không được trống';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Email không hợp lệ';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Email'),
                  ),
                  SizedBox(height: 10),
                  Updatedate(
                    date: selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                  ), //UpdateDate
                  SizedBox(height: 10),
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
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Text(selectedOption,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 69, 69, 69))),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(selectedDate);
                        print(selectedOption);

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('Processing Data')),
                        // );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Register()));
                      }
                    },
                    child: Text(
                      'Cập nhật tài khoản',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      fixedSize: Size(1000, 50),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete, color: Colors.red[300]),
                    label: Text(
                      'Xóa tài khoản',
                      style: TextStyle(color: Colors.red[300]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _showPickerDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('Ảnh đại diện')),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chọn ảnh'),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () async {
                      try {
                        final XFile? image = await _imagePicker.pickImage(
                            source: ImageSource.gallery);
                        _updateImage(image);
                      } catch (error) {
                        print(error);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Thư viện'),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      try {
                        final XFile? image = await _imagePicker.pickImage(
                            source: ImageSource.camera);
                        _updateImage(image);
                      } catch (error) {
                        print(error);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Máy ảnh'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
}
