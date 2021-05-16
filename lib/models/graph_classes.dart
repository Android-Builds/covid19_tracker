class GlobalData {
  final String parameters;
  final double percentage;

  GlobalData(this.parameters, this.percentage);
}

class CaseData {
  CaseData(this.date, this.cases);
  final DateTime date;
  final int cases;
}

class ReducedCasesData {
  final DateTime date;
  final double cases;

  ReducedCasesData(this.date, this.cases);
}
