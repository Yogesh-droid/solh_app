import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class DeleteJournal {
  final String journalId;

  const DeleteJournal({required this.journalId});

  Future deletePost() async {
    try {
      print('delete journal $journalId');
      await Network.makeHttpDeleteRequestWithToken(
          url: "${APIConstants.api}/api/journal/$journalId", body: {});
    } catch (e) {
      print(e);
    }
  }
}
