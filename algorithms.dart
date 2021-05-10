import 'dart:math';

/*
 * 用于测试的DFA矩阵
void main() {
  int NFA_SIZE = 3;
  List input_matrix = [];
  input_matrix.length;
  //List row0 = ['a', 0, 1, 2];
  List row1 = [0, 1, 0];
  List row2 = [0, 1, 1];
  List row3 = [0, 0, 0];
  //input_matrix.add(row0);
  input_matrix.add(row1);
  input_matrix.add(row2);
  input_matrix.add(row3);
  //print(input_matrix);

  convert(NFA_SIZE, input_matrix);
}
*/

/*
 * arguments: NFA_SIZE: NFA状态个数
 *          input_matrix: 输入矩阵，二维List
 * return： output_matrix: 输出矩阵，二维List
 */

List<List<int>> convert(int NFA_SIZE, List input_matrix) {
  //* 创建输出矩阵
  int DFA_SIZE = pow(2, NFA_SIZE).ceil();
  List<List<int>> output_matrix =
      List.generate(DFA_SIZE, (_) => List.generate(DFA_SIZE, (_) => 0));

  //* 通过输入矩阵初始化已经存在的状态
  for (int i = 0; i < NFA_SIZE; i++) {
    for (int j = 0; j < NFA_SIZE; j++) {
      int opi = pow(2, i).ceil();
      int opj = pow(2, j).ceil();
      output_matrix[opi][opj] = input_matrix[i][j];
    }
  }

  //print('--------------');
  //print(output_matrix.join('\n'));

  //* 进行列拓展
  for (int i = 0; i < NFA_SIZE; i++) {
    for (int j = 0; j < DFA_SIZE; j++) {
      int j_bin = j;
      int res = 1;
      for (int k = 0; k < NFA_SIZE; k++) {
        int m = j_bin % 2;
        j_bin = j_bin ~/ 2;
        int opi = pow(2, i).ceil();
        int opj = pow(2, k).ceil();
        int val = output_matrix[opi][opj];
        if (m == 1) {
          res = res & val;
        }
      }
      int opi = pow(2, i).ceil();
      output_matrix[opi][j] = res;
    }
  }

  //print('--------------');
  //print(output_matrix.join('\n'));

  //* 进行行拓展
  for (int i = 0; i < DFA_SIZE; i++) {
    for (int j = 0; j < DFA_SIZE; j++) {
      int i_bin = i;
      int res = 0;
      for (int k = 0; k < NFA_SIZE && i_bin > 0; k++) {
        int m = i_bin % 2;
        i_bin = i_bin ~/ 2;
        int opi = pow(2, k).ceil();
        if (m == 1) {
          //int val = output_matrix[(int)pow(2, k)][j];
          res = res | output_matrix[opi][j];
        }
      }
      output_matrix[i][j] = res;
      //printf("%d %d %d\n", i, j, res);
    }
  }

  //print('--------------');
  //print(output_matrix.join('\n'));

  //* 清楚多余状态
  for (int i = 0; i < DFA_SIZE; i++) {
    for (int j = DFA_SIZE - 1; j >= 0; j--) {
      if (output_matrix[i][j] == 1) {
        for (int k = j - 1; k > 0; k--) {
          output_matrix[i][k] = 0;
        }
        break;
      }
    }
  }

  //print('--------------');
  //print(output_matrix.join('\n'));
  List<List<int>> output_matrixNew = [];
  for (int i = 1; i < DFA_SIZE; i++) {
    List<int> tmp = [];
    for (int j = 1; j < DFA_SIZE; j++) {
      tmp.add(output_matrix[i][j]);
    }
    output_matrixNew.add(tmp);
  }

  //print(output_matrixNew.join('\n'));
  return output_matrixNew;
}
