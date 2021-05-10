/*
######Automata_Convertor######
v1.0
*/
import 'dart:io';

import 'algorithms.dart';
import 'final.dart';

void main() async {
  stdout.write('Converting.\n');
  File iptfile = new File('nfa.csv');
  List<String> iptcontent = await iptfile.readAsLinesSync();
  if (iptcontent.length < 4) {
    stderr.write('Fatal Error.');
    return;
  }
  var objAutomata = FiniteAutomata(iptcontent);
  objAutomata.FAconvert();
  File optfile = new File('dfa.csv');
  await optfile.writeAsString(objAutomata.optAutomata().join('\n'));
}

class FiniteAutomata {
  List<String> Q = []; //Collection of states.
  List<String> T = []; //Collection of inputs.
  List<List<List<int>>> transfunc = []; //Transform functions.
  String q0 = 'q0'; //Initial state.
  List<String> F = []; //Collection of ending states.

  FiniteAutomata(List<String> content) {
    Q = content[0].split(','); //read Q.
    T = content[1].split(','); //read T.
    //generate the matrixes of transform functions.
    T.forEach((_) => transfunc.add(
        List.generate(Q.length, (_) => List.generate(Q.length, (_) => 0))));
    List<String> linetemp = content[2].split(','); //a temporary list。
    q0 = linetemp[0]; //read q0.
    F = linetemp.sublist(1); //read F.
    var j = 0; //column pointer.
    content.sublist(3).forEach((column) {
      for (int i = 0; i < Q.length; i++) {
        transfunc[j ~/ Q.length][j % Q.length][i] =
            int.parse(column.split(',')[i]);
      } //read transform functions.
      j++;
    });
    print("NFA constructed.\n");
  }

  FAconvert() {
    //Adapt converting algorithm.
    print('Converting NFA to DFA.\n');
    for (int i = 0; i < transfunc.length; i++) {
      transfunc[i] = convert(Q.length, transfunc[i]);
    }
    //convert F to match the DFA
    List Qadapted = List.generate(Q.length, (index) => index);
    List Fadapted = List.generate(F.length, (index) => Q.indexOf(F[index]));
    List<List> tobecomeF = fin_Count(Qadapted.toSet(), Fadapted.toSet());
    F.clear();
    for (var subsetlist in tobecomeF) {
      subsetlist.sort();
      String tempsubset = '';
      subsetlist.forEach((statepointer) {
        tempsubset += Q[statepointer];
      });
      F.add(tempsubset);
    }
    //convert Q to match the DFA
    List<List> tobecomeQ = fin_Count({}, Qadapted.toSet());
    print(tobecomeQ);
    List<String> newQ = [];
    for (var subsetlist in tobecomeQ) {
      subsetlist.sort();
      String tempsubset = '';
      subsetlist.forEach((statepointer) {
        tempsubset += Q[statepointer];
      });
      newQ.add(tempsubset);
    }
    Q = newQ;
  }

  List<String> optAutomata() {
    //store the parametre of the FA in a list of strings.
    print('Outputing converted DFA.\n');
    List<String> optlist = [];
    optlist.add(Q.join(','));
    optlist.add(T.join(','));
    optlist.add(q0 + ',' + F.join(','));
    transfunc.forEach((matrix) {
      matrix.forEach((column) {
        optlist.add(column.join(','));
      });
    });
    return optlist;
  }
}
