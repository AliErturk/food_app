import 'package:food_app_project/entity/sepet_yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdetCubit extends Cubit<void>{
  AdetCubit():super(0);
  int _yemek_siparis_adet = 1;
  int _sepet_yemek_adeti = 0;
  int get sepet_yemek_adeti =>_sepet_yemek_adeti +_yemek_siparis_adet;
  int get yemek_siparis_adet =>_yemek_siparis_adet;

  void miktariDegistir(bool miktarDegistiMi){
    if(miktarDegistiMi){
      _yemek_siparis_adet=miktariKontrolEt(_yemek_siparis_adet+1);
      print("yemek adeti arttırıldı");
    }else{
      _yemek_siparis_adet=miktariKontrolEt(_yemek_siparis_adet-1);
      print("yemek adeti azaltıldı");
    }
  }
  int miktariKontrolEt(int yemek_siparis_adet){
    if(yemek_siparis_adet<0){
      return 0;
    }else{
      return yemek_siparis_adet;
    }
  }
  void anlikMiktar(){
    _yemek_siparis_adet=1;
    _sepet_yemek_adeti=0;
}





}
