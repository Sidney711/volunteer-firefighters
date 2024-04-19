# Aplikace pro sdružení dobrovolných hasičů ČR - semestrální projekt Ruby On Rails II

## Úvod

Aplikace splňuje minimální požadavky zadání a všechny premisy, které mají v aplikaci platit.

Co se týče běžných uživatelů, tak ti nemají možnost se přihlásit, správci a super admini ano.

## Spuštění aplikace
1. Vytvořit .env file podle .env-example
2. Spustit docker-compose build
3. Spustit docker-compose up
4. Spustit ./db-recreate.sh (spustí migrace, seed)
5. Spustit ./run-tailwindcss.sh (spustí tailwindcss)
6. Spustit ./linux_rails.sh rails dev:cache (spustí cache v developmentu)
7. V aplikaci mají všichni uživatelé ze seedu heslo password123
8. V aplikaci se po seedu nachází uživatel superadmin@example.com s heslem password123

## Domácí úloha

1. Projekt bude obsahovat tabulky pro jednotlivé entity, bude mít definované relace
   mezi nimi a validace [4 bodů] - **splněno** ✅ (migrace se nachází v `db/migrate` a modely s relacemi a validacemi v `app/models`)
2. V aplikaci budou dostupné API endpointy, přístupné přes Api-Klíč [4 bodů] - **splněno** ✅
   - endpoint pro výpis SDH - **splněno** ✅ (nachází se v `app/controllers/api/v1/firefighters_controller.rb`)
   - endpoint pro vytvoření/úpravu/smazání člena - **splněno** ✅ (nachází se v `app/controllers/api/v1/accounts_controller.rb`)
3. Jednotlivé entity budou mít napsané testy - **splněno** ✅
   - validace, asociace [2 bodů] - **splněno** ✅ (testy se nachází v `spec/models`)
   - API endpointy [2 bodů] - **splněno** ✅ (testy se nachází v `spec/requests`)

## Semestrální projekt

1. Prezentace + odprezentování projektu. Prezentace je povinná [7 bodů] - **bude následovat ❓** 
2. Projekt bude obsahovat UI pro zadávání/editaci a mazání jednotlivých údajů do
   čísleníků [5 bodů] - **splněno** ✅ (splněno ve všech views v `app/views`)
3. Číselníky budou umožňovat filtrování dat [3 bodů] - **splněno** ✅ (splněno v každém index souboru ve views v `app/views` a v controllerech entit v index metodách v `app/controllers`)
4. Aplikace bude obsahovat seed.rb soubor, pro předvyplnění číselníků nějakými
   vzorovými daty [3 bodů] - **splněno** ✅ (seed se nachází v `db/seeds.rb`)
5. Použití ActiveJob na odložené přiřazení ocenění členovi [4 bodů] - **splněno** ✅
   - job se nachází v `app/jobs/assign_award_job.rb`
   - v service `app/services/account_service.rb` je metoda `update_account_awards`, která vytváří nový job v případě přidání ocenění s odloženým spuštěním (metoda je trochu specifičtější kvůli použití nested form, v případě nejasností můžu vyvsětlit osobně při prezentaci)
6. Aplikace využije cachovací mechanismus [2 bodů] - **splněno** ✅
   - cachování jsem aplikoval ve view indexu district (v `app/views/districts/index.html.erb`, řádky 22 a 23)
7. Aplikace bude obsahovat Service objekt - **splněno** ✅
   - definování Service objektu a jeho použití [3 bodů] - **splněno** ✅ (service objekt se nachází v `app/services/account_service.rb` a je použit v `app/controllers/accounts_controller.rb` převážně za účely bodu 5)
   - testy na Service objekt [2 bodů] - **splněno** ✅ (testy se nachází v `spec/services`)
8. API endpoint pro výpis získaných ocenění konkrétního člena - **splněno** ✅
   - endpoint [2 bodů] - **splněno** ✅ (nachází se v `app/controllers/api/v1/accounts_controller.rb` v metodě `awards`)
   - testy [1 bodů] - **splněno** ✅ (testy se nachází v `spec/requests/api/v1/api_accounts_spec.rb`)
9. Využití hotwire v aplikaci a stimulus v aplikaci
   - ukázka využití hotwire alespoň na jedné stránce (např. formulář + výpis) [4
   bodů] - **nesplněno** ❌ (neměl jsem už nápad, kde hotwire využít mimo websocket a stimulus, buď jsem něco zkusil a rozbíjelo to aktuální funkcionality nebo to nebylo vhodné použít)
   - aplikace využije websocketů k live aktualizaci dat při přidání/úpravě/smazání
   (alespoň na jedné stránce) [4 bodů] - **splněno** ✅ (websocket jsem použil pro zobrazení členů, konfigurace se nachází v `app/channels/accounts_channel.rb` a využití v `app/javascript/channels/accounts_channel.js`, celé využití je v `app/views/accounts/index.html.erb`)
   - využití stimulus controlleru [2 bodů] - **splněno** ✅ (stimulus používám pro nested form při aktualizaci uživatele, kde mu lze přidat ocenění nested form jsem importoval v `app/javascript/controllers/index.js` a používám v `app/views/accounts/_form.html.erb`(60 až 72 řádek) + view `app/views/accounts/_account_award_fields.html.erb` pro každé ocenění)