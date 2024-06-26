# Databáze organizace tábora - Jakub Pelc

## ER Diagram

![ER Diagram](erdia.png)

<div style="page-break-after: always;"></div>

### Uživatel
Uživatel <u>má</u> **login** a **heslo**. Každý **uživatel** <u>má</u> také 0..1 **osobní údaje** *(Jméno a Příjmení, Email, Telefon, Adresa)*.

### Vedoucí
**Uživatel** může <u>být</u> **účastník** nebo **vedoucí**. **Vedoucí** <u>vede</u> nějaké **účastníky**. I **vedoucí** může <u>mít</u> **vedoucího** (hlavní vedoucí).

Každý **vedoucí** <u>má</u> 0..1 **skupin** které <u>vede</u>.

Každý **účastník** <u>je součástí</u> právě jedné **skupiny**, kterou <u>vede</u> 1..N **vedoucích**.

### Skupina
Skupina <u>má</u> **název**, **účastníky** a **vedoucí**. **Skupina** může <u>mít</u> 0..N **účastníků** a 1..N **vedoucího**.

Na táboře je také doptupné **vybavení** (dalekohledy, fotoaparáty apod.), každá **skupina** <u>má přiděleno</u> určité **vybavení**. Vybavení <u>má</u> **inventární číslo**, **název**, **majitele** a může <u>mít</u> **cenu**. Každý kus **vybavení** <u>může</u> v daný moment <u>používat</u> nějaký **účastník** (je za něj zodpovědný).

### Akce
Na táboře se <u>pořádají</u> **akce**, každá **akce** <u>má</u> **název**, **čas** kdy se koná a může <u>mít</u> **popis** (například snídaně 11:00).

**Akce** může <u>být</u> **přednáškou** (ta <u>má</u> **přednášející**, **místo** konání, informaci jestli je **povinná**), nebo **workshop** (ten <u>má</u> **organizátory**, **místo** konání a **účastníky**).

**Vedoucí** může <u>vytvořit</u> **akci**, **přednášku** nebo **workshop** (ten **organizuje**), a může se <u>přihlásit</u> na **workshop**.

Účastníci se mohou <u>přihlásit</u> na **workshop** a mohou <u>organizovat</u> **workshop**.


