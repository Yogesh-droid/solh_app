import 'package:flutter/material.dart';
import 'package:solh/shared_widgets_constants/constants/colors.dart';

class SolhPrimaryTextFormField extends StatefulWidget {
  const SolhPrimaryTextFormField({
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

  @override
  _SolhPrimaryTextFormFieldState createState() => _SolhPrimaryTextFormFieldState();
}

class _SolhPrimaryTextFormFieldState extends State<SolhPrimaryTextFormField> {
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  obscureText: widget.isObscureText,
                  style: widget.textStyle ?? TextStyle(color: SolhColors.white),
                  controller: widget.textEditingController,
                  cursorColor: widget.cursorColor ?? SolhColors.white,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    labelStyle: widget.labelStyle,
                    disabledBorder: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: SolhColors.greyS200),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (widget.isSuffixAvailable)
                TextButton(
                  onPressed: widget.onSuffixPressed,
                  child: Text(
                    widget.suffixText!,
                    style: TextStyle(color: Colors.grey.shade200),
                  ),
                )
            ],
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: widget.borderColor ?? Colors.grey,
              ),
              AnimatedContainer(
                width:
                    _focusNode.hasFocus ? MediaQuery.of(context).size.width : 0,
                duration: Duration(milliseconds: 400),
                height: 1,
                color: widget.focusedBorderColor ?? SolhColors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
