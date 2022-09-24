import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/entity/yemekler.dart';
import 'package:food_app_project/entity/yemekler_firebase.dart';
import 'package:food_app_project/repo/yemeklerdao_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit(): super(<Yemekler>[]);
  var krepo = YemeklerDaoRepository();


  Future<void> yemekYukle() async {
    var liste = await krepo.tumYemekleriAl();
    emit(liste);
  }








}