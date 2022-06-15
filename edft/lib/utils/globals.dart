import 'package:edft/utils/models.dart';
import 'package:flutter/material.dart';
import '../localization/localization_service.dart';

//Forms
const int minInputLength = 3;
const int maxInputLength = 128;
const int minPasswordLength = 6;

//Navigation
const int homePageIndex = 0;
const int profilePageIndex = 1;
const int aboutPageIndex = 2;

//Firebase
const String avatarFolder = "avatars";

//Dropdowns
final List<DropdownMenuItem<String>> genderList = [
  DropdownMenuItem(
    value: "M",
    child: Text(LocalizationService.instance.getLocalizedString("male")),
  ),
  DropdownMenuItem(
    value: "F",
    child: Text(LocalizationService.instance.getLocalizedString("female")),
  ),
  DropdownMenuItem(
    value: "O",
    child: Text(LocalizationService.instance.getLocalizedString("other")),
  )
];

final List<DropdownMenuItem<String>> relationshipStatusList = [
  DropdownMenuItem(
    value: "S",
    child: Text(LocalizationService.instance.getLocalizedString("single")),
  ),
  DropdownMenuItem(
    value: "R",
    child: Text(
        LocalizationService.instance.getLocalizedString("in_a_relationship")),
  ),
  DropdownMenuItem(
    value: "O",
    child: Text(LocalizationService.instance.getLocalizedString("other")),
  )
];

final List<DropdownMenuItem<String>> accomodationPreferenceList = [
  const DropdownMenuItem(
    value: "hotel",
    child: Text("Hotel"),
  ),
  DropdownMenuItem(
    value: "hostel",
    child: Text(LocalizationService.instance.getLocalizedString("hostel")),
  ),
];

final List<DropdownMenuItem<String>> transportPreferenceList = [
  DropdownMenuItem(
    value: "car",
    child: Text(LocalizationService.instance.getLocalizedString("car")),
  ),
  DropdownMenuItem(
    value: "bus",
    child: Text(LocalizationService.instance.getLocalizedString("bus")),
  ),
  DropdownMenuItem(
    value: "train",
    child: Text(LocalizationService.instance.getLocalizedString("train")),
  ),
];

final List<DropdownMenuItem<String>> budgetPreferenceList = [
  DropdownMenuItem(
    value: "economic",
    child: Text(LocalizationService.instance.getLocalizedString("economic")),
  ),
  DropdownMenuItem(
    value: "executive",
    child: Text(LocalizationService.instance.getLocalizedString("executive")),
  ),
];

final List<Attraction> attractionPreferencesList = [
  Attraction(
    code: "bar",
    name: LocalizationService.instance.getLocalizedString("bar"),
    image: "assets/images/attraction-bar.jpg",
  ),
  Attraction(
    code: "restaurant",
    name: LocalizationService.instance.getLocalizedString("restaurant"),
    image: "assets/images/attraction-restaurant.jpg",
  ),
  Attraction(
    code: "museum",
    name: LocalizationService.instance.getLocalizedString("museum"),
    image: "assets/images/attraction-museum.jpg",
  ),
  Attraction(
    code: "nature",
    name: LocalizationService.instance.getLocalizedString("nature"),
    image: "assets/images/attraction-nature.jpg",
  ),
];

