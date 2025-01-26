@echo on

:: Lire le premier argument de la ligne de commande
set optional=%1

:: Si aucun argument n'est passé, définir une valeur par défaut
if "%optional%"=="" set optional=N

:: Installation des MSI : Firefox
msiexec /i "C:\Apps\main\Firefox.msi" /qn

:: Installation des MSIX : Nanazip
powershell -command "Add-AppxPackage -Path 'C:\Apps\main\NanaZip_3.1.1080.0.msixbundle'"

regedit.exe /s "C:\Apps\regs\All.reg"

timeout /T 3

taskkill /F /IM explorer.exe & start explorer

:: Vérifier si l'utilisateur veut installer les options supplémentaires
if /I "%optional%"=="Y" (

    :: Création du dossier Sysinternals et copie des fichiers
    mkdir C:\Sysinternal
    xcopy C:\Apps\optional\SysinternalsSuite C:\Sysinternal /s /e /i /q

    :: Ajout de Sysinternal au PATH (de manière persistante)
    setx path "%PATH%;C:\Sysinternal" /M

    :: Installation silencieuse de Lockhunter
    C:\Apps\optional\lockhuntersetup.exe /VERYSILENT /NORESTART
    C:\Apps\main\SublimeText.exe /VERYSILENT /NORESTART

    :: Création du dossier x64dbg et copie des fichiers
    mkdir C:\x64dbg
    xcopy C:\Apps\optional\x64dbg C:\x64dbg /s /e /i /q

)

PowerShell -Command "Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Fini :)')"
