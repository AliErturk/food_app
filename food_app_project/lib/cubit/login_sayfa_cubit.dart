import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/repo/kullanicilar_dao_repository.dart';

class LoginSayfaCubit extends Cubit<void> {
  LoginSayfaCubit() : super(0);
  var krepo = KullanicilarDaoRepository();

  Future<bool> mailKontrol(String aramaKelimesiMail , String aramaKelimesiSifre) async {
    final cevap = await krepo.mailAra(aramaKelimesiMail,aramaKelimesiSifre);
    return cevap;
  }

  // Future<bool> sifreKontrol(String aramaKelimesi) async {
  //   final cevap = await krepo.sifreAra(aramaKelimesi);
  //   return cevap;
  // }
}
