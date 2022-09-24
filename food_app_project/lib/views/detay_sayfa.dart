import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/cubit/detay_sayfa_cubit.dart';
import 'package:food_app_project/entity/sepet_yemekler.dart';
import 'package:food_app_project/entity/yemekler.dart';
import 'package:food_app_project/cubit/adet_cubit.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;

  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var yemekAdi;
  var yemekFiyati;
  var yemekResimAdi;
  var adet = AdetCubit();
  late SepetYemekler sepetYemekler;





  @override
  void initState() {
    super.initState();
    var yemek = widget.yemek;
    yemekAdi = yemek.yemek_adi;
    yemekFiyati = yemek.yemek_fiyat;
    yemekResimAdi = yemek.yemek_resim_adi;
    context.read<AdetCubit>().anlikMiktar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ye'dir",
          style: TextStyle(
            fontFamily: "Pacifico",
            color: Colors.orangeAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              "http://kasimadalan.pe.hu/yemekler/resimler/$yemekResimAdi",
              width: 150,
              height: 150,
            ),
            Text(
              "$yemekAdi",
              style: const TextStyle(fontSize: 25, fontFamily: "Yazi"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$yemekFiyati",
                  style: const TextStyle(fontSize: 25, fontFamily: "Yazi"),
                ),
                const Text(
                  "₺",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.green,
                  width: 40,
                  height: 40,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            adet.miktariDegistir(false);
                          });
                        },
                        icon: const Icon(Icons.remove)),
                  ),
                ),
                Container(
                    width: 40,
                    height: 40,
                    color: Colors.white24,
                    child: Center(
                        child: Text(
                      (adet.yemek_siparis_adet).toString(),
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))),
                Container(
                  color: Colors.green,
                  width: 40,
                  height: 40,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            adet.miktariDegistir(true);
                          });
                        },
                        icon: const Icon(Icons.add)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Toplam Fiyat : ${int.parse(yemekFiyati) * adet.yemek_siparis_adet}",
                  style: const TextStyle(fontFamily: "Yazi", fontSize: 25),
                ),
                const Text(
                  "₺",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<DetaySayfaCubit>().sepeteEkle(
                      yemekAdi,
                      yemekResimAdi,
                      int.parse(yemekFiyati),
                      adet.yemek_siparis_adet,
                      "alierturk@gmail.com");
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "SEPETE EKLE",
                  style: TextStyle(fontFamily: "Yazi", fontSize: 25),
                )),
          ],
        ),
      ),
    );
  }
}
