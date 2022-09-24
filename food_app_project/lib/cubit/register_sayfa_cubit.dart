
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/repo/kullanicilar_dao_repository.dart';

class RegisterSayfaCubit extends Cubit<void>{
  RegisterSayfaCubit(): super(0);
  var krepo = KullanicilarDaoRepository();


  Future<void> kayit(String kullanici_adi,String kullanici_mail,String kullanici_sifre) async{
    await krepo.kullaniciKayit(kullanici_adi,kullanici_mail, kullanici_sifre);
  }
}



