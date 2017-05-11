# Kontrola dat z parseru z ČSOB
> je poměrně komplikovaný
> z nestrukturovaného PDF se první udělá strukturovaný Excel
> a ten se analyzuje (posuny sloupcu apod) a zparsuje.
   
## S čím potřebuju pomoci
- [x] Zkontrolovat, že ucet\*.json obsahují všechny položky z výpisů z účtu v PDF, které obsahují cenu
- [x] Zkontrolovat, že ucet\*.json obsahují všechny podstatné údaje z položek v PDF a že jsou správně (viz struktura json níže)

   
## Soubory   
* ucty.json - pár vybraných účtů ke kontrole, struktura je popisna
* ucet\*.json - položky z výpisu účtů

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

## Kontrola

* ruby 2.2.0+

`./checker.rb soubor.json`

priklad vystupu
````
ERR: invalid attribute 'CisloProtiuctu' (val: '86-898461023 7 /O 100') in {"Id"=>"3098de78-d90b-4862-a43b-9b8b106151d2", 
"CisloUctu"=>"117527893/0300", "Datum"=>"2014-10-24T00:00:00", "PopisTransakce"=>"", "NazevProtiuctu"=>"", 
"CisloProtiuctu"=>"86-898461023 7 /O 100", "ZpravaProPrijemce"=>"volby senát-reklama", "VS"=>"14501661", 
"KS"=>"", "SS"=>"", "Castka"=>-30250.0, "AddId"=>"17201410240115750"}
````


-------------------

Pokud nevyhovují JSON soubory, zde jsou ty same soubory jako Google Spreadsheet

https://docs.google.com/spreadsheets/d/1Kvz-jx0maGlwP6jDu2U3cWOIiUQrCFWjBwYW1RNEFGI/edit?usp=sharing
https://docs.google.com/spreadsheets/d/1qFnIjaL5ZyVzB-pDFojGDyjzhCodZVmPwXk3pC1uuLU/edit?usp=sharing
https://docs.google.com/spreadsheets/d/1kdQtYP-4-LZAbIeDs1lwDusDZcPca7p3b_dyghrEGuM/edit?usp=sharing
https://docs.google.com/spreadsheets/d/1das0qdo6jHRiOZ399DnM0wy1Q5tEZUVImRcwSsz08fU/edit?usp=sharing
https://docs.google.com/spreadsheets/d/1Q0m7NT3-XxsWbtGCmT1Rt4TOcQRuxyQ1ilQVdJhQM-s/edit?usp=sharing
https://docs.google.com/spreadsheets/d/1nVi6GhX8u9FZWz8h8Tzzu3z6-F27jjZIrPjFR3M3NRY/edit?usp=sharing

