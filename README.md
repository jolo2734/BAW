# Bezpieczeństwo Aplikacji Webowych
Repozytorium służy do przechowywyania materiałów do projektu z przedmiotu BAW.
Celem projektu jest wykrycie i wykorzystanie jak największej ilości podatności w maszynie wirtualnej Metasploitable3 oraz automatyzacja tych exploitów.

## Zawartość repozytorium
- **attack_conf** - folder zawierający pliki ".rc" oraz skrypty w języku Bash do/pomagające w automatycznej exploitacji
- **nmap** - zawiera zrzuty ekranu z wyników skanowania programem Nmap

## Wymagania
Wymagany jest zainstalowany program "msfconsole"
(U nas na systemie operacyjnym Kali Linux)

## Uruchamianie exploitów 
msfconsole -r <plik.rc>

# Wyniki nmap'a
![Wyniki nmap'a](/nmap/nmap.jpg)

# Opis wykorzystanych podatności oraz exploitów

## ProFTPd
Moduł ten wykorzystuje polecenia SITE CPFR/CPTO mod_copy w ProFTPD w wersji 1.3.5. Każdy nieuwierzytelniony klient może wykorzystać te polecenia do skopiowania plików z dowolnej części systemu plików do wybranego miejsca docelowego. Polecenia kopiowania wykonywane są z uprawnieniami usługi ProFTPD, która domyślnie działa z uprawnieniami użytkownika „nobody”. Używając /proc/self/cmdline do skopiowania ładunku PHP do katalogu witryny internetowej, możliwe jest zdalne wykonanie kodu PHP.

## SSH BruteForce
Możliwe było zalogowanie się do zdalnego serwera SSH przy użyciu domyślnych danych uwierzytelniających. Ponieważ terminal VT „SSH Brute Force Logins With Default Credentials” (OID: 1.3.6.1.4.1.25623.1.0.108013) może przekroczyć limit czasu, faktyczne zgłaszanie tej luki odbywa się w tym VT. Preferencja skryptu „Przekroczenie limitu czasu raportu” umożliwia skonfigurowanie raportowania takiego przekroczenia limitu czasu.

## IRC(UnrealIRC)
Moduł ten wykorzystuje złośliwego backdoora, który został dodany do archiwum pobierania Unreal IRCD 3.2.8.1. Ten backdoor znajdował się w archiwum Unreal 3.2.8.1.tar.gz między listopadem 2009 a 12 czerwca 2010.

## PHPMyAdmin BruteForce
Ten moduł wykorzystuje lukę PREG_REPLACE_EVAL w pliku Apply_prefix_tbl programu phpMyAdmin w obrębie bibliotek/mult_submits.inc.php za pośrednictwem db_settings.php. Dotyczy to wersji 3.5.x < 3.5.8.1 i 4.0.0 < 4.0.0-rc3. Wersje PHP > 5.4.6 nie są podatne na ataki.

## Drupal
Moduł ten wykorzystuje metodę SQL Injection klucza/wartości parametru HTTP Drupala (znaną również jako Drupageddon) w celu uzyskania zdalnej powłoki w podatnej instancji. Moduł ten został przetestowany w stosunku do Drupala 7.0 i 7.31 (poprawiono w wersji 7.32). Dostępne są dwie metody wyzwalania ładunku PHP: 
• ustawienie TARGET 0: metoda wstrzykiwania PHP do pamięci podręcznej formularzy (domyślna). Wykorzystuje to SQL do przesłania złośliwego formularza do pamięci podręcznej Drupala, a następnie wyzwala wpis w pamięci podręcznej w celu wykonania ładunku za pomocą łańcucha POP. 
• ustawienie TARGET 1: metoda wstrzykiwania po użytkowniku. Spowoduje to utworzenie nowego użytkownika Drupala, dodanie go do grupy administratorów, włączenie modułu PHP Drupala, przyznanie administratorom prawa do dołączania kodu PHP do swoich postów, utworzenie nowego postu zawierającego ładunek i podgląd go w celu uruchomienia wykonania ładunku.

## Apache mod-cgi
Moduł ten wykorzystuje lukę w zabezpieczeniach Shellshock, lukę w sposobie, w jaki powłoka bash obsługuje zewnętrzne zmienne środowiskowe. Moduł ten atakuje skrypty CGI na serwerze WWW Apache, ustawiając zmienną środowiskową HTTP_USER_AGENT na definicję szkodliwej funkcji.

## Ruby on Rails
Moduł ten wykorzystuje lukę w zabezpieczeniach umożliwiającą zdalne wykonanie kodu we wbudowanym procesorze żądań komponentu Ruby on Rails ActionPack. Ta luka umożliwia osobie atakującej przetworzenie ERB do wbudowanego procesora JSON, który jest następnie renderowany, umożliwiając pełne RCE w czasie wykonywania, bez rejestrowania warunku błędu.  
