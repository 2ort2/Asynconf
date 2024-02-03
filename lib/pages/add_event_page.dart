
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formkey = GlobalKey<FormState>();

  final confNameController = TextEditingController();
  final speakerNameController = TextEditingController();
  String selectedConfType = 'talk';
  DateTime selectedConfDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();

    confNameController.dispose();
    speakerNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(29),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            Container (
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                decoration: InputDecoration(
                 labelText: 'Nom Conference',
                  hintText: 'Entre le nom de la conférence',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "tu dois complèter ce champs";
                  }
                  return null;
                },
                controller: confNameController,
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom du speaker',
                  hintText: 'Entre le nom du speaker',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "tu dois complèter ce champs";
                  }
                  return null;
                },
                controller: speakerNameController,
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: DropdownButtonFormField(
                items: const[
                  DropdownMenuItem(value: 'talk', child: Text("talk show")),
                  DropdownMenuItem(value: 'demo', child: Text("Demo code")),
                  DropdownMenuItem(value: 'partner', child: Text("Partner")),
                ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                  value: selectedConfType,
                  onChanged:(value){
                  setState(() {
                    selectedConfType = value!;
                  });

                  }
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom:10),
              child: DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Choisir une date',
                ),
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  setState(() {
                    selectedConfDate = value;
                  });
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
                height: 58,
              child: ElevatedButton(
                  onPressed: () {
                    if(_formkey.currentState!.validate()){
                      final confName = confNameController.text;
                      final speakerName = speakerNameController.text;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Envoi en cours..."))
                      );
                      FocusScope.of(context).requestFocus(FocusNode());

                    //  print("Ajout de la conf $confName par le speaker $speakerName");
                      //print("Type de conference $selectedConfType");
                      //print("Date de la conf $selectedConfDate");
                      // un ajout plutot dans la base de donnees
                  CollectionReference eventsRef = FirebaseFirestore.instance.collection("Events");
                  eventsRef.add({
                    'speaker': speakerName,
                    'date': selectedConfDate,
                    'subject': confName,
                    'type': selectedConfType,
                    'avatar':'lior',
                  });
                    }
                  },
                  child: Text("Envoyer")
              ),
            ),
          ],
        ),
      ),
    );
  }
}