List<Country> countriesBr = [
  Country(code: "BR", name: "Brasil"),
  Country(code: "AF", name: "Afeganistão"),
  Country(code: "ZA", name: "África do Sul"),
  Country(code: "AL", name: "Albânia"),
  Country(code: "DE", name: "Alemanha"),
  Country(code: "AD", name: "Andorra"),
  Country(code: "AO", name: "Angola"),
  Country(code: "AI", name: "Anguila"),
  Country(code: "AQ", name: "Antártida"),
  Country(code: "AG", name: "Antígua e Barbuda"),
  Country(code: "SA", name: "Arábia Saudita"),
  Country(code: "DZ", name: "Argélia"),
  Country(code: "AR", name: "Argentina"),
  Country(code: "AM", name: "Armênia"),
  Country(code: "AW", name: "Aruba"),
  Country(code: "AU", name: "Austrália"),
  Country(code: "AT", name: "Áustria"),
  Country(code: "AZ", name: "Azerbaijão"),
  Country(code: "BS", name: "Bahamas"),
  Country(code: "BH", name: "Bahrein"),
  Country(code: "BD", name: "Bangladesh"),
  Country(code: "BB", name: "Barbados"),
  Country(code: "BE", name: "Bélgica"),
  Country(code: "BZ", name: "Belize"),
  Country(code: "BJ", name: "Benin"),
  Country(code: "BM", name: "Bermudas"),
  Country(code: "BY", name: "Bielorrússia"),
  Country(code: "BO", name: "Bolívia"),
  Country(code: "BA", name: "Bósnia e Herzegovina"),
  Country(code: "BW", name: "Botsuana"),
  Country(code: "BN", name: "Brunei"),
  Country(code: "BG", name: "Bulgária"),
  Country(code: "BF", name: "Burquina Faso"),
  Country(code: "BI", name: "Burundi"),
  Country(code: "BT", name: "Butão"),
  Country(code: "CV", name: "Cabo Verde"),
  Country(code: "CM", name: "Camarões"),
  Country(code: "KH", name: "Camboja"),
  Country(code: "CA", name: "Canadá"),
  Country(code: "QA", name: "Catar"),
  Country(code: "KZ", name: "Cazaquistão"),
  Country(code: "TD", name: "Chade"),
  Country(code: "CL", name: "Chile"),
  Country(code: "CN", name: "China"),
  Country(code: "CY", name: "Chipre"),
  Country(code: "VA", name: "Cidade do Vaticano"),
  Country(code: "CO", name: "Colômbia"),
  Country(code: "KM", name: "Comores"),
  Country(code: "CD", name: "Congo - Kinshasa"),
  Country(code: "KP", name: "Coreia do Norte"),
  Country(code: "KR", name: "Coreia do Sul"),
  Country(code: "CI", name: "Costa do Marfim"),
  Country(code: "CR", name: "Costa Rica"),
  Country(code: "HR", name: "Croácia"),
  Country(code: "CU", name: "Cuba"),
  Country(code: "CW", name: "Curaçao"),
  Country(code: "DK", name: "Dinamarca"),
  Country(code: "DJ", name: "Djibuti"),
  Country(code: "DM", name: "Dominica"),
  Country(code: "EG", name: "Egito"),
  Country(code: "SV", name: "El Salvador"),
  Country(code: "AE", name: "Emirados Árabes Unidos"),
  Country(code: "EC", name: "Equador"),
  Country(code: "ER", name: "Eritreia"),
  Country(code: "SK", name: "Eslováquia"),
  Country(code: "SI", name: "Eslovênia"),
  Country(code: "ES", name: "Espanha"),
  Country(code: "SZ", name: "Essuatíni"),
  Country(code: "US", name: "Estados Unidos"),
  Country(code: "EE", name: "Estônia"),
  Country(code: "ET", name: "Etiópia"),
  Country(code: "FJ", name: "Fiji"),
  Country(code: "PH", name: "Filipinas"),
  Country(code: "FI", name: "Finlândia"),
  Country(code: "FR", name: "França"),
  Country(code: "GA", name: "Gabão"),
  Country(code: "GM", name: "Gâmbia"),
  Country(code: "GH", name: "Gana"),
  Country(code: "GE", name: "Geórgia"),
  Country(code: "GI", name: "Gibraltar"),
  Country(code: "GD", name: "Granada"),
  Country(code: "GR", name: "Grécia"),
  Country(code: "GL", name: "Groenlândia"),
  Country(code: "GP", name: "Guadalupe"),
  Country(code: "GU", name: "Guam"),
  Country(code: "GT", name: "Guatemala"),
  Country(code: "GG", name: "Guernsey"),
  Country(code: "GY", name: "Guiana"),
  Country(code: "GF", name: "Guiana Francesa"),
  Country(code: "GN", name: "Guiné"),
  Country(code: "GQ", name: "Guiné Equatorial"),
  Country(code: "GW", name: "Guiné-Bissau"),
  Country(code: "HT", name: "Haiti"),
  Country(code: "HN", name: "Honduras"),
  Country(code: "HK", name: "Hong Kong, RAE da China"),
  Country(code: "HU", name: "Hungria"),
  Country(code: "YE", name: "Iêmen"),
  Country(code: "BV", name: "Ilha Bouvet"),
  Country(code: "CX", name: "Ilha Christmas"),
  Country(code: "IM", name: "Ilha de Man"),
  Country(code: "NF", name: "Ilha Norfolk"),
  Country(code: "AX", name: "Ilhas Aland"),
  Country(code: "KY", name: "Ilhas Cayman"),
  Country(code: "CC", name: "Ilhas Cocos (Keeling)"),
  Country(code: "CK", name: "Ilhas Cook"),
  Country(code: "FO", name: "Ilhas Faroe"),
  Country(code: "GS", name: "Ilhas Geórgia do Sul e Sandwich do Sul"),
  Country(code: "HM", name: "Ilhas Heard e McDonald"),
  Country(code: "FK", name: "Ilhas Malvinas"),
  Country(code: "MP", name: "Ilhas Marianas do Norte"),
  Country(code: "MH", name: "Ilhas Marshall"),
  Country(code: "UM", name: "Ilhas Menores Distantes dos EUA"),
  Country(code: "PN", name: "Ilhas Pitcairn"),
  Country(code: "SB", name: "Ilhas Salomão"),
  Country(code: "TC", name: "Ilhas Turcas e Caicos"),
  Country(code: "VI", name: "Ilhas Virgens Americanas"),
  Country(code: "VG", name: "Ilhas Virgens Britânicas"),
  Country(code: "IN", name: "Índia"),
  Country(code: "ID", name: "Indonésia"),
  Country(code: "IR", name: "Irã"),
  Country(code: "IQ", name: "Iraque"),
  Country(code: "IE", name: "Irlanda"),
  Country(code: "IS", name: "Islândia"),
  Country(code: "IL", name: "Israel"),
  Country(code: "IT", name: "Itália"),
  Country(code: "JM", name: "Jamaica"),
  Country(code: "JP", name: "Japão"),
  Country(code: "JE", name: "Jersey"),
  Country(code: "JO", name: "Jordânia"),
  Country(code: "KW", name: "Kuwait"),
  Country(code: "LA", name: "Laos"),
  Country(code: "LS", name: "Lesoto"),
  Country(code: "LV", name: "Letônia"),
  Country(code: "LB", name: "Líbano"),
  Country(code: "LR", name: "Libéria"),
  Country(code: "LY", name: "Líbia"),
  Country(code: "LI", name: "Liechtenstein"),
  Country(code: "LT", name: "Lituânia"),
  Country(code: "LU", name: "Luxemburgo"),
  Country(code: "MO", name: "Macau, RAE da China"),
  Country(code: "MK", name: "Macedônia do Norte"),
  Country(code: "MG", name: "Madagascar"),
  Country(code: "MY", name: "Malásia"),
  Country(code: "MW", name: "Malaui"),
  Country(code: "MV", name: "Maldivas"),
  Country(code: "ML", name: "Mali"),
  Country(code: "MT", name: "Malta"),
  Country(code: "MA", name: "Marrocos"),
  Country(code: "MQ", name: "Martinica"),
  Country(code: "MU", name: "Maurício"),
  Country(code: "MR", name: "Mauritânia"),
  Country(code: "YT", name: "Mayotte"),
  Country(code: "MX", name: "México"),
  Country(code: "MM", name: "Mianmar (Birmânia)"),
  Country(code: "FM", name: "Micronésia"),
  Country(code: "MZ", name: "Moçambique"),
  Country(code: "MD", name: "Moldova"),
  Country(code: "MC", name: "Mônaco"),
  Country(code: "MN", name: "Mongólia"),
  Country(code: "ME", name: "Montenegro"),
  Country(code: "MS", name: "Montserrat"),
  Country(code: "NA", name: "Namíbia"),
  Country(code: "NR", name: "Nauru"),
  Country(code: "NP", name: "Nepal"),
  Country(code: "NI", name: "Nicarágua"),
  Country(code: "NE", name: "Níger"),
  Country(code: "NG", name: "Nigéria"),
  Country(code: "NU", name: "Niue"),
  Country(code: "NO", name: "Noruega"),
  Country(code: "NC", name: "Nova Caledônia"),
  Country(code: "NZ", name: "Nova Zelândia"),
  Country(code: "OM", name: "Omã"),
  Country(code: "NL", name: "Países Baixos"),
  Country(code: "BQ", name: "Países Baixos Caribenhos"),
  Country(code: "PW", name: "Palau"),
  Country(code: "PA", name: "Panamá"),
  Country(code: "PG", name: "Papua-Nova Guiné"),
  Country(code: "PK", name: "Paquistão"),
  Country(code: "PY", name: "Paraguai"),
];

List<Country> countriesEn = [
  Country(code: "AF", name: "Afghanistan"),
  Country(code: "AX", name: "Åland Islands"),
  Country(code: "AL", name: "Albania"),
  Country(code: "DZ", name: "Algeria"),
  Country(code: "AS", name: "American Samoa"),
  Country(code: "AD", name: "Andorra"),
  Country(code: "AO", name: "Angola"),
  Country(code: "AI", name: "Anguilla"),
  Country(code: "AQ", name: "Antarctica"),
  Country(code: "AG", name: "Antigua & Barbuda"),
  Country(code: "AR", name: "Argentina"),
  Country(code: "AM", name: "Armenia"),
  Country(code: "AW", name: "Aruba"),
  Country(code: "AU", name: "Australia"),
  Country(code: "AT", name: "Austria"),
  Country(code: "AZ", name: "Azerbaijan"),
  Country(code: "BS", name: "Bahamas"),
  Country(code: "BH", name: "Bahrain"),
  Country(code: "BD", name: "Bangladesh"),
  Country(code: "BB", name: "Barbados"),
  Country(code: "BY", name: "Belarus"),
  Country(code: "BE", name: "Belgium"),
  Country(code: "BZ", name: "Belize"),
  Country(code: "BJ", name: "Benin"),
  Country(code: "BM", name: "Bermuda"),
  Country(code: "BT", name: "Bhutan"),
  Country(code: "BO", name: "Bolivia"),
  Country(code: "BA", name: "Bosnia & Herzegovina"),
  Country(code: "BW", name: "Botswana"),
  Country(code: "BV", name: "Bouvet Island"),
  Country(code: "BR", name: "Brazil"),
  Country(code: "IO", name: "British Indian Ocean Territory"),
  Country(code: "VG", name: "British Virgin Islands"),
  Country(code: "BN", name: "Brunei"),
  Country(code: "BG", name: "Bulgaria"),
  Country(code: "BF", name: "Burkina Faso"),
  Country(code: "BI", name: "Burundi"),
  Country(code: "KH", name: "Cambodia"),
  Country(code: "CM", name: "Cameroon"),
  Country(code: "CA", name: "Canada"),
  Country(code: "CV", name: "Cape Verde"),
  Country(code: "BQ", name: "Caribbean Netherlands"),
  Country(code: "KY", name: "Cayman Islands"),
  Country(code: "CF", name: "Central African Republic"),
  Country(code: "TD", name: "Chad"),
  Country(code: "CL", name: "Chile"),
  Country(code: "CN", name: "China"),
  Country(code: "CX", name: "Christmas Island"),
  Country(code: "CC", name: "Cocos (Keeling) Islands"),
  Country(code: "CO", name: "Colombia"),
  Country(code: "KM", name: "Comoros"),
  Country(code: "CG", name: "Congo - Brazzaville"),
  Country(code: "CD", name: "Congo - Kinshasa"),
  Country(code: "CK", name: "Cook Islands"),
  Country(code: "CR", name: "Costa Rica"),
  Country(code: "CI", name: "Côte dIvoire"),
  Country(code: "HR", name: "Croatia"),
  Country(code: "CU", name: "Cuba"),
  Country(code: "CW", name: "Curaçao"),
  Country(code: "CY", name: "Cyprus"),
  Country(code: "CZ", name: "Czechia"),
  Country(code: "DK", name: "Denmark"),
  Country(code: "DJ", name: "Djibouti"),
  Country(code: "DM", name: "Dominica"),
  Country(code: "DO", name: "Dominican Republic"),
  Country(code: "EC", name: "Ecuador"),
  Country(code: "EG", name: "Egypt"),
  Country(code: "SV", name: "El Salvador"),
  Country(code: "GQ", name: "Equatorial Guinea"),
  Country(code: "ER", name: "Eritrea"),
  Country(code: "EE", name: "Estonia"),
  Country(code: "SZ", name: "Eswatini"),
  Country(code: "ET", name: "Ethiopia"),
  Country(code: "FK", name: "Falkland Islands"),
  Country(code: "FO", name: "Faroe Islands"),
  Country(code: "FJ", name: "Fiji"),
  Country(code: "FI", name: "Finland"),
  Country(code: "FR", name: "France"),
  Country(code: "GF", name: "French Guiana"),
  Country(code: "PF", name: "French Polynesia"),
  Country(code: "TF", name: "French Southern Territories"),
  Country(code: "GA", name: "Gabon"),
  Country(code: "GM", name: "Gambia"),
  Country(code: "GE", name: "Georgia"),
  Country(code: "DE", name: "Germany"),
  Country(code: "GH", name: "Ghana"),
  Country(code: "GI", name: "Gibraltar"),
  Country(code: "GR", name: "Greece"),
  Country(code: "GL", name: "Greenland"),
  Country(code: "GD", name: "Grenada"),
  Country(code: "GP", name: "Guadeloupe"),
  Country(code: "GU", name: "Guam"),
  Country(code: "GT", name: "Guatemala"),
  Country(code: "GG", name: "Guernsey"),
  Country(code: "GN", name: "Guinea"),
  Country(code: "GW", name: "Guinea-Bissau"),
  Country(code: "GY", name: "Guyana"),
  Country(code: "HT", name: "Haiti"),
  Country(code: "HM", name: "Heard & McDonald Islands"),
  Country(code: "HN", name: "Honduras"),
  Country(code: "HK", name: "Hong Kong SAR China"),
  Country(code: "HU", name: "Hungary"),
  Country(code: "IS", name: "Iceland"),
  Country(code: "IN", name: "India"),
  Country(code: "ID", name: "Indonesia"),
  Country(code: "IR", name: "Iran"),
  Country(code: "IQ", name: "Iraq"),
  Country(code: "IE", name: "Ireland"),
  Country(code: "IM", name: "Isle of Man"),
  Country(code: "IL", name: "Israel"),
  Country(code: "IT", name: "Italy"),
  Country(code: "JM", name: "Jamaica"),
  Country(code: "JP", name: "Japan"),
  Country(code: "JE", name: "Jersey"),
  Country(code: "JO", name: "Jordan"),
  Country(code: "KZ", name: "Kazakhstan"),
  Country(code: "KE", name: "Kenya"),
  Country(code: "KI", name: "Kiribati"),
  Country(code: "KW", name: "Kuwait"),
  Country(code: "KG", name: "Kyrgyzstan"),
  Country(code: "LA", name: "Laos"),
  Country(code: "LV", name: "Latvia"),
  Country(code: "LB", name: "Lebanon"),
  Country(code: "LS", name: "Lesotho"),
  Country(code: "LR", name: "Liberia"),
  Country(code: "LY", name: "Libya"),
  Country(code: "LI", name: "Liechtenstein"),
  Country(code: "LT", name: "Lithuania"),
  Country(code: "LU", name: "Luxembourg"),
  Country(code: "MO", name: "Macao SAR China"),
  Country(code: "MG", name: "Madagascar"),
  Country(code: "MW", name: "Malawi"),
  Country(code: "MY", name: "Malaysia"),
  Country(code: "MV", name: "Maldives"),
  Country(code: "ML", name: "Mali"),
  Country(code: "MT", name: "Malta"),
  Country(code: "MH", name: "Marshall Islands"),
  Country(code: "MQ", name: "Martinique"),
  Country(code: "MR", name: "Mauritania"),
  Country(code: "MU", name: "Mauritius"),
  Country(code: "YT", name: "Mayotte"),
  Country(code: "MX", name: "Mexico"),
  Country(code: "FM", name: "Micronesia"),
  Country(code: "MD", name: "Moldova"),
  Country(code: "MC", name: "Monaco"),
  Country(code: "MN", name: "Mongolia"),
  Country(code: "ME", name: "Montenegro"),
  Country(code: "MS", name: "Montserrat"),
  Country(code: "MA", name: "Morocco"),
  Country(code: "MZ", name: "Mozambique"),
  Country(code: "MM", name: "Myanmar (Burma)"),
  Country(code: "NA", name: "Namibia"),
  Country(code: "NR", name: "Nauru"),
  Country(code: "NP", name: "Nepal"),
  Country(code: "NL", name: "Netherlands"),
  Country(code: "NC", name: "New Caledonia"),
  Country(code: "NZ", name: "New Zealand"),
  Country(code: "NI", name: "Nicaragua"),
  Country(code: "NE", name: "Niger"),
  Country(code: "NG", name: "Nigeria"),
  Country(code: "NU", name: "Niue"),
  Country(code: "NF", name: "Norfolk Island"),
  Country(code: "KP", name: "North Korea"),
  Country(code: "MK", name: "North Macedonia"),
  Country(code: "MP", name: "Northern Mariana Islands"),
  Country(code: "NO", name: "Norway"),
  Country(code: "OM", name: "Oman"),
  Country(code: "PK", name: "Pakistan"),
  Country(code: "PW", name: "Palau"),
  Country(code: "PS", name: "Palestinian Territories"),
  Country(code: "PA", name: "Panama"),
  Country(code: "PG", name: "Papua New Guinea"),
  Country(code: "PY", name: "Paraguay"),
  Country(code: "PE", name: "Peru"),
  Country(code: "PH", name: "Philippines"),
  Country(code: "PN", name: "Pitcairn Islands"),
  Country(code: "PL", name: "Poland"),
  Country(code: "PT", name: "Portugal"),
  Country(code: "PR", name: "Puerto Rico"),
  Country(code: "QA", name: "Qatar"),
  Country(code: "RE", name: "Réunion"),
  Country(code: "RO", name: "Romania"),
  Country(code: "RU", name: "Russia"),
  Country(code: "RW", name: "Rwanda"),
  Country(code: "WS", name: "Samoa"),
  Country(code: "SM", name: "San Marino"),
  Country(code: "ST", name: "São Tomé & Príncipe"),
  Country(code: "SA", name: "Saudi Arabia"),
  Country(code: "SN", name: "Senegal"),
  Country(code: "RS", name: "Serbia"),
  Country(code: "SC", name: "Seychelles"),
  Country(code: "SL", name: "Sierra Leone"),
  Country(code: "SG", name: "Singapore"),
  Country(code: "SX", name: "Sint Maarten"),
  Country(code: "SK", name: "Slovakia"),
  Country(code: "SI", name: "Slovenia"),
  Country(code: "SB", name: "Solomon Islands"),
  Country(code: "SO", name: "Somalia"),
  Country(code: "ZA", name: "South Africa"),
  Country(code: "GS", name: "South Georgia & South Sandwich Islands"),
  Country(code: "KR", name: "South Korea"),
  Country(code: "SS", name: "South Sudan"),
  Country(code: "ES", name: "Spain"),
  Country(code: "LK", name: "Sri Lanka"),
  Country(code: "BL", name: "St. Barthélemy"),
  Country(code: "SH", name: "St. Helena"),
  Country(code: "KN", name: "St. Kitts & Nevis"),
  Country(code: "LC", name: "St. Lucia"),
  Country(code: "MF", name: "St. Martin"),
  Country(code: "PM", name: "St. Pierre & Miquelon"),
  Country(code: "VC", name: "St. Vincent & Grenadines"),
  Country(code: "SD", name: "Sudan"),
  Country(code: "SR", name: "Suriname"),
  Country(code: "SJ", name: "Svalbard & Jan Mayen"),
  Country(code: "SE", name: "Sweden"),
  Country(code: "CH", name: "Switzerland"),
  Country(code: "SY", name: "Syria"),
  Country(code: "TW", name: "Taiwan"),
  Country(code: "TJ", name: "Tajikistan"),
  Country(code: "TZ", name: "Tanzania"),
  Country(code: "TH", name: "Thailand"),
  Country(code: "TL", name: "Timor-Leste"),
  Country(code: "TG", name: "Togo"),
  Country(code: "TK", name: "Tokelau"),
  Country(code: "TO", name: "Tonga"),
  Country(code: "TT", name: "Trinidad & Tobago"),
  Country(code: "TN", name: "Tunisia"),
  Country(code: "TR", name: "Turkey"),
  Country(code: "TM", name: "Turkmenistan"),
  Country(code: "TC", name: "Turks & Caicos Islands"),
  Country(code: "TV", name: "Tuvalu"),
  Country(code: "UM", name: "U.S. Outlying Islands"),
  Country(code: "VI", name: "U.S. Virgin Islands"),
  Country(code: "UG", name: "Uganda"),
  Country(code: "UA", name: "Ukraine"),
  Country(code: "AE", name: "United Arab Emirates"),
  Country(code: "GB", name: "United Kingdom"),
  Country(code: "US", name: "United States"),
  Country(code: "UY", name: "Uruguay"),
  Country(code: "UZ", name: "Uzbekistan"),
  Country(code: "VU", name: "Vanuatu"),
  Country(code: "VA", name: "Vatican City"),
  Country(code: "VE", name: "Venezuela"),
  Country(code: "VN", name: "Vietnam"),
  Country(code: "WF", name: "Wallis & Futuna"),
  Country(code: "EH", name: "Western Sahara"),
  Country(code: "YE", name: "Yemen"),
  Country(code: "ZM", name: "Zambia"),
  Country(code: "ZW", name: "Zimbabwe"),
];

