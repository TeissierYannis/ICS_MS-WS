# 1. LPE/RCE avec le service Spooler (CVE-2021-1675/34527 - PrintNightmare)


C'est une faille zéro day découverte en 2021 qui affecte le service spouleur d'impression, un composant de Windows activé par défaut. Dans un premier temps, cette faille de sécuritée liée au service d'impression Spooler permet aux utilisateurs de faire une escalade de privilèges en local. Son score CVSSv3 était donc de 7.8.

Le 8 juin 2021, Microsoft a publié un correctif qui concernait la CVE-2021-1675 et l'escalade de privilèges.

Néanmoins, 20 jours plus tard, des chercheurs ont présenté un dérivé de cette méthode permettant d'exploiter cette vulnérabilité à distance via une attaque RCE malgré le correctif déployé par Microsoft. Aujourd'hui, la faille est partiellement patchée, son score CVSSv3 va évoluer car il est question d'une escalade de privilèges en tant qu'utilisateur SYSTEM.

# 2. Exploitation

À l'aide du repository ci-dessous, les scripts nécessaires pour l'exploit sont donnés pour faire l'exécution de code à distance ou en local.
(https://github.com/cube0x0/CVE-2021-1675)

Le fonctionnement est simple il suffit de lancer le script avec les paramètres suivant : 
```
script.py domaine/user:password@IP <le fichier dll sur un serveur de fichiers partagés.>
```

# 3. Correctif

Afin de désactiver l'exploitation de cette faille, l'ANSSI recommande de modifier le type de démarrage du service spooler en mode "Disabled" sur les contrôleurs de domaine et sur toutes les machines ou ce n'est pas utile. Il est ensuite demandé de stopper le processus manuellement ou de redémarrer la machine.

# 4. Verification de la machine

Dans le cas où les valeurs sont identiques aux données ci-dessous, la machine est encore vulnérable.
```
HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint
    RestrictDriverInstallationToAdministrators  REG_DWORD   0x0
    NoWarningNoElevationOnInstall               REG_DWORD   0x1
````

Pour savoir si vous êtes vulnérables, suivez l'organigramme !

![Suis-je vulnérable](https://cyberwatch.fr/wp-content/uploads/2021/07/Spooler_schema8-1-1820x2048.jpg)
(source: https://cyberwatch.fr/actualite/cve-2021-34527-comment-identifier-et-neutraliser-la-vulnerabilite-printnightmare/)






