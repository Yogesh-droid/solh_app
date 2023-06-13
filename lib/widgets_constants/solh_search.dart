import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/colors.dart';

class SolhSearch extends StatelessWidget {
  const SolhSearch(
      {Key? key,
      required TextEditingController textController,
      this.focusNode,
      this.onCloseBtnTap,
      this.onSubmitted,
      this.onTextChaged})
      : _textController = textController,
        super(key: key);
  final TextEditingController _textController;
  final FocusNode? focusNode;
  final Function()? onCloseBtnTap;
  final Function(String value)? onSubmitted;
  final Function(String value)? onTextChaged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        border: Border.all(
          color: SolhColors.primary_green,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: SolhColors.primary_green,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: VerticalDivider(
              color: SolhColors.primary_green,
              width: 2,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: TextField(
                  controller: _textController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search'.tr,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    suffixIcon: InkWell(
                      onTap: onCloseBtnTap,
                      child: Icon(
                        Icons.close,
                        color: SolhColors.primary_green,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmitted: onSubmitted,
                  onChanged: onTextChaged),
            ),
          ),
        ],
      ),
    );
  }
}


/* 

====== on Submitted =====

(value) async {
                  await searchMarketController.getSearchResults(value);
                },

                ======================


=========== on changed =============

(Value) async {
                  if (Value.length > 0) {
                    await searchMarketController.getSuggestions(Value);
                  } else if (Value.length == 0) {
                    searchMarketController.suggestionList.value = [];
                    searchMarketController.suggestionList.refresh();
                  }
                },


                ==============





 */