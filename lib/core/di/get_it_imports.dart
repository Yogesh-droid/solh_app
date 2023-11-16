import 'package:get/get.dart';
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/features/mood_meter/data/repo/add_mood_record_repo_impl.dart';
import 'package:solh/features/mood_meter/data/repo/mood_meter_repo_impl.dart';
import 'package:solh/features/mood_meter/data/repo/sub_mood_list_repo_impl.dart';
import 'package:solh/features/mood_meter/domain/repo/add_mood_record_repo.dart';
import 'package:solh/features/mood_meter/domain/repo/mood_meter_repo.dart';
import 'package:solh/features/mood_meter/domain/repo/sub_mood_list_repo.dart';
import 'package:solh/features/mood_meter/domain/usecases/add_mood_record_usecase.dart';
import 'package:solh/features/mood_meter/domain/usecases/mood_meter_usecase.dart';
import 'package:solh/features/mood_meter/domain/usecases/sub_mood_list_usecase.dart';
import 'package:solh/features/mood_meter/ui/controllers/add_mood_record_controller.dart';
import 'package:solh/features/mood_meter/ui/controllers/get_sub_mood_controller.dart';

import '../../features/mood_meter/ui/controllers/get_mood_list_controller.dart';
import '../../features/mood_meter/ui/controllers/slider_controller.dart';
part 'get_it_setup.dart';
