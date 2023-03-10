import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/anasayfa.dart';
import 'package:flutter_application_7/girisekrani.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class kayitekrani extends StatefulWidget {
  const kayitekrani({super.key});

  @override
  _kayitekraniState createState() => _kayitekraniState();
}

class _kayitekraniState extends State<kayitekrani> {
  //.................KAYIT PARAMETRELERİ
  late String email, sifre;
  //************ */
  final _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('TREXGO '),
        centerTitle: true,
      ),
      body: Form(
        key: _formAnahtari,
        child: Container(
          color: Colors.cyanAccent,
          padding: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (alinanMail) {
                    setState(() {
                      email = alinanMail;
                    });
                  },
                  validator: (alinanMail) {
                    return alinanMail!.contains("@") ? null : "Mail geçersiz";
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "E-mail giriniz",
                      hintText: "Geçerli email girin",
                      border: OutlineInputBorder()
                      ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (alinanSifre) {
                    sifre = alinanSifre;
                  },
                  validator: (alinansifre) {
                    return alinansifre!.length >= 6 ? null : "En az 6 karakter";
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Şifre giriniz",
                      hintText: "Geçerli şifr giriniz",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      kayitEkle();
                    },
                    child: const Text("kaydol"),
                    style: ElevatedButton.styleFrom(
                      textStyle: GoogleFonts.roboto(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      //*************girişsayfasına gitsin*/
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => girisekrani()));
                    },
                    child: const Text(
                      "Aktif hesabım var...",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //\********email ve şifreye göre firebse kullanıcı ekle
  void kayitEkle() {
    if (_formAnahtari.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
//..........başarılıysa anasayfaya git
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const anasayfa()));
      }).catchError((hata) {
//.......başarılı değilse hata mesajı ver
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
