import 'package:flutter/material.dart';

class CustomDatePickerFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _txtLabel;
  final VoidCallback _callback;

  const CustomDatePickerFormField({
    Key? key,
    required TextEditingController controller,
    required String txtLabel,
    required VoidCallback callback,
  })  : _controller = controller,
        _txtLabel = txtLabel,
        _callback = callback,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(

        fillColor: Colors.transparent,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00D3FF), width: 1),
        ),

        border: const OutlineInputBorder(),
        filled: true,
        prefixIcon: const Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child:  Card(
            color: Color(0xFF00D3FF),
            child: SizedBox(
              height: 58,
              width: 48,
              child: Icon(
                Icons.date_range,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),



        label: Text(_txtLabel),
      ),
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return '$_txtLabel cannot be empty';
        }
        return null;
      }),
      onTap: _callback,
    );
  }
}