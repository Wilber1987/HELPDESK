# SNI_UNAN
@startuml
Bob->Alice : hello
@enduml


clonar con todos los submodulos: 
´´git clone --recurse-submodules -j8 https://github.com/Wilber1987/EMPRE_SA.git ´´

clonar solo sub modulos:
´´git submodule update --init --recursive´´
git submodule update --init --remote


configuracion de modulos

[submodule "UI/wwwroot/WDevCore"]
	path = UI/wwwroot/WDevCore
	url = https://github.com/Wilber1987/WDevCore
[submodule "CAPA_DATOS"]
	path = CAPA_DATOS
	url = https://github.com/Wilber1987/CAPA_DATOS.git


git submodule update --remote
entonces

git commit && git push


push de submodule
git push origin HEAD:main

PxI/Pz8/Pz8/PwdSP2E/Pw==

--CONFIGURACION EXCHANGE

Import-Module ExchangeOnlineManagement
New-ServicePrincipal -AppId [id. de aplicación (cliente)]  -ServiceId   [Id. de objeto]

Get-ServicePrincipal

Add-MailboxPermission -Identidad "wilbermatusgonzalez@wexpdev.onmicrosoft.com"  -Usuario -ServiceId  [Id. de objeto] -AccessRights FullAccess

Add-MailboxPermission -Identity "wdevexp@wexpdev.onmicrosoft.com" -User  [Id. de objeto]  -AccessRights FullAccess

Connect-ExchangeOnline -UserPrincipalName "wdevexp@wexpdev.onmicrosoft.com"
Connect-ExchangeOnline -UserPrincipalName "wilbermatusgonzalez@wexpdev.onmicrosoft.com"



--BORRAR DATOS DE PRUEBA
delete from helpdesk.Tbl_Comments_Tasks 
delete from helpdesk.Tbl_Comments
delete from helpdesk.Tbl_Mails
delete from helpdesk.Tbl_Calendario 
delete from helpdesk.Tbl_Participantes  
delete from helpdesk.Tbl_Tareas 
delete from helpdesk.Tbl_Profile_CasosAsignados  
delete from helpdesk.Tbl_Case

dotnet publish --configuration Release