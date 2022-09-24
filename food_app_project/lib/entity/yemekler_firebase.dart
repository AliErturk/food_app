class YemeklerFirebase {
  String yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  String yemek_fiyat;

  YemeklerFirebase(
      {required this.yemek_id,
        required this.yemek_adi,
        required this.yemek_resim_adi,
        required this.yemek_fiyat});

  factory YemeklerFirebase.fromJson(String key,Map<dynamic,dynamic> json){
    return YemeklerFirebase(
        yemek_id: key,
        yemek_adi: json["yemek_adi"] as String,
        yemek_resim_adi: json["yemek_resim_adi"] as String,
        yemek_fiyat: json["yemek_fiyat"] as String);
  }
}
