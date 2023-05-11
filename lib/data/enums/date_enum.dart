enum CustomDateFormat {
  dotDdMmYyyy(dateFormat: "dd.MM.yyyy"),
  slashMmDdYyyy(dateFormat: "MM/dd/yyyy"),
  slashDdMmYyyy(dateFormat: "dd/MM/yyyy"),
  dashYyyyMmDd(dateFormat: "yyyy-M-d"),
  slashYyyyMmDd(dateFormat: "yyyy/MM/dd"),
  dotYyyMmDd(dateFormat: "yyy.MM.dd"),
  dashYyyMmDd(dateFormat: "yyyy-MM-dd");

  const CustomDateFormat({
    required this.dateFormat,
  });

  final String dateFormat;
}
