import 'package:flutter/material.dart';

class EditData extends StatelessWidget{
late final String _day;
late final String _code;
late final String _name;
late final String _venue;
late final String _time;
late final int  _hour;


  @override
  Widget build(BuildContext context){
    return SafeArea(
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: [
                  Form(

                      child: TextFormField(
                        decoration:InputDecoration(
                          labelText:"Day on which Course is to be added",
                          hintText: "eg. Monday",

                        ),
                        onChanged:(value){
                          _day=value;
                        },
                      ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Course Code",
                        hintText: "eg. ESC201A",

                      ),
                      onChanged:(value){
                        _code=value;
                      },
                    ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Name of Course",
                        hintText: "eg.INTRODUCTION TO ELECTRONICS",

                      ),
                      onChanged:(value){
                        _name=value;
                      },
                    ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Venue",
                        hintText: "eg. L-20",

                      ),
                      onChanged:(value){
                        _venue=value;
                      },
                    ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Time",
                        hintText: "eg. 8:00 AM - 9:00 AM",

                      ),
                      onChanged:(value){
                        _time=value;
                      },
                    ),
                  ),
                  Form(

                    child: TextFormField(
                      decoration:InputDecoration(
                        labelText:"Hour (In 24 hour format",
                        hintText: "eg. for 1:00 PM it should be 13",

                      ),
                      onChanged:(value){
                        _hour=int.parse(value);
                      },
                    ),
                  ),
                  ElevatedButton(

                      onPressed: (){},

                      child: Text("Save")
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}