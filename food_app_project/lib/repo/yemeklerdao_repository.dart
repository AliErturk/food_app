import 'dart:convert';

import 'package:food_app_project/entity/sepet_yemekler.dart';
import 'package:food_app_project/entity/sepet_yemekler_cevap.dart';
import 'package:food_app_project/entity/yemekler.dart';
import 'package:food_app_project/entity/yemekler_cevap.dart';
import 'package:http/http.dart' as http;

class YemeklerDaoRepository {
  List<Yemekler> parseYemeklerCevap(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetYemeklerCevap(String cevap) {
    try {
      return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
    } on FormatException catch (_) {
      return <SepetYemekler>[];
    }
  }

  Future<List<Yemekler>> tumYemekleriAl() async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");

    var sepettekiYemekler = await sepettekiYemekleriGetir(kullanici_adi);

    int yeniAdet = yemek_siparis_adet;
    for (final sepettekiYemek in sepettekiYemekler) {
      if (sepettekiYemek.yemek_adi == yemek_adi) {
        yeniAdet =
            yemek_siparis_adet + int.parse(sepettekiYemek.yemek_siparis_adet);
        sepettenYemekSil(
            int.parse(sepettekiYemek.sepet_yemek_id), kullanici_adi);
      }
    }
    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat.toString(),
      "yemek_siparis_adet": yeniAdet.toString(),
      "kullanici_adi": kullanici_adi
    };
    var cevap = await http.post(url, body: veri);
    print("Sepete ekle ${cevap.body}");
  }

  Future<List<SepetYemekler>> sepettekiYemekleriGetir(
      String kullanici_adi) async {
    var url = Uri.parse(
        "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await http.post(url, body: veri);
    print("Sepeti getir: ${cevap.body}");
    return parseSepetYemeklerCevap(cevap.body);
  }

  Future<void> sepettenYemekSil(
      int sepet_yemek_id, String kullanici_adi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {
      "sepet_yemek_id": sepet_yemek_id.toString(),
      "kullanici_adi": kullanici_adi
    };
    var cevap = await http.post(url, body: veri);
    print("Sepetten silindi ${cevap.body}");
  }
}
