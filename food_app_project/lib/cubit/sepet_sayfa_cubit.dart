import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/entity/sepet_yemekler.dart';
import 'package:food_app_project/repo/yemeklerdao_repository.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  SepetSayfaCubit() : super(<SepetYemekler>[]);
  var krepo = YemeklerDaoRepository();

  Future<void> sepetiGoster(String kullanici_adi) async {
    var sepet_yemekler = await krepo.sepettekiYemekleriGetir(kullanici_adi);
    emit(sepet_yemekler);
  }

  Future<void> yemekSil(int sepet_yemek_id, String kullanici_adi) async {
    await krepo.sepettenYemekSil(sepet_yemek_id, kullanici_adi);
    await sepetiGoster(kullanici_adi);
  }
}
