import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/entity/sepet_yemekler.dart';
import 'package:food_app_project/repo/yemeklerdao_repository.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit() : super(0);

  var krepo = YemeklerDaoRepository();

  Future<void> sepeteEkle(String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    await krepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat,
        yemek_siparis_adet, kullanici_adi);
  }
}
