# CurrencyMate - Flutter v.4

## Om projektet

CurrencyMate är en cross-platform mobilapplikation skapad med Flutter.

Applikationen fungerar på både Android och Web och använder samma huvudsakliga UI och funktionalitet på båda plattformarna.

Appens huvudsakliga funktion är att konvertera valutor med aktuell valutakurs från ett API.

## Funktioner

- Valutakonvertering mellan SEK, EUR, USD och GBP
- Live valutakurser från ett externt API
- Två olika sidor
- Navigation med Flutter Router / GoRouter
- Lokal lagring med SharedPreferences
- Inställningar som sparas efter att applikationen stängs
- Custom app icon
- Custom favicon för webben
- Lokal bildresurs
- Fungerar på Android och Web

## Sidor

### Currency Converter

På startsidan kan användaren:

- Skriva in ett belopp
- Välja vilken valuta man vill konvertera från
- Välja vilken valuta man vill konvertera till
- Trycka på Convert
- Se resultatet från valutakonverteringen
- Använda en Switch
- Navigera till Settings

### Settings

På Settings-sidan kan användaren:

- Skriva in sitt namn
- Välja preferred currency
- Ändra textstorlek med en Slider
- Spara inställningarna lokalt

Inställningarna sparas med SharedPreferences och finns kvar efter att applikationen har stängts.

## API

Applikationen använder Frankfurter API för valutakurser.

När användaren väljer till exempel:

100 SEK → EUR

skickar appen en HTTP-request till API:et.

API:et skickar tillbaka aktuell valutakurs och applikationen multiplicerar beloppet med valutakursen för att visa resultatet.

Jag använder paketet:

http

för att kommunicera med API:et.

## Lokal lagring

Jag använder SharedPreferences för att spara användarens inställningar.

Exempel på data som sparas:

- Namn
- Preferred currency
- Textstorlek

På Android sparas detta lokalt i applikationen.

På Web sparas informationen i webbläsarens lokala lagring.

## Navigation

Jag använder GoRouter för navigation.

Appen har två routes:

- /
- /settings

Startsidan använder / och Settings använder /settings.

Det gör att samma navigation fungerar på både Android och Web.

## Interaktiva widgets

Applikationen använder flera interaktiva Flutter widgets, bland annat:

- TextFormField
- ElevatedButton
- DropdownButtonFormField
- SwitchListTile
- Slider
- TextButton
- IconButton

## Bild

Applikationen använder en lokal bild:

assets/images/currencymate_logo.png

Bilden visas med Image.asset.

Samma design används även för appens Android icon och webbens favicon.

## Android och Web

Android- och webbversionen använder samma Flutter-kod och har samma huvudsakliga funktioner.

På Android visas applikationen i portrait-format på en mobilskärm.

På Web anpassas innehållet till en större skärm. Jag använder bland annat ConstrainedBox för att innehållet inte ska bli för brett.

En skillnad är hur SharedPreferences lagras. På Android används lokal app-lagring medan webbversionen använder webbläsarens lokala lagring.

## Svårigheter

En svårighet var lokal lagring på Web.

Flutter Web använde olika localhost-portar vid olika körningar. Webbläsaren behandlade därför dem som olika webbplatser och den sparade datan verkade försvinna.

Jag löste detta genom att köra webbappen på en fast port.

En annan svårighet var release-builden för Android.

Java och Kotlin använde först olika JVM-versioner. Detta gjorde att release APK:n inte kunde byggas.

Jag ändrade Gradle-inställningarna så att Java och Kotlin använder kompatibla JVM-inställningar.

Efter detta kunde jag skapa en signerad release APK.

## VG-kriterier

Jag valde följande två VG-kriterier:

1. Lokal persistent lagring med SharedPreferences
2. API-integration med valutakurser

Båda funktionerna används direkt i applikationen och ger appen funktionalitet.

## Build

Projektet har byggts för:

- Android
- Web

GitHub Release v1.0 innehåller:

- Signerad Android APK
- Zippad Web build

## Utvecklare

Benyamin Moghadam

JAVA25
Uppgift 3 - Flutter v.4