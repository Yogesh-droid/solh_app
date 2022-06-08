import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/getHelp/search_market_controller.dart';
import 'package:solh/model/doctor.dart';
import 'package:solh/ui/screens/get-help/consultant_tile.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchMarketController searchMarketController = Get.find();
  final TextEditingController searchController = TextEditingController();

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
            /*  Obx(() => searchMarketController.searchMarketModel.value.doctors !=
                    null
                ? searchMarketController
                        .searchMarketModel.value.doctors!.isNotEmpty
                    ? ListView(
                        shrinkWrap: true,
                        children: searchMarketController
                            .searchMarketModel.value.doctors!
                            .map(
                              (item) => Column(
                                children: [
                                  ConsultantsTile(
                                      doctorModel: DoctorModel(
                                          organisation: item.organisation ?? '',
                                          name: item.name ?? '',
                                          mobile: item.contactNumber ?? '',
                                          email: item.email ?? '',
                                          clinic: '',
                                          locality: item.addressLineOne ?? '',
                                          pincode: '',
                                          city: item.addressLineFour ?? '',
                                          bio: item.bio ?? '',
                                          abbrevations: '')),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )
                            .toList(),
                      )
                    : SizedBox()
                : Container(
                    child: Center(
                      child: Text('No results found'),
                    ),
                  )),
            Obx(() => searchMarketController.searchMarketModel.value.provider !=
                    null
                ? searchMarketController
                        .searchMarketModel.value.provider!.isNotEmpty
                    ? ListView(
                        shrinkWrap: true,
                        children: searchMarketController
                            .searchMarketModel.value.provider!
                            .map(
                              (item) => Column(
                                children: [
                                  ConsultantsTile(
                                      doctorModel: DoctorModel(
                                          organisation: '',
                                          name: item.name ?? '',
                                          mobile: item.contactNumber ?? '',
                                          email: item.email ?? '',
                                          clinic: '',
                                          locality: item.addressLineOne ?? '',
                                          pincode: '',
                                          city: item.addressLineFour ?? '',
                                          bio: item.bio ?? '',
                                          abbrevations: '')),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )
                            .toList(),
                      )
                    : SizedBox()
                : Container(
                    child: Center(
                      child: Text('No results found'),
                    ),
                  )),*/

            Obx(() {
              return searchMarketController.suggestionList.value.length > 0
                  ? Expanded(
                      child: getSuggestionList(
                          searchMarketController.suggestionList.value),
                    )
                  : Obx(() => Expanded(
                        child: searchMarketController
                                        .searchMarketModel.value.doctors !=
                                    null ||
                                searchMarketController
                                        .searchMarketModel.value.provider !=
                                    null
                            ? CustomScrollView(
                                slivers: [
                                  if (searchMarketController.searchMarketModel
                                          .value.doctors!.isEmpty &&
                                      searchMarketController.searchMarketModel
                                          .value.provider!.isEmpty)
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
                                        doctorModel: DoctorModel(
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
                                          mobile: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .doctors![index]
                                                  .contactNumber ??
                                              '',
                                          email: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .doctors![index]
                                                  .email ??
                                              '',
                                          clinic: '',
                                          locality: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .doctors![index]
                                                  .addressLineOne ??
                                              '',
                                          pincode: '',
                                          city: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .doctors![index]
                                                  .addressLineFour ??
                                              '',
                                          bio: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .doctors![index]
                                                  .bio ??
                                              '',
                                          abbrevations: '',
                                          profilePicture: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .doctors![index]
                                                  .profilePicture ??
                                              '',
                                        ),
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
                                        doctorModel: DoctorModel(
                                          organisation: '',
                                          name: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .provider![index]
                                                  .name ??
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
                                          profilePicture: searchMarketController
                                                  .searchMarketModel
                                                  .value
                                                  .provider![index]
                                                  .profilePicture ??
                                              '',
                                        ),
                                        onTap: () {},
                                      ),
                                      childCount: searchMarketController
                                          .searchMarketModel
                                          .value
                                          .provider!
                                          .length,
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

  Widget getSearchField(BuildContext context) {
    return Container(
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
    );
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
              await searchMarketController.getSearchResults(item['name']);
              searchMarketController.suggestionList.refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['name'],
                style: TextStyle(
                  color: SolhColors.green,
                  fontSize: 18,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
