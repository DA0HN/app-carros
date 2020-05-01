import 'package:example/pages/detalhes/loripsum_api.dart';
import 'package:example/utils/bloc.dart';

class DetalhesBloc extends Bloc<String>{

  static String cache;

  void fetch() async {
    var text = cache ?? await LoripsumApi.getLoripsum();
    cache = text;
    add(cache);
  }
}