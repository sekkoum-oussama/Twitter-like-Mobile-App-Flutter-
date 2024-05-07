import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  final String sample;
  final String separator;

  DateInputFormatter({required this.sample, required this.separator}){
    assert (sample != null);
    assert (separator != null);
  }
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length > 0) {
      if(newValue.text.length > oldValue.text.length) {
        if(newValue.text.length > sample.length) return oldValue;
        if(newValue.text.length < sample.length && sample[newValue.text.length] == separator) {
          //final String editedValue = "${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}";
          final String editedValue = "${newValue.text}$separator";
          return TextEditingValue(
            text: editedValue,
            selection: TextSelection.collapsed(offset: newValue.selection.end +1)
          );
        }
      }
      return newValue;
    } 
    return newValue;
    
  }

}