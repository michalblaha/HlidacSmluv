# Kontrola transparetnich uctu

Kontrola dat z parseru z ČSOB
> je poměrně komplikovaný
> z nestrukturovaného PDF se první udělá strukturovaný Excel
> a ten se analyzuje (posuny sloupcu apod) a zparsuje.
   
## Soubory   
* ucty.json - pár vybraných účtů ke kontrole, struktura je popisna
* ucet*.json - položky z výpisu účtů

struktura jedné položky z účtu

```
  {
    "Id": "693d2ec5-76c6-4a53-a2a3-111edea2ad23",  //unikatni ID
    "CisloUctu": "478648033/0300",                 //cislo uctu, ve kterem polozka je. Povinne
    "Datum": "2017-04-03T00:00:00",                //datum pripsani na ucet. Povinne
    "PopisTransakce": "",                          //popis transakce, obvykle od banky
    "NazevProtiuctu": "SLECHTICKA HANA",           //nazev uctu, odkud/kam jdou penize. Casto prazdne
    "CisloProtiuctu": "63433153/0800",             //cislo uctu, odkud/kam jdou penize. Povinne
    "ZpravaProPrijemce": "P. Šlechtický",          //Zprava od odesilatele penez, ci pro adresata
    "VS": "",                                      //Variabilni symbol
    "KS": "",                                      //Konstantni symbol
    "SS": "36102",                                 //Specificky symbol
    "Castka": 200.00,                              //Castka v mene uctu, povinné
    "AddId": "51201704030473932"                   //Někdy obsahuje unikátní číslo transakce v bance
  }
```