List<City> citiesPt = [
  City(id: "1", countryCode: "BR", name: "Rio Branco"),
  City(id: "2", countryCode: "BR", name: "Maceió"),
  City(id: "3", countryCode: "BR", name: "Macapá"),
  City(id: "4", countryCode: "BR", name: "Manaus"),
  City(id: "5", countryCode: "BR", name: "Salvador"),
  City(id: "6", countryCode: "BR", name: "Fortaleza"),
  City(id: "7", countryCode: "BR", name: "Brasília"),
  City(id: "8", countryCode: "BR", name: "Vitória"),
  City(id: "9", countryCode: "BR", name: "Goiânia"),
  City(id: "10", countryCode: "BR", name: "São Luís"),
  City(id: "11", countryCode: "BR", name: "Cuiabá"),
  City(id: "12", countryCode: "BR", name: "Campo Grande"),
  City(id: "13", countryCode: "BR", name: "Belo Horizonte"),
  City(id: "14", countryCode: "BR", name: "Belém"),
  City(id: "15", countryCode: "BR", name: "João Pessoa"),
  City(id: "16", countryCode: "BR", name: "Curitiba"),
  City(id: "17", countryCode: "BR", name: "Recife"),
  City(id: "18", countryCode: "BR", name: "Teresina"),
  City(id: "19", countryCode: "BR", name: "Rio de Janeiro"),
  City(id: "20", countryCode: "BR", name: "Natal"),
  City(id: "21", countryCode: "BR", name: "Porto Alegre"),
  City(id: "22", countryCode: "BR", name: "Porto Velho"),
  City(id: "23", countryCode: "BR", name: "Boa Vista"),
  City(id: "24", countryCode: "BR", name: "Florianópolis"),
  City(id: "25", countryCode: "BR", name: "São Paulo"),
  City(id: "26", countryCode: "BR", name: "Aracaju"),
  City(id: "27", countryCode: "BR", name: "Palmas"),
  City(id: "28", countryCode: "IT", name: "Roma"),
];

