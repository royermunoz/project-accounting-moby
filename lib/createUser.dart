// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../homeScreen.dart';
import '../models/userModel.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final identificationEditingController = TextEditingController();
  final nameEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final ipEditingController = TextEditingController();
  final planEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //first name field
    final identificationField = TextFormField(
      autofocus: false,
      controller: identificationEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return ("La identificación no puede estar vacía");
        }
        return null;
      },
      onSaved: (value) {
        identificationEditingController.text = value!;
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
            Icons.person,
            color: Colors.grey,
          ),
        ),
        labelText: 'Identificación',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //first name field
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("El nombre no puede estar vacío");
        }
        return null;
      },
      onSaved: (value) {
        nameEditingController.text = value!;
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
            Icons.person,
            color: Colors.grey,
          ),
        ),
        labelText: 'Nombre',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //last name field
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("El apellido no puede estar vacío");
        }
        return null;
      },
      onSaved: (value) {
        lastNameEditingController.text = value!;
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
            Icons.person,
            color: Colors.grey,
          ),
        ),
        labelText: 'Apellido',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //ip field
    final ipField = TextFormField(
      autofocus: false,
      controller: ipEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("La ip no puede estar vacía");
        }
        return null;
      },
      onSaved: (value) {
        ipEditingController.text = value!;
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
            Icons.location_on_outlined,
            color: Colors.grey,
          ),
        ),
        labelText: 'Ip',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //plan field
    final planField = TextFormField(
      autofocus: false,
      controller: planEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("El plan no puede estar vacío");
        }
        return null;
      },
      onSaved: (value) {
        planEditingController.text = value!;
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
            Icons.price_change_outlined,
            color: Colors.grey,
          ),
        ),
        labelText: 'Plan',
        contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 16),
      ),
    );

    //phone number field
    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneNumberEditingController,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        phoneNumberEditingController.text = value!;
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
            Icons.phone,
            color: Colors.grey,
          ),
        ),
        labelText: 'Número de telefono',
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
        child: const Text("Registrar usuario"),
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
                      "Crear Usuario",
                      style: TextStyle(
                        color: Color(0xFF0066FF),
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(height: 45),
                    identificationField,
                    const SizedBox(height: 20),
                    nameField,
                    const SizedBox(height: 20),
                    lastNameField,
                    const SizedBox(height: 20),
                    ipField,
                    const SizedBox(height: 20),
                    planField,
                    const SizedBox(height: 20),
                    phoneNumberField,
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

    UserModel userModel = UserModel();

    // writing all the values
    userModel.identification = identificationEditingController.text;
    userModel.name = nameEditingController.text;
    userModel.lastName = lastNameEditingController.text;
    userModel.ip = ipEditingController.text;
    userModel.plan = planEditingController.text;
    userModel.phoneNumber = phoneNumberEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(identificationEditingController.text)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Usuario registrado con éxito :)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
