enum DateFormatEnum {
  formatOne,
  formatTwo,
  formatThree,
  formatFour,
  formatFive,
  formatSix,
  formatSeven,
}

Map<DateFormatEnum, String> dateFormatMap = {
  DateFormatEnum.formatOne: "dd.MM.yyyy",
  DateFormatEnum.formatTwo: "MM/dd/yyyy",
  DateFormatEnum.formatThree: "dd/MM/yyyy",
  DateFormatEnum.formatFour: "yyyy-M-d",
  DateFormatEnum.formatFive: "yyyy/MM/dd",
  DateFormatEnum.formatSix: "yyy.MM.dd",
  DateFormatEnum.formatSeven: "yyyy-MM-dd"
};
