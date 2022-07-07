import 'package:face_auth_flutter/page/login_page.dart';
import 'package:face_auth_flutter/utils/local_db.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('les donnees de l etudiant'),
      ),
      body: StreamBuilder(
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Card(
                  child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      border: TableBorder.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 2),
                      children: [
                        TableRow(children: [
                          Column(children: [
                            Text('Matricule', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: [
                            Text(documentSnapshot['Matricule'].toString())
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Text('Nom', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: [
                            Text(documentSnapshot['Nom'].toString())
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Text('Niveau', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: [
                            Text(documentSnapshot['Niveau'].toString())
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Text('Filiere', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: [
                            Text(documentSnapshot['Filiere'].toString())
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: [
                            Text('date d inscription',
                                style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: [
                            Text(documentSnapshot['date d inscription']
                                .toDate()
                                .toString())
                          ]),
                        ]),
                      ]),


                );
              },
            );
          }


          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
    Widget buildLogoutButton(BuildContext context) =>
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text(
            'Logout',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () =>
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ),
        );

}
