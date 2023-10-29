import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppThemes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.blueGrey,
    appBarTheme:  AppBarTheme(centerTitle: false, elevation: 0,
    backgroundColor: Colors.blueGrey
    ),
    primaryIconTheme: IconThemeData(
        color: Colors.white
    ),
    iconTheme: IconThemeData(
        color: Colors.black

    ),
    //////////////////////
    cardTheme: CardTheme(
        //color: Colors.white
        color: Colors.blueGrey.shade100,

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey))
    ),
   floatingActionButtonTheme: FloatingActionButtonThemeData(
     backgroundColor: Colors.blueGrey,


   ),
    listTileTheme: ListTileThemeData(
      //tileColor: Colors.black,
        textColor: Colors.black
    ),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,


        )
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(
          color: Colors.black
      )
      ,bodyText1: TextStyle(
      color: Colors.black,
    ),

        bodyText2: TextStyle(
    color: Colors.black,
    ),
      subtitle2:  TextStyle(
          color: Colors.black
      ),
      caption: TextStyle(
          color: Colors.black
      ),


    ),

    ////////////////////////

    backgroundColor: Colors.blueGrey,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.blueGrey,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.blueGrey,size: 40),
      showUnselectedLabels: true,
      unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
    ),



      );

   final darkTheme =
   ThemeData.dark().copyWith(
     scaffoldBackgroundColor: Colors.black,
     //scaffoldBackgroundColor: Colors.grey.shade900,

     primaryColor: Colors.black,
       primaryIconTheme: IconThemeData(
           color: Colors.white
       ),elevatedButtonTheme: ElevatedButtonThemeData(
     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))
   ),
       //////////////////////
       cardTheme: CardTheme(
         color: Colors.grey.shade900,

       ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.white
  ),
       inputDecorationTheme: InputDecorationTheme(
         labelStyle: TextStyle(
           color: Colors.black,
           fontSize: 15,

         )
       ),
     textTheme: TextTheme(
         subtitle1: TextStyle(
             color: Colors.black
         ),

       bodyText1: TextStyle(
       color: Colors.black,
     ),

       bodyText2: TextStyle(
         color: Colors.black,
       ),
       subtitle2:  TextStyle(
           color: Colors.black
       ),
       caption: TextStyle(
           color: Colors.black
       ),







     ),
       ////////////////////////
       iconTheme: IconThemeData(
           color: Colors.white
       ),

     appBarTheme:  AppBarTheme(

       centerTitle: false,
         elevation: 0,
         backgroundColor: Colors.black,
     ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(color: Colors.blueGrey,size: 40),
      showUnselectedLabels: true,
      unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
    ),
     floatingActionButtonTheme: FloatingActionButtonThemeData(
       backgroundColor: Colors.black,


     ),



   );


}