List<City> citiesEn = [
  City(id: "1", countryCode: "BR", name: "Rio Branco"),
  City(id: "2", countryCode: "BR", name: "Maceió"),
  City(id: "3", countryCode: "BR", name: "Macapá"),
  City(id: "4", countryCode: "BR", name: "Manaus"),
  City(id: "5", countryCode: "BR", name: "Salvador"),
  City(id: "6", countryCode: "BR", name: "Fortaleza"),
  City(id: "7", countryCode: "BR", name: "Brasília"),
  City(id: "8", countryCode: "BR", name: "Vitória"),
  City(id: "9", countryCode: "BR", name: "Goiânia"),
  City(id: "10", countryCode: "BR", name: "São Luís"),
  City(id: "11", countryCode: "BR", name: "Cuiabá"),
  City(id: "12", countryCode: "BR", name: "Campo Grande"),
  City(id: "13", countryCode: "BR", name: "Belo Horizonte"),
  City(id: "14", countryCode: "BR", name: "Belém"),
  City(id: "15", countryCode: "BR", name: "João Pessoa"),
  City(id: "16", countryCode: "BR", name: "Curitiba"),
  City(id: "17", countryCode: "BR", name: "Recife"),
  City(id: "18", countryCode: "BR", name: "Teresina"),
  City(id: "19", countryCode: "BR", name: "Rio de Janeiro"),
  City(id: "20", countryCode: "BR", name: "Natal"),
  City(id: "21", countryCode: "BR", name: "Porto Alegre"),
  City(id: "22", countryCode: "BR", name: "Porto Velho"),
  City(id: "23", countryCode: "BR", name: "Boa Vista"),
  City(id: "24", countryCode: "BR", name: "Florianópolis"),
  City(id: "25", countryCode: "BR", name: "São Paulo"),
  City(id: "26", countryCode: "BR", name: "Aracaju"),
  City(id: "27", countryCode: "BR", name: "Palmas"),
  City(id: "28", countryCode: "IT", name: "Rome"),
];
