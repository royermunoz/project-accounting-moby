// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'createBill.dart';
import 'createPayment.dart';
import 'createUser.dart';
import 'models/billModel.dart';
import 'models/paymentModel.dart';
import 'models/userModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<UserModel> usersList = <UserModel>[];
  List<PaymentModel> paymentsList = <PaymentModel>[];
  List<BillModel> billsList = <BillModel>[];

  late int monthPayments = 0;
  late int monthBills = 0;

  static const List<BottomNavigationBarItem> _navigationItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Usuarios'),
    BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on_outlined), label: 'Finanzas'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _widgets(BuildContext context, int selectedIndex) {
    List<Widget> widgetOptions = <Widget>[
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Usuarios",
                style: TextStyle(
                  color: Color(0xFF0066FF),
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                autofocus: false,
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  //nameEditingController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  labelText: 'Buscar usuario',
                  contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                ),
              ),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                controller: ScrollController(),
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                itemCount: usersList.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: getColor(paymentsList,
                              '${usersList[index].identification}'),
                          width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${usersList[index].name} ${usersList[index].lastName}.',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            'Identificación: ${usersList[index].identification}. \n'
                            'Ip: ${usersList[index].ip}. \n'
                            'Plan: ${usersList[index].plan}. \n'
                            'Número de telefono: ${usersList[index].phoneNumber}.',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 60,
                            width: 180,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                    width: 0.5, color: Colors.black),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(16.0),
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreatePayment(
                                          '${usersList[index].identification}')),
                                );
                              },
                              child: const Text("Registrar pago"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20);
                },
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Finanzas",
                style: TextStyle(
                  color: Color(0xFF0066FF),
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 45),
              const Text(
                "Ingresos del mes:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "\$$monthPayments",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 45),
              const Text(
                "Gastos del mes:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "\$$monthBills",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 45),
              const Text(
                "Saldo total del mes:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "\$${monthPayments - monthBills}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    return widgetOptions.elementAt(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").get().then((value) {
      usersList =
          value.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
      setState(() {});
    });

    FirebaseFirestore.instance
        .collection("payments")
        .where("month", isEqualTo: DateTime.now().month)
        .where("year", isEqualTo: DateTime.now().year)
        .get()
        .then((value) {
      paymentsList =
          value.docs.map((doc) => PaymentModel.fromMap(doc.data())).toList();

      for (int i = 0; i < paymentsList.length; i++) {
        monthPayments += paymentsList[i].payment!;
      }

      setState(() {});
    });

    FirebaseFirestore.instance
        .collection("bills")
        .where("month", isEqualTo: DateTime.now().month)
        .where("year", isEqualTo: DateTime.now().year)
        .get()
        .then((value) {
      billsList =
          value.docs.map((doc) => BillModel.fromMap(doc.data())).toList();

      for (int i = 0; i < billsList.length; i++) {
        monthBills += billsList[i].worth!;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: _widgets(context, _selectedIndex),
          ),
        ),
      ),
      floatingActionButton: getFloationButton(context, _selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _navigationItems,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF0066FF),
        onTap: _onItemTapped,
      ),
    );
  }
}

Color getColor(List<PaymentModel> paymentsList, String identification) {
  for (int i = 0; i < paymentsList.length; i++) {
    if (identification == paymentsList[i].identification) {
      return Colors.green;
    }
  }
  return Colors.red;
}

FloatingActionButton getFloationButton(BuildContext context, int selectIndex) {
  if (selectIndex == 0) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateUser()),
        );
      },
    );
  } else {
    return FloatingActionButton(
      child: const Icon(Icons.add_shopping_cart),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateBill()),
        );
      },
    );
  }
}
