import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/anasayfa.dart';
import 'package:flutter_application_7/kayitekrani.dart';
import 'package:fluttertoast/fluttertoast.dart';

class girisekrani extends StatefulWidget {
  const girisekrani({super.key});

  @override
  State<girisekrani> createState() => _girisekraniState();
}

class _girisekraniState extends State<girisekrani> {
  //...........giriş parametreleri
  late String email, sifre;

  //doğrulama anahtarı
  var _forAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("TREXGO"),
      ),
      body: Form(
        key: _forAnahtari,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (alinanEmail) {
                    email = alinanEmail;
                  },
                  validator: (alinanEmail) {
                    return alinanEmail!.contains("@") ? null : "Geçersiz email";
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (alinansifre) {
                    sifre = alinansifre;
                  },
                  validator: (alinanSifre) {
                    return alinanSifre!.length >= 6 ? null : "En az 6 karakter";
                  },
                  decoration: InputDecoration(
                    labelText: "Sifre",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                height: 70,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      girisyap();
                    },
                    child: Text("Giriş")),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => kayitekrani()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text("Hesap oluştur",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //........email ve sifreyi göre doğrulama yapıp giriş yapacak
  void girisyap() {
    if (_forAnahtari.currentState!.validate()) {
//.......giris yap
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: sifre)
          .then((User) {
//........eger basarılıysa anasayfaya git
        Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_)=>anasayfa()), (Route)=>false);
          }).catchError((hata){
Fluttertoast.showToast(msg: hata);
          });
    }
  }
}
