import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/cubit/adet_cubit.dart';
import 'package:food_app_project/cubit/sepet_sayfa_cubit.dart';
import 'package:food_app_project/entity/sepet_yemekler.dart';

class SepetSayfa extends StatefulWidget {
  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {




  var adet = AdetCubit();
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetiGoster("alierturk@gmail.com");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "Ye'dir",
          style: TextStyle(
            fontFamily: "Pacifico",
            color: Colors.orangeAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
          builder: (context, sepetListesi) {
        if (sepetListesi.isNotEmpty) {
          return SingleChildScrollView(
            child: Container(
              height: 650,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: sepetListesi.length,
                itemBuilder: (context, indeks) {
                  var sepet = sepetListesi[indeks];
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${sepet.yemek_adi}",
                              style:
                                  TextStyle(fontFamily: "Yazi", fontSize: 25),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${sepet.yemek_fiyat}",
                                  style:const  TextStyle(
                                      fontFamily: "Yazi", fontSize: 25),
                                ),
                                const Text(
                                  "₺",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Image.network(
                          "http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}",
                          width: 100,
                          height: 100,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // IconButton(onPressed: (){
                            //   setState(() {
                            //     setState(() {
                            //       adet.miktariDegistir(false);
                            //     });
                            //   });
                            // }, icon: Icon(Icons.remove)),
                            Text(
                              "${sepet.yemek_siparis_adet} Adet",
                              style:
                                  const TextStyle(fontFamily: "Yazi", fontSize: 20),
                            ),
                            // IconButton(onPressed: (){
                            //   setState(() {
                            //     adet.miktariDegistir(true);
                            //   });
                            //
                            // }, icon: Icon(Icons.add)),

                            IconButton(
                                onPressed: () {
                                  context.read<SepetSayfaCubit>().yemekSil(
                                      int.parse(sepet.sepet_yemek_id),
                                      "alierturk@gmail.com");
                                },
                                icon:const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else if (sepetListesi.isEmpty) {
          return const Center(
            child: Text(
              "Sepetiniz Boş",
              style: TextStyle(fontFamily: "Yazi", fontSize: 20),
            ),
          );
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add_card),
        label:const Text(
          "SİPARİŞ VER",
          style: TextStyle(fontSize: 25, fontFamily: "Yazi"),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SepetSayfa(),
              )).then((value) {
            context.read<SepetSayfaCubit>().sepetiGoster("alierturk@gmail.com");
            Navigator.of(context).pop();
          });
        },
      ),
    );
  }
}
