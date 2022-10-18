import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryPickerEntryField extends StatefulWidget {
  const CountryPickerEntryField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.fillColor = Colors.white,
    this.readOnly = false,
    this.textAlign = TextAlign.left,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.height = 48.0,
    this.onFieldSubmitted,
    this.onChanged,
    this.maxLength = 100,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
    this.borderColor = const Color(0xFF143647),
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final Color fillColor;
  final bool readOnly;
  final TextAlign textAlign;
  final TextInputType textInputType;
  final int maxLines;
  final double height;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final int maxLength;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets contentPadding;
  final Color borderColor;

  @override
  State<CountryPickerEntryField> createState() =>
      _CountryPickerEntryFieldState();
}

class _CountryPickerEntryFieldState extends State<CountryPickerEntryField> {
  Country? _selectedCountry;

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
       inputFormatters: widget.inputFormatters,
       textInputAction: widget.textInputAction,
       style: const TextStyle(fontSize: 14, color: Colors.black),
       maxLength: widget.maxLength,
       onChanged: widget.onChanged,
       controller: widget.controller,
       focusNode: widget.focusNode,
       onFieldSubmitted: widget.onFieldSubmitted,
       readOnly: widget.readOnly,
       maxLines: widget.maxLines,
       textAlign: widget.textAlign,
       keyboardType: widget.textInputType,
       cursorColor: Colors.black.withOpacity(0.3),
       decoration: InputDecoration(
         prefixIcon: InkWell(
           onTap: _onPressedShowBottomSheet,
           child: Container(
             width: 90,
             height: widget.height,
             padding: const EdgeInsets.symmetric(horizontal: 16.0),
             child: Align(
               alignment: Alignment.centerLeft,
               child: Row(
                 children: [
                   Expanded(
                     child: Text(
                       _selectedCountry?.callingCode ?? '+91',
                       textAlign: TextAlign.center,
                       overflow: TextOverflow.ellipsis,
                       style: const TextStyle(fontSize: 14, color: Colors.black),
                     ),
                   ),
                   const SizedBox(width: 16,),
                   Container(
                     height: 30.0,
                     width: 0.3,
                     color: Colors.black.withOpacity(0.2),
                   ),
                 ],
               ),
             ),
           ),
         ),
         suffixIcon: Padding(
           padding: const EdgeInsets.symmetric(vertical: 15.0).copyWith(right: 24.0),
           child: InkWell(
             onTap: _onPressedShowBottomSheet,
             child: Image.asset(
               _selectedCountry?.flag ?? 'flags/ind.png',
               package: countryCodePackageName,
               height: 18.0,
             ),
           ),
         ),
         counterText: "",
         hintText: widget.hint,
         hintStyle:
             TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.3)),
         filled: true,
         fillColor: widget.fillColor,
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: widget.borderColor, width: 0.2),
         ),
         errorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: widget.borderColor, width: 0.2),
         ),
         disabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: widget.borderColor, width: 0.2),
         ),
         focusedErrorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: widget.borderColor, width: 0.2),
         ),
         focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: widget.borderColor, width: 0.2),
         ),
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: widget.borderColor, width: 0.2),
         ),
         contentPadding: widget.contentPadding,
       ),
        ),
    );
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
}
