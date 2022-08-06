import 'package:flutter/material.dart';

import 'tempFile.dart';

class TempValue{
  String long = 'Choose';
  String short = 'Choose';
  DateTime? date = DateTime.now();

  String getTotalInf(){
    return "Длина циклов "+long+" дней\nДлина месячных "+short+" дней\nНачало последней менструации "+date.toString();
  }
  
}

TempValue tempLoc = new TempValue();