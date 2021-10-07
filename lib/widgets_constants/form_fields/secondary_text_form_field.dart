import 'package:flutter/material.dart';
import 'package:solh/shared_widgets_constants/constants/colors.dart';

class SolhSecondaryTextFormField extends StatefulWidget {
  const SolhSecondaryTextFormField({
    required this.textEditingController,
    required this.isSuffixAvailable,
    this.cursorColor,
    this.hintText,
    this.isObscureText = false,
    this.suffixText,
    this.onSuffixPressed,
    this.borderColor,
    this.focusedBorderColor,
    this.textStyle,
    this.label,
    this.labelStyle,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.maxLength,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onSuffixPressed;
  final String? suffixText;
  final String? hintText;
  final bool isObscureText;
  final TextEditingController? textEditingController;
  final bool isSuffixAvailable;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final TextStyle? textStyle;
  final String? label;
  final TextStyle? labelStyle;
  final Color? cursorColor;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  _SolhSecondaryTextFormFieldState createState() => _SolhSecondaryTextFormFieldState();
}

class _SolhSecondaryTextFormFieldState extends State<SolhSecondaryTextFormField> {
  ChangeNotifier textFieldLister = ChangeNotifier();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 14,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 20,
      ),
      decoration: BoxDecoration(
        color: SolhColors.greyS200,
      ),
      child: TextFormField(
        focusNode: _focusNode,
        obscureText: widget.isObscureText,
        style: widget.textStyle ?? TextStyle(color: SolhColors.black, fontSize: 14),
        controller: widget.textEditingController,
        cursorColor: widget.cursorColor ?? SolhColors.white,
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: widget.labelStyle ??
              TextStyle(
                fontSize: 12,
                color: SolhColors.black,
              ),
          counterText: "",
          disabledBorder: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 12,
            color: SolhColors.black,
          ), //Color(0xFFC8C8C8)),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
