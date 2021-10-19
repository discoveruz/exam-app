num direction(String v) {
  List? number;
  try {
    number = v.split(',');
  } catch (x) {}
  if (number!.isEmpty || number.length == 1) {
    return _factorial(int.parse(v));
  } else {
    return _medium(number.map((e) => int.parse(e)).toList());
  }
}

//Factorial algorithm
int _factorial(int son) {
  if (son == 0) {
    return 1;
  } else if (son == 1) {
    return 1;
  } else {
    return _factorial(son - 1) * son;
  }
}

//medium algorithm
double _medium(List<int> sonlar) {
  int son = 0;
  sonlar.forEach((element) {
    son += element;
  });
  return son / (sonlar.length);
}
