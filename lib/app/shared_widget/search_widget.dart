import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchWidget extends StatefulWidget {
  final String searchInReadyOrders;
  final Function? onChange;
  SearchWidget({this.searchInReadyOrders='',this.onChange});
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> with SingleTickerProviderStateMixin{
  late  AnimationController _con;
  @override
  void initState() {
    _con = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: 375
        )
    );

  }
  int toggle=0;
  TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return   Container(
          height: 80,
          width: 250,
          alignment: Alignment(-1.0,0.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 375),
            height: 48,
            width: (toggle ==0)?48.0:258.0,
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade300,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.shade200,
                  spreadRadius: 0.2,
                  blurRadius: 20.0,
                  offset: Offset(10.0,-10.0)
                ),


                BoxShadow(
                    color: Colors.blueGrey.shade200,
                    spreadRadius: 0.2,
                    blurRadius: 20.0,
                    offset: Offset(-10.0,10.0)
                ),

              ]
            ),
            child: Stack(
              children: [

                 AnimatedPositioned(
                   duration: Duration(milliseconds: 375) ,
                   top: 60.0,
                   right: 7.0,
                   curve: Curves.easeOut,
                   child: AnimatedOpacity(
                       opacity: (toggle==0)?0.0:1.0,
                     duration: Duration(milliseconds: 200),

                       child: Container(
                        padding: EdgeInsets.all(8.0),
                         decoration: BoxDecoration(
                           color: Color(0xfff2f3f7),
                           borderRadius: BorderRadius.circular(30.0),
                         ),
                         child: AnimatedBuilder(
                           child: Icon(
                             Icons.mic,
                             size: 10,
                             color: Colors.black,
                           ),
                           builder: (context,widget){
                             return Transform.rotate(
                               angle: _con.value * 2.0 * pi,
                               child: widget,
                             );
                           },
                           animation: _con,
                         ),
                       ),
                   ),
                 ),

                AnimatedPositioned(
                    duration: Duration(milliseconds: 375),
                  right: (toggle==0)?20.0:20.0,
                  top: 13.0,
                  curve: Curves.easeOut,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: (toggle==0)?0.0:1.0,
                    child: Container(
                      height: 23.0,
                      width: 180.0,
                      child: TextField(

                          controller: searchCon,
                        cursorRadius: Radius.circular(10.0),
                        cursorWidth: 2.0,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Search",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,

                          )
                        ),
                        onChanged: widget.onChange as void Function(String?)?
                      ),
                    ),
                  ),
                ),


                Positioned(
                  left: 1.0,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                          if(toggle==0){
                            toggle=1;

                            _con.forward();
                          }else{
                            toggle=0;
                            searchCon.clear();
                            _con.reverse();
                            widget.onChange!('');

                          }
                        });
                      },
                      icon: Icon(Icons.search,size: 25,color: Colors.blueGrey.shade500,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
