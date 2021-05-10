import 'dart:core';
import 'dart:math';

//void main() {
//  Set input = {0, 1, 2, 3, 4, 5};
//  Set input_final = {2, 3};
//  print(fin_Count(input, input_final));
//}

List<List> fin_Count(Set input, Set input_final) {
  Set input_nonfinal = input.difference(input_final);
  //print(input_nonfinal);

  int NFIN_SIZE = pow(2, input_nonfinal.length).toInt();
  int FIN_SIZE = pow(2, input_final.length).toInt();
  //print(NFIN_SIZE);
  //print(FIN_SIZE);

  Set output = {};
  Set output_nonfinal = {};
  Set output_final = {};

  for (int i = 0; i < NFIN_SIZE; i++) {
    Set nf_tmp = {};
    int i_bin = i;
    for (int j = 0; j < input_nonfinal.length && i_bin > 0; j++) {
      int m = i_bin % 2;
      i_bin = i_bin ~/ 2;
      if (m == 1) {
        nf_tmp.add(input_nonfinal.elementAt(j));
      }
    }
    output_nonfinal.add(nf_tmp);
  }

  //print(output_nonfinal);

  for (int i = 0; i < FIN_SIZE; i++) {
    Set f_tmp = {};
    int i_bin = i;
    for (int j = 0; j < input_final.length && i_bin > 0; j++) {
      int m = i_bin % 2;
      i_bin = i_bin ~/ 2;
      if (m == 1) {
        f_tmp.add(input_final.elementAt(j));
      }
    }
    output_final.add(f_tmp);
  }

  //print(output_final);

  for (int i = 0; i < NFIN_SIZE; i++) {
    for (int j = 1; j < FIN_SIZE; j++) {
      Iterable tmpi_output = {};
      tmpi_output =
          output_final.elementAt(j).followedBy(output_nonfinal.elementAt(i));
      //print(output_nonfinal.elementAt(i));
      //print(output_final.elementAt(j));
      List tmpl_output = List.from(tmpi_output);
      output.add(tmpl_output);
      //print(tmp_output);
    }
  }

  //print(output);
  List<List> opt = List.from(output);

  //print(op);

  return opt;
}
