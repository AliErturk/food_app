import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/cubit/register_sayfa_cubit.dart';


class RegisterSayfa extends StatefulWidget {
  const RegisterSayfa({Key? key}) : super(key: key);

  @override
  State<RegisterSayfa> createState() => _RegisterSayfaState();
}

class _RegisterSayfaState extends State<RegisterSayfa> {
  var tfKullaniciAdi = TextEditingController();
  var tfKullaniciMail = TextEditingController();
  var tfKullaniciSifre = TextEditingController();

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset("images/logo.PNG"),
                TextField(
                  controller: tfKullaniciAdi,
                  decoration: const InputDecoration(hintText: "Kullanıcı Adı"),
                ),
                TextField(
                  controller: tfKullaniciMail,
                  decoration:const InputDecoration(hintText: "E-Mail"),
                ),
                TextField(
                  controller: tfKullaniciSifre,
                  decoration: const InputDecoration(hintText: "Şifre"),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<RegisterSayfaCubit>().kayit(
                        tfKullaniciAdi.text,
                        tfKullaniciMail.text,
                        tfKullaniciSifre.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Kayıt Ol",
                    style: TextStyle(fontSize: 20, fontFamily: "Yazi"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
