import 'package:flutter/material.dart';

class Updatedate extends StatefulWidget {
  final String? date;
  final Function(String) onDateSelected;

  Updatedate({super.key, this.date, required this.onDateSelected});

  @override
  State<Updatedate> createState() => _UpdatedateState();
}

class _UpdatedateState extends State<Updatedate> {
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _dobController = TextEditingController(text: widget.date ?? '');
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    if (_dobController.text.isNotEmpty) {
      List<String> dateParts = _dobController.text.split('/');
      initialDate = DateTime(
        int.parse(dateParts[2]),
        int.parse(dateParts[1]),
        int.parse(dateParts[0]),
      );
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        widget.onDateSelected(_dobController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dobController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ngày sinh không được để trống';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: "Ngày sinh",
        suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: Colors.black,
          ),
          onPressed: () {
            _selectDate(context);
          },
        ),
      ),
      readOnly: true, //không cho xóa
    );
  }
}
