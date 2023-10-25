import 'package:http/http.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MatchBloc {
  final _repository = Repository();
  final _matchCreator = PublishSubject<Response>();
  final _statusBehaviors = BehaviorSubject<String>();

  Stream<Response> get createMatchRes =>  _matchCreator.stream;
  Stream<String> get status =>  _statusBehaviors.stream;

  changeStatus(String statusChange) async {
    _statusBehaviors.sink.add(statusChange);
    _statusBehaviors.stream.forEach((element) {print("Hieu ${element}");});
  }

  createMatch({
    required String name,
    required String location,
    required int type,
    required List<String> players,
  }) async {
    Response response = await _repository.createMatch(name: name, location: location, type: type, players: players);
    _matchCreator.sink.add(response);
  }

  dispose() {
    _matchCreator.close();
    _statusBehaviors.close();
  }

}
final bloc = MatchBloc();
