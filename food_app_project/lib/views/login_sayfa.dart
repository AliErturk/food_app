import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/cubit/login_sayfa_cubit.dart';
import 'package:food_app_project/repo/kullanicilar_dao_repository.dart';
import 'package:food_app_project/views/anasayfa.dart';
import 'package:food_app_project/views/register_sayfa.dart';

class LoginSayfa extends StatefulWidget {
  const LoginSayfa({Key? key}) : super(key: key);

  @override
  State<LoginSayfa> createState() => _LoginSayfaState();
}

class _LoginSayfaState extends State<LoginSayfa> {
  var tfKullaniciMail = TextEditingController();
  var tfKullaniciSifre = TextEditingController();
  var hesapDogruMu = false;
  var krepo = KullanicilarDaoRepository();
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("images/logo.PNG"),
                TextField(
                  controller: tfKullaniciMail,
                  decoration: const InputDecoration(hintText: "E-Mail"),
                ),
                TextField(
                  controller: tfKullaniciSifre,
                  decoration: const InputDecoration(hintText: "Şifre"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          hesapDogruMu = await context
                              .read<LoginSayfaCubit>()
                              .mailKontrol(tfKullaniciMail.text,tfKullaniciSifre.text);
                          // sifreDogruMu = await context
                          //     .read<LoginSayfaCubit>()
                          //     .sifreKontrol(tfKullaniciSifre.text);
                          setState(() {

                            if (hesapDogruMu == true){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Anasayfa(),
                                  ));
                            }
                          });
                        },
                        child: const Text(
                          "Giriş Yap",
                          style: TextStyle(fontSize: 20, fontFamily: "Yazi"),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterSayfa(),
                              ));
                        },
                        child: const Text(
                          "Kayıt Ol",
                          style: TextStyle(fontSize: 20, fontFamily: "Yazi"),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
