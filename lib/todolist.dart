import 'dart:core';
import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  const Todolist({ Key? key}) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {

  TextEditingController Newlist = TextEditingController();
  List<String> MyList = ['Flutter Coding'];
  List<bool> ListCheck = [false];
  @override
  void initState(){
    super.initState();
  }

  Future<void> AddList() async{
    return showDialog<void>(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Are you add task to list?'),
          content: TextField(
            controller: Newlist,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Please Fill Your Task'
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                setState(() {
                  MyList.add(Newlist.text);
                  ListCheck.add(false);
                  Newlist.clear();
                  Navigator.of(context).pop();
                });
              },
              child: Text("ok")),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Cancel')
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo list',
        )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Width*0.03,
          vertical: Height*0.02
        ),
        child: (MyList.length == 0) ? 
            Center(
              child: Column(
                children: [
                  Text('No data in your list',style: TextStyle(fontSize: 24),),
                  Text('Please add your task',style: TextStyle(fontSize: 28),)
                ],
              )
            ) : 
            ListView.builder(
              itemCount: MyList.length,
              itemBuilder: (BuildContext context,int index){
                return Card(
                  child: CheckboxListTile(
                    activeColor: Colors.orangeAccent,
                    checkColor: Colors.white,
                    title: Text(MyList[index]),
                    secondary: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: (){
                        setState(() {
                          MyList.remove(MyList[index]);
                          ListCheck.remove(ListCheck[index]);
                        });
                      },
                    ),
                    value: ListCheck[index],
                    onChanged: (value){
                      setState(() {
                        print(value);
                        ListCheck[index] = value!;
                      });
                    },
                  )
                );
              }
            )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: AddList,
      ),
    );
  }
}