import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/cubit/anayayfa_cubit.dart';
import 'package:food_app_project/cubit/sepet_sayfa_cubit.dart';
import 'package:food_app_project/cubit/yemekler_firebase_cubit.dart';

import 'package:food_app_project/entity/yemekler.dart';
import 'package:food_app_project/views/detay_sayfa.dart';
import 'package:food_app_project/views/sepet_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(hintText: "Ara"),
                onChanged: (aramaSonucu) {
                  context.read<YemeklerFirebaseCubit>().ara(aramaSonucu);
                },
              )
            : const Text(
                "Ye'dir",
                style: TextStyle(
                  fontFamily: "Pacifico",
                  color: Colors.orangeAccent,
                ),
              ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      context.read<AnasayfaCubit>().yemekYukle();
                    });
                  },
                  icon: const Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
          builder: (context, yemekListesi) {
        if (yemekListesi.isNotEmpty) {
          return Container(
            height: 650,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: yemekListesi.length,
                itemBuilder: (context, index) {
                  var yemek = yemekListesi[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetaySayfa(yemek: yemek),
                          )).then((value) {
                        context.read<AnasayfaCubit>().yemekYukle();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "${yemek.yemek_adi}",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: "Yazi"),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${yemek.yemek_fiyat}  ",
                                        style: TextStyle(
                                            fontSize: 20, fontFamily: "Yazi"),
                                      ),
                                      Text(
                                        "₺",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Image.network(
                              "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.shopping_cart),
        label: Text(
          "SEPETE GİT",
          style: TextStyle(fontSize: 25, fontFamily: "Yazi"),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SepetSayfa(),
              )).then((value) {
            context.read<SepetSayfaCubit>().sepetiGoster("alierturk@gmail.com");
          });
        },
      ),
    );
  }
}
