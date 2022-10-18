// ignore_for_file: unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../homeScreen.dart';
import '../models/userModel.dart';
import 'package:intl/intl.dart';
import 'models/paymentModel.dart';

class CreatePayment extends StatefulWidget {
  final String identification;

  const CreatePayment(this.identification, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreatePaymentState createState() => _CreatePaymentState();
}

class _CreatePaymentState extends State<CreatePayment> {
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final paymentEditingController = TextEditingController();

  UserModel userModel = UserModel();

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.identification)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data());
      nameEditingController.text =
          'Usuario: ${userModel.name} ${userModel.lastName}';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //name field
    final nameField = TextFormField(
      autofocus: false,
      readOnly: true,
      controller: nameEditingController,
      keyboardType: TextInputType.text,
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
            Icons.person,
            color: Colors.grey,
          ),
        ),
        labelText: 'Usuario',
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
          return ("La fecha de pago no puede estar vacía");
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
        labelText: 'Fecha de pago',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //payment field
    final paymentField = TextFormField(
      autofocus: false,
      controller: paymentEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("El valor de pago no puede estar vacío");
        }
        return null;
      },
      onSaved: (value) {
        paymentEditingController.text = value!;
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
        labelText: 'Valor de pago',
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
        child: const Text("Registrar pago"),
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
                      "Pagos",
                      style: TextStyle(
                        color: Color(0xFF0066FF),
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 45),
                    nameField,
                    const SizedBox(height: 20),
                    dateField,
                    const SizedBox(height: 20),
                    paymentField,
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

    PaymentModel paymentModel = PaymentModel();

    // writing all the values
    paymentModel.identification = widget.identification;
    DateTime date = DateTime.parse(dateEditingController.text);
    paymentModel.day = date.day;
    paymentModel.month = date.month;
    paymentModel.year = date.year;
    paymentModel.payment = int.parse(paymentEditingController.text);

    await firebaseFirestore
        .collection("payments")
        .doc()
        .set(paymentModel.toMap());
    Fluttertoast.showToast(msg: "Pago registrado con éxito :)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
