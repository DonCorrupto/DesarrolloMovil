void main(List<String> args) {
  var list = [
    [11, 22, 54],
    [25, 29, 35]
  ];

  for (var i = 0; i <= list.length; i++) {
    for (var x = 0; x <= list.length; x++) {
      print(list[i][x]);
    }
    //print(list[i]);
  }
}
