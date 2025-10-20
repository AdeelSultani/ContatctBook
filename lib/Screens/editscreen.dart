import 'package:flutter/material.dart';
import 'package:local_storage/Database/dbhelper.dart';

class UpdateScreen extends StatefulWidget {
  Map<String ,dynamic> singleRecord={};
  UpdateScreen({required this.singleRecord});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> singleRecord={};
    singleRecord=widget.singleRecord;
    nameController.text=singleRecord['name'];
    phoneController.text=singleRecord['number'];
    emailController.text=singleRecord['email'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Screen'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(padding: EdgeInsets.all(10),
      child: Column(
children: [
  
  TextFormField(controller: nameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Name',
              labelText: 'Name'
            ),
            ),SizedBox(height: 20,),
             TextFormField(controller: phoneController,
            
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Phone',
              labelText: 'Phone'
            ),
            ),SizedBox(height: 20,),
            TextFormField(controller: emailController,
            
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Email',
              labelText: 'Email'
            ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
       String name=nameController.text;
       String number=phoneController.text;
       String email=emailController.text;
       int id=singleRecord['ID'];
       int roweffect= await  DBHelper.instance.rowupdate(id, name, number, email);
       if(roweffect>0){
        await ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data Updated Successfully'))
                );
                Navigator.pop(context);
               }
       
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey
            ), 
            child: Text('Update',style: TextStyle(color: Colors.white),))
],
      ),
      ),

    );
  }
}