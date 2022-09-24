import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/entity/yemekler_firebase.dart';

class YemeklerFirebaseCubit extends Cubit<List<YemeklerFirebase>>{
  YemeklerFirebaseCubit(): super(<YemeklerFirebase>[]);

  var refKisiler =FirebaseDatabase.instance.ref().child("yemekler");


  Future<void> ara(String aramaKelimesi) async {
    refKisiler.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value as dynamic;
      if(gelenDegerler != null ){
        var liste = <YemeklerFirebase>[];
        gelenDegerler.forEach((key,nesne){
          var yemek=YemeklerFirebase.fromJson(key, nesne);
          if(yemek.yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase())){
            liste.add(yemek);
          }
        });
        emit(liste);
      }
    });
  }
}