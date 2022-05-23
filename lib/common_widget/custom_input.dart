import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label, hintText, iniString;
  final bool isSuffixIcon;
  final bool isObscured;
  final TextInputType inputType;
  final List hint;
  const CustomTextField(this.controller, this.label, this.hintText, this.iniString,
      this.isSuffixIcon, this.inputType, this.isObscured, this.hint, {Key? key}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;
  void initialization(){
    setState(() {
      isObscure = widget.isObscured;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isSuffixIcon){
      if(UniversalPlatform.isIOS){
        return CupertinoTextField(
          controller: widget.controller,
          placeholder: widget.label,
          placeholderStyle: const TextStyle(color: Colors.black),
          style: const TextStyle(color: Colors.black),
          autofillHints: [widget.hintText],
          suffix: InkWell(
            onTap: () => setState(
                  () => isObscure =
              !isObscure,
            ),
            child: Icon(
              isObscure
                  ? Icons.visibility_outlined
                  : Icons
                  .visibility_off_outlined,
              size: 22,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          keyboardType: widget.inputType,
          obscureText: isObscure,
          cursorColor: Colors.teal,
        );
      }
      return TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText != "" ? widget.hintText : "",
          labelStyle: const TextStyle(color: Colors.black),
          suffixIcon: InkWell(
            onTap: () => setState(
                  () => isObscure =
              !isObscure,
            ),
            child: Icon(
              isObscure
                  ? Icons.visibility_outlined
                  : Icons
                  .visibility_off_outlined,
              size: 22,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.teal,
              )
          ),
        ),
        autofillHints: [widget.hintText],
        keyboardType: widget.inputType,
        obscureText: isObscure,
        cursorColor: Colors.black,
      );
    }
    if(UniversalPlatform.isIOS){
      return CupertinoTextField(
        controller: widget.controller,
        placeholder: widget.label,
        autofillHints: [widget.hintText],
        placeholderStyle: const TextStyle(color: Colors.black),
        style: const TextStyle(color: Colors.black),
        keyboardType: widget.inputType,
        cursorColor: Colors.black,
      );
    }
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText != "" ? widget.hintText : null,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.teal,
            )
        ),
      ),
      autofillHints: [widget.hintText],
      keyboardType: widget.inputType,
      cursorColor: Colors.black,
    );
  }
}