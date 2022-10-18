// ignore_for_file: unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../homeScreen.dart';
import 'package:intl/intl.dart';
import 'models/billModel.dart';

class CreateBill extends StatefulWidget {
  const CreateBill({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreatePaymentState createState() => _CreatePaymentState();
}

class _CreatePaymentState extends State<CreateBill> {
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final descriptionEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final worthEditingController = TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //description field
    final descriptionField = TextFormField(
      autofocus: false,
      controller: descriptionEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("La descripción del gasto no puede estar vacía");
        }
        return null;
      },
      onSaved: (value) {
        descriptionEditingController.text = value!;
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
            Icons.abc,
            color: Colors.grey,
          ),
        ),
        labelText: 'Descripción del gasto',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //date field
    final dateField = TextFormField(
      autofocus: false,
      controller: dateEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("La fecha de gasto no puede estar vacía");
        }
        return null;
      },
      onSaved: (value) {
        dateEditingController.text = value!;
      },
      onTap: () => {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2018),
          lastDate: DateTime(2222),
        ).then((date) => {
              if (date != null)
                {
                  setState((() {
                    dateEditingController.text =
                        DateFormat('yyyy-MM-d').format(date);
                  })),
                },
            }),
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
            Icons.calendar_month,
            color: Colors.grey,
          ),
        ),
        labelText: 'Fecha de gasto',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //worth field
    final worthField = TextFormField(
      autofocus: false,
      controller: worthEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("El valor de gasto no puede estar vacío");
        }
        return null;
      },
      onSaved: (value) {
        worthEditingController.text = value!;
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
            Icons.monetization_on,
            color: Colors.grey,
          ),
        ),
        labelText: 'Valor del gasto',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //signup button
    final signUpButton = SizedBox(
      height: 60,
      width: 250,
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16.0),
            backgroundColor: const Color(0xFF0066FF),
            textStyle: const TextStyle(fontSize: 22),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0))),
        onPressed: () {
          createUser();
        },
        child: const Text("Registrar gasto"),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Gastos",
                      style: TextStyle(
                        color: Color(0xFF0066FF),
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 45),
                    descriptionField,
                    const SizedBox(height: 20),
                    dateField,
                    const SizedBox(height: 20),
                    worthField,
                    const SizedBox(height: 45),
                    signUpButton,
                    const Text(
                      "________________________________",
                      style: TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  createUser() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    BillModel billModel = BillModel();

    // writing all the values
    billModel.description = descriptionEditingController.text;
    DateTime date = DateTime.parse(dateEditingController.text);
    billModel.day = date.day;
    billModel.month = date.month;
    billModel.year = date.year;
    billModel.worth = int.parse(worthEditingController.text);

    await firebaseFirestore.collection("bills").doc().set(billModel.toMap());
    Fluttertoast.showToast(msg: "Gasto registrado con éxito :)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
