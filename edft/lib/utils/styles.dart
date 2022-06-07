import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Appbar font
TextStyle appBarTitle = GoogleFonts.poppins(fontSize: 16);

// Dropdown Decoration
InputDecoration getDropdownDecoration(BuildContext context, String label) {
  InputBorder dropdownBorder = OutlineInputBorder(
    borderSide: Divider.createBorderSide(context),
  );
  return InputDecoration(
      border: dropdownBorder,
      enabledBorder: dropdownBorder,
      focusedBorder: dropdownBorder,
      filled: true,
      contentPadding: const EdgeInsets.all(8),
      labelText: label);
}
