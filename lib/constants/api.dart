import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConstants {
  static final api = dotenv.env['API_CONSTANT'] ?? 'https://api.solhapp.com';
}
