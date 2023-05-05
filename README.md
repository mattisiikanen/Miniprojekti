# Miniprojekti
Repo on kurssia palvelinten hallinta (ICI001AS3A-3001) varten. Miniprojektin tarkoituksena on pystyttää mielikuvitus yritykselle nimeltä Yritys Oy palvelininfra (herraorja-arkkitehtuurilla), jossa on sekä Linux että Windows palvelimia käytössä ja jokaisella palvelimella on oma tarkoituksensa osana infraa. Kokonaisuutta hallitaan Salt Vagrantilla.

## Ympäristö

Host:

- CPU: i5-13600K
- RAM: 32Gb
- HDD: 120Gb
- OS: Win 11 Pro x64
- Virtuaalialusta: Oracle VM VirtualBox Manager

Linux VMs:
- CPU: 2 CPU
- RAM: 512Mb
- HDD: 20Gb
- OS: Debian

Windows VM:
- CPU: 2 CPU
- RAM: 4Gb 
- HDD: 60Gb
- OS: Windows Server 2022


## Tarkoitus
Tarkoituksena on luoda yksi palvelin yrityksen keskusteluita ja palavereja varten käyttäen Mumblea, toinen palvelin hoitaa Apachella yrityksen kotisivut ja Windows palvelimelle on tarkoitus ottaa käyttöön Active Directory rooli, jolla hoidetaan identiteetin hallinta. Infrastruktuuria hallitaan kokonaisuudessaan Linux master koneella. Virtualisointialustana toiimi Oracle VM VirtualBox Manager. Infrastruktuuria varten otin lainaan opettajamme Tero Karvisen pohjan herraorja-arkkitehtuurista, Windows VM:ää varten Gusztáv Vargan Vagrant Boxin sekä ClayShakin artikkeleista / ohjeista mallia ```vagrantfile``` tiedoston luontiin. Provisioinnin aikana luodaan yhteensä 4 virtuaalikonetta + 1 virtuaaliverkko Saltin hallintaa varten. ```Mistermaster``` koneelle kopioidaan kaikki hallintaan tarvittavat ```.sls``` tiedostot kansioon ```/srv/salt```. Arkkitehtuuri on suunniteltu siten, että se asentaa valmiiksi tarvittavat työkalut ja jättää ylläpitäjälle mahdollisuuden konfiguroida  ympäristön itse loppuun. Olen päätöksellä jättää tarkemmat konfiguraatiot ylläpitäjälle takaa sitä, että kyseistä pohjaa ei ole suunniteltu ainaoastaan yhteen käyttöön, vaan että sitä voisi käyttää muutkin.


Palvelimet:
- mistermaster (Linux, Salt-Master)
- lminion001 (Linux, Salt-Minion, Mumble-palvelin)
- lminion002 (Linux, Salt-Minion, Apache-palvelin)
- wminion001 (Windows, Salt-Minion, Active Directory)


Verkko:
- Hostin oma verkko, johon se on kytketty
- Saltin hallintaverkko (192.168.12.1/24)
  * DHCP ei kytkettynä päälle


Looginen näkymä ympäristöstä: </br>
![Kuva1](https://user-images.githubusercontent.com/122887740/235692836-e1d3a962-0730-48be-aaf7-3396b811d41b.png)


## Esivaatimukset
- Vagrant Salt asennettuna hallintakoneella
- VirtualBox
- Vapaata levytilaa n. 100Gb (todellisuudessa ympäristö vie vähemmän, mutta levyt ovat dynaamisia, jonka vuoksi suosittelen kyseistä määrää)

## Ympäristön käyttöönotto
Ympäristöön tarvittavat tiedot saa ladattua tästä repositoriosta ja sen saa perustettua / käynnistettyä ajamalla komennot ```vagrant init``` sekä ```vagrant up```. Kun ympäristö on pystyssä, tulee vielä hyväksyä orjien avaimet herrakoneella, tämä onnistuu komennoilla ```vagrant ssh mistermaster``` ja yhteyden muodostuksen jälkeen ```sudo salt-key -A```. Provisioinnin yhteydessä olisi ollut mahdollisuus syöttää valmiiksi Salt-avaimet, mutta näin asian tietoturvariskinä ja päätin antaa koneiden luoda itse uudet avaimet jokaisella provisiointikerralla.


Kun herra-orja-arkkitehtuuri on saatu kuntoon, tulee ```mistermaster``` koneella aloittaa päivittämällä Windowsin repositoriot aivan ensimmäiseksi komennolla ```sudo salt -G 'os:windows' pkg.refresh_db``` ja tämän jälkeen voi ajaa seuraavan komennon: ```sudo salt '*' state.apply```. Kyseinen komento ajaa kaikille orjakoneille niin sanotun TOP-tilan (```top.sls``` tiedoston), jonka alle on määritetty erilaisia ```.sls```tiedostoja. Tilan saavutuksen jälkeen ympäristön idempotenttisuuden voi tarkistaa ajamalla aiemman komennon uudelleen. Tämän jälkeen Yritys Oy:n järjestelmien ylläpitäjällä on esiasennettu ympäristö valmiina konfigurointiin ja personointiin.


## Lähteet:
- Karvinen, Tero, 28.3.2023, Infra as Code course, Palvelinten Hallinta 2023 kevät - (https://terokarvinen.com/2023/palvelinten-hallinta-2023-kevat/)
- Karvinen, Tero, 28.3.2023, Salt Vagrant - automatically provision one master and two slaves - (https://terokarvinen.com/2023/salt-vagrant/)
- HashiCorp Vagrant Cloud, Gusztáv Varga, 16.4.2023 - gusztavvargadr/windows-server Vagrant box - (https://app.vagrantup.com/gusztavvargadr/boxes/windows-server)
- ClaySheck, 9.10.2020, Github  - (https://github.com/clayshek/salt-vagrant-windows/blob/main/Vagrantfile)
- SaltStack, 4.4.2023, vTHE TOP FILE - (https://docs.saltproject.io/en/latest/ref/states/top.html)
- Karvinen, Tero, Control Windows with Salt, 18.4.2018 - (https://terokarvinen.com/2018/control-windows-with-salt/)
