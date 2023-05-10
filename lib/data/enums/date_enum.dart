enum CustomDateFormat {
  dotDMY(dateFormat: "dd.MM.yyyy"),
  slashMDY(dateFormat: "MM/dd/yyyy"),
  slashDMY(dateFormat: "dd/MM/yyyy"),
  dashYMD(dateFormat: "yyyy-M-d"),
  slashYMD(dateFormat: "yyyy/MM/dd"),
  dotYMD(dateFormat: "yyy.MM.dd"),
  dashYYMD(dateFormat: "yyyy-MM-dd");

  const CustomDateFormat({
    required this.dateFormat,
  });

  final String dateFormat;
}
