part of 'get_it_imports.dart';

void setup() {
  Get.put(AgeController());
  // mood meter
  Get.put<MoodMeterRepo>(MoodMeterRepoImpl());
  Get.put<MoodMeterUsecase>(
      MoodMeterUsecase(moodMeterRepo: Get.find<MoodMeterRepo>()));
  Get.put<GetMoodListController>(
      GetMoodListController(moodMeterUsecase: Get.find<MoodMeterUsecase>()));

  // mood meter slider
  Get.put(SliderController());

  // sub mood list

  Get.put<SubMoodListRepo>(SubMoodListRepoImpl());
  Get.put(SubMoodListUsecase(subMoodListRepo: Get.find<SubMoodListRepo>()));
  Get.put(
      SubMoodController(subMoodListUsecase: Get.find<SubMoodListUsecase>()));

  Get.put<AddMoodRecordRepo>(AddMoodRecordRepoImpl());
  Get.put(
      AddMoodRecordUsecase(addMoodRecordRepo: Get.find<AddMoodRecordRepo>()));
  Get.put(AddMoodRecordController(
      addMoodRecordUsecase: Get.find<AddMoodRecordUsecase>()));
}
