import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/ui/screens/get-help/consultant_tile.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/solh_search.dart';

import '../../../widgets_constants/constants/textstyles.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchMarketController searchMarketController = Get.find();

  final TextEditingController searchController = TextEditingController();

  GetHelpController getHelpController = Get.find();

  String? defaultCountry;

  BookAppointmentController bookAppointmentController = Get.find();

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.requestFocus();
    getResultByCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getSearchField(context),
            ),
            const SizedBox(height: 16),
            Obx(() => searchMarketController.isLoading.value
                ? LinearProgressIndicator(
                    minHeight: 1,
                  )
                : SizedBox()),
            Obx(() {
              return searchMarketController.suggestionList.length > 0
                  ? Expanded(
                      child: getSuggestionList(
                          searchMarketController.suggestionList),
                    )
                  : Obx(() => Expanded(
                        child: searchMarketController
                                        .searchMarketModel.value.doctors !=
                                    null ||
                                searchMarketController
                                        .searchMarketModel.value.provider !=
                                    null
                            ? Stack(
                                children: [
                                  CustomScrollView(
                                    slivers: [
                                      if (searchMarketController
                                              .searchMarketModel
                                              .value
                                              .doctors!
                                              .isEmpty &&
                                          searchMarketController
                                              .searchMarketModel
                                              .value
                                              .provider!
                                              .isEmpty)
                                        SliverToBoxAdapter(
                                          child: Container(
                                            child: Center(
                                              child: Text('No results found'),
                                            ),
                                          ),
                                        ),
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) => ConsultantsTile(
                                            currency: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .doctors![index]
                                                    .feeCurrency ??
                                                '',
                                            feeAmount: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .doctors![index]
                                                    .fee_amount ??
                                                0,
                                            id: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .doctors![index]
                                                    .sId ??
                                                '',
                                            name: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .doctors![index]
                                                    .name ??
                                                '',
                                            prefix: searchMarketController
                                                .searchMarketModel
                                                .value
                                                .doctors![index]
                                                .prefix,
                                            profilePic: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .doctors![index]
                                                    .profilePicture ??
                                                '',
                                            specialization:
                                                searchMarketController
                                                        .searchMarketModel
                                                        .value
                                                        .doctors![index]
                                                        .specialization ??
                                                    '',
                                            bio: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .doctors![index]
                                                    .bio ??
                                                '',
                                            fee: searchMarketController
                                                .searchMarketModel
                                                .value
                                                .doctors![index]
                                                .fee,

                                            /* doctorModel: DoctorModel(
                                                organisation: searchMarketController
                                                        .searchMarketModel
                                                        .value
                                                        .doctors![index]
                                                        .organisation ??
                                                    '',
                                                name: searchMarketController
                                                        .searchMarketModel
                                                        .value
                                                        .doctors![index]
                                                        .name ??
                                                    '',
                                                prefix: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .doctors![index]
                                                    .prefix,
                                                fee: searchMarketController
                                                        .searchMarketModel
                                                        .value
                                                        .doctors![index]
                                                        .fee ??
                                                    '',
                                                feeCurrency: searchMarketController
                                                        .searchMarketModel
                                                        .value
                                                        .doctors![index]
                                                        .feeCurrency ??
                                                    '',
                                                fee_amount: searchMarketController.searchMarketModel.value.doctors![index].fee_amount ?? 0,
                                                mobile: searchMarketController.searchMarketModel.value.doctors![index].contactNumber ?? '',
                                                email: searchMarketController.searchMarketModel.value.doctors![index].email ?? '',
                                                clinic: '',
                                                locality: searchMarketController.searchMarketModel.value.doctors![index].addressLineOne ?? '',
                                                pincode: '',
                                                city: searchMarketController.searchMarketModel.value.doctors![index].addressLineFour ?? '',
                                                bio: searchMarketController.searchMarketModel.value.doctors![index].bio ?? '',
                                                abbrevations: '',
                                                profilePicture: searchMarketController.searchMarketModel.value.doctors![index].profilePicture ?? '',
                                                id: searchMarketController.searchMarketModel.value.doctors![index].sId ?? '',
                                                specialization: searchMarketController.searchMarketModel.value.doctors![index].specialization ?? ''), */
                                            onTap: () {},
                                          ),
                                          childCount: searchMarketController
                                              .searchMarketModel
                                              .value
                                              .doctors!
                                              .length,
                                        ),
                                      ),
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) => ConsultantsTile(
                                            specialization: '',
                                            fee: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .provider![index]
                                                    .fee ??
                                                '',
                                            prefix: searchMarketController
                                                .searchMarketModel
                                                .value
                                                .provider![index]
                                                .prefix,
                                            currency: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .provider![index]
                                                    .feeCurrency ??
                                                '',
                                            feeAmount: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .provider![index]
                                                    .fee_amount ??
                                                0,
                                            name: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .provider![index]
                                                    .name ??
                                                '',
                                            id: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .provider![index]
                                                    .sId ??
                                                '',
                                            bio: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .provider![index]
                                                    .bio ??
                                                '',
                                            profilePic: searchMarketController
                                                    .searchMarketModel
                                                    .value
                                                    .provider![index]
                                                    .profilePicture ??
                                                '',
                                            /* doctorModel: DoctorModel(
                                              specialization: '',
                                              organisation: '',
                                              fee: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .fee ??
                                                  '',
                                              prefix: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .provider![index]
                                                  .prefix,
                                              feeCurrency:
                                                  searchMarketController
                                                          .searchMarketModel
                                                          .value
                                                          .provider![index]
                                                          .feeCurrency ??
                                                      '',
                                              fee_amount: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .fee_amount ??
                                                  0,
                                              name: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .name ??
                                                  '',
                                              id: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .sId ??
                                                  '',
                                              mobile: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .contactNumber ??
                                                  '',
                                              email: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .email ??
                                                  '',
                                              clinic: '',
                                              locality: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .addressLineOne ??
                                                  '',
                                              pincode: '',
                                              city: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .addressLineFour ??
                                                  '',
                                              bio: searchMarketController
                                                      .searchMarketModel
                                                      .value
                                                      .provider![index]
                                                      .bio ??
                                                  '',
                                              abbrevations: '',
                                              profilePicture:
                                                  searchMarketController
                                                          .searchMarketModel
                                                          .value
                                                          .provider![index]
                                                          .profilePicture ??
                                                      '',
                                            ), */
                                            onTap: () async {},
                                          ),
                                          childCount: searchMarketController
                                              .searchMarketModel
                                              .value
                                              .provider!
                                              .length,
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 40,
                                    right: 20,
                                    child: FloatingActionButton(
                                      child: Icon(
                                        Icons.filter_alt_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        openBottomSheet(context);
                                      },
                                      backgroundColor: SolhColors.pink224,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ));
            }),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: ((context) =>
            Obx(() => getHelpController.isCountryLoading.value
                ? LinearProgressIndicator()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Filter counselor'.tr,
                            style: SolhTextStyles.JournalingUsernameText,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Country'.tr,
                                style: SolhTextStyles.JournalingUsernameText,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: SolhColors.primary_green),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: defaultCountry != null
                                    ? Text(defaultCountry!)
                                    : Text('Select Country'),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: getHelpController.counsellorsCountryModel
                                .value.providerCountry!.length,
                            itemBuilder: (context, index) => ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getHelpController
                                                .counsellorsCountryModel
                                                .value
                                                .providerCountry![index]
                                                .name ??
                                            '',
                                        style:
                                            SolhTextStyles.JournalingHintText,
                                      ),
                                      getHelpController
                                                  .counsellorsCountryModel
                                                  .value
                                                  .providerCountry![index]
                                                  .code !=
                                              defaultCountry
                                          ? Container()
                                          : Icon(Icons.check),
                                    ],
                                  ),
                                  onTap: () {
                                    defaultCountry = getHelpController
                                            .counsellorsCountryModel
                                            .value
                                            .providerCountry![index]
                                            .code ??
                                        '';
                                    debugPrint(defaultCountry);
                                    searchMarketController.getSearchResults(
                                        searchController.text,
                                        c: defaultCountry);
                                    Navigator.pop(context);
                                  },
                                ))
                      ],
                    ),
                  ))));
  }

  Widget getSearchField(BuildContext context) {
    return SolhSearch(
      textController: searchController,
      onCloseBtnTap: onClosetapped,
      onSubmitted: onTextSubmitted,
      onTextChaged: onTextChanged,
    );

    /* return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        border: Border.all(
          color: SolhColors.green,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: SolhColors.green,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: VerticalDivider(
              color: SolhColors.green,
              width: 2,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      searchController.clear();
                    },
                    child: Icon(
                      Icons.close,
                      color: SolhColors.green,
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) async {
                  await searchMarketController.getSearchResults(value);
                },
                onChanged: (Value) async {
                  if (Value.length > 0) {
                    await searchMarketController.getSuggestions(Value);
                  } else if (Value.length == 0) {
                    searchMarketController.suggestionList.value = [];
                    searchMarketController.suggestionList.refresh();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    ); */
  }

  Widget getSuggestionList(List value) {
    return Padding(
      padding: const EdgeInsets.only(left: 38.0),
      child: ListView(
        shrinkWrap: true,
        children: value.map((item) {
          return InkWell(
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              searchMarketController.suggestionList.clear();
              searchController.text = item['name'];
              await searchMarketController.getSearchResults(item['name'],
                  c: defaultCountry);
              bookAppointmentController.query = item['name'];
              searchMarketController.suggestionList.refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['name'],
                style: TextStyle(
                  color: SolhColors.primary_green,
                  fontSize: 18,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  onClosetapped() {
    searchController.clear();
  }

  onTextSubmitted(String value) async {
    await searchMarketController.getSearchResults(value, c: defaultCountry);
  }

  onTextChanged(String value) async {
    if (value.length > 0) {
      await searchMarketController.getSuggestions(value);
    } else if (value.length == 0) {
      searchMarketController.suggestionList.value = [];
      searchMarketController.suggestionList.refresh();
    }
  }

  Future<void> getResultByCountry() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    defaultCountry = sharedPreferences.getString('userCountry');
    debugPrint('@' * 30 + 'default country is $defaultCountry' + ' &' * 30);
  }
}
