import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_storage/Database/dbhelper.dart';
import 'package:local_storage/Screens/editscreen.dart';
import 'package:local_storage/Screens/newcontactscreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController=TextEditingController();
  bool isFetching=true;
  List<Map<String,dynamic>> phoneList=[];
  Future<void> _fetchAllRecords()async{
  phoneList = await DBHelper.instance.selectRaw();
  isFetching=false;
  setState(() {
    
  });
  }

  void initState(){
    _fetchAllRecords();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(onPressed: ()async{
     await Navigator.push(context, MaterialPageRoute(builder: (context){
        return NewContactScreen();
      }));
    //  _fetchAllRecords();

     },child: Text('+',style: TextStyle(fontSize: 20),),),
      appBar: AppBar(
        title: const Text('Contact Book'),
        backgroundColor: Colors.blueGrey ,
        
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
           TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
           ),
           isFetching?Center(child: CircularProgressIndicator(),):
           phoneList.isEmpty?Center(child: Text('No record available'),):
           Expanded(child: Container(
            child: ListView.builder(
              itemCount: phoneList.length,
              itemBuilder: (context,index){
                Map<String,dynamic> singleRecord=phoneList[index];
                return Card(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey,
                        backgroundImage: singleRecord["imageString"]==null?null:
                                        MemoryImage(base64Decode(singleRecord["imageString"])),
                                
                      ),
                      SizedBox(width: 15,),
                      Column(
                        spacing: 4,
                        children: [
                          Text(singleRecord["name"],style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(singleRecord["number"],style: TextStyle(fontWeight: FontWeight.bold)),
                          singleRecord["email"]!=null?Text(singleRecord["email"],style: TextStyle(fontWeight: FontWeight.bold)):Text('')
                        ],
                      ),
SizedBox(width: 100,),
                      Expanded(
                        child: IconButton(onPressed: () async{
                        int row= await DBHelper.instance.delete(singleRecord['ID']);
                        if(row>0){
                          await ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Data Deleted Successfully'))
                                        );
                                        setState(() {
                                          
                                        });
                        }
                        }, icon: Icon(Icons.delete,color: Colors.red,)),
                      ),
                      IconButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>UpdateScreen(singleRecord: singleRecord)));
                      }, icon: Icon(Icons.edit,color: Colors.black,)),

                    ],
                  ),
                );


              }),

           )
           )
          ],

        ),
      
      )
    );
  }
}