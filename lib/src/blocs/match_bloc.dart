import 'package:http/http.dart';
import 'package:splat_record/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MatchBloc {
  final _repository = Repository();
  final _matchCreator = PublishSubject<Response>();

  Stream<Response> get createMatchRes =>  _matchCreator.stream;

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
  }

  final bloc = MatchBloc();
}