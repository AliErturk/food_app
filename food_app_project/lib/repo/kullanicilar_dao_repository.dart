
import 'package:food_app_project/sqlite/veritabani_yardimcisi.dart';

class KullanicilarDaoRepository{

  Future<void> kullaniciKayit(String kullanici_adi,String kullanici_mail,String kullanici_sifre) async{
    var db = await VeritabaniYardimcisi.veritabaninaErisim();
    var bilgiler = Map<String,dynamic>();
    bilgiler["kullanici_adi"] = kullanici_adi;
    bilgiler["kullanici_mail"] = kullanici_mail;
    bilgiler["kullanici_sifre"] = kullanici_sifre;
    await db.insert("Kullanicilar", bilgiler);
  }
  Future<bool> mailAra(String aramaKelimesiMail,String aramaKelimesiSifre) async {
    var db = await VeritabaniYardimcisi.veritabaninaErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT*FROM Kullanicilar WHERE kullanici_mail = '$aramaKelimesiMail' and kullanici_sifre = '$aramaKelimesiSifre' ");
    if(maps.isNotEmpty){
      print("true");
      return true;
    }else{
      print("false");
      return false;
    }
  }
  // Future<bool> sifreAra(String aramaKelimesi) async {
  //   var db = await VeritabaniYardimcisi.veritabaninaErisim();
  //   List<Map<String,dynamic>> maps = await db.rawQuery("SELECT*FROM Kullanicilar WHERE kullanici_sifre = '$aramaKelimesi'");
  //    if(await maps.isNotEmpty){
  //     print("true");
  //     return true;
  //   }else{
  //     print("false");
  //     return false;
  //   }
  // }
}