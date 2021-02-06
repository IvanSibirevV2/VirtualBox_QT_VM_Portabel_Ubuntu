/*
VirtualBox-6.1.0-r135406.msi
http://dlc-cdn.sun.com/virtualbox/6.1.0/VirtualBox-6.1.0-135406-Win.exe
http://dlc-cdn.sun.com/virtualbox/6.1.0/Oracle_VM_VirtualBox_Extension_Pack-6.1.0-135406.vbox-extpack
http://dlc-cdn.sun.com/virtualbox/6.0.10/VirtualBox-6.0.10-132072-Win.exe
http://dlc-cdn.sun.com/virtualbox/6.0.10/Oracle_VM_VirtualBox_Extension_Pack-6.0.10-132072.vbox-extpack
http://dlc-cdn.sun.com/virtualbox/6.0.8/VirtualBox-6.0.8-130520-Win.exe
http://dlc-cdn.sun.com/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8-130520.vbox-extpack
http://dlc-cdn.sun.com/virtualbox/6.0.6/VirtualBox-6.0.6-130049-Win.exe
http://dlc-cdn.sun.com/virtualbox/6.0.6/Oracle_VM_VirtualBox_Extension_Pack-6.0.6-130049.vbox-extpack
http://dlc-cdn.sun.com/virtualbox/6.0.4/VirtualBox-6.0.4-128413-Win.exe
http://dlc-cdn.sun.com/virtualbox/6.0.4/Oracle_VM_VirtualBox_Extension_Pack-6.0.4-128413.vbox-extpack
http://dlc-cdn.sun.com/virtualbox/6.0.2/VirtualBox-6.0.2-128162-Win.exe
http://dlc-cdn.sun.com/virtualbox/6.0.2/Oracle_VM_VirtualBox_Extension_Pack-6.0.2-128162.vbox-extpack
http://dlc-cdn.sun.com/virtualbox/6.0.0/VirtualBox-6.0.0-127566-Win.exe
http://dlc-cdn.sun.com/virtualbox/6.0.0/Oracle_VM_VirtualBox_Extension_Pack-6.0.0-127566.vbox-extpack
http://dlc-cdn.sun.com/virtualbox/5.2.22/VirtualBox-5.2.22-126460-Win.exe
http://dlc-cdn.sun.com/virtualbox/5.2.22/Oracle_VM_VirtualBox_Extension_Pack-5.2.22-126460.vbox-extpack
*/
; !define TEST

!define RELEASURL	"http://dlc-cdn.sun.com/virtualbox"
!define MSI ; Delete if setup not msi
!define 7ZA ; Delete if setup not 7za
!define APPSIZE	"223800" # kB
!define DLVER	"6.1.x"
!define APPNAME "VirtualBox"

!define APPVER 	"0.0.0.0"
!define APP 	"VirtualBox"
!define DLNAME	"VirtualBox"
!define APPLANG	"64-bit_Multilingual_Online"
!define FOLDER	"VirtualBoxPortable"
!define FINISHRUN ; Delete if not Finish pages
!define OPTIONS ; Delete if no Components
!define SOURCES ; Delete if no Sources
; !define DESCRIPTION	"Cross-platform virtualization" ; Delete if no AppInfo
!define INPUTBOX ; Delete if no InputBox

SetCompressor /SOLID lzma
SetCompressorDictSize 32

!include "..\_Include\Installer.nsh"
!include "LogicLib.nsh"
!include "x64.nsh"

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Bulgarian"
!insertmacro MUI_LANGUAGE "Catalan"
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Danish"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Greek"
!insertmacro MUI_LANGUAGE "SpanishInternational"
!insertmacro MUI_LANGUAGE "Basque"
!insertmacro MUI_LANGUAGE "Farsi"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "Hungarian"
!insertmacro MUI_LANGUAGE "Indonesian"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "PortugueseBR"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "Slovenian"
!insertmacro MUI_LANGUAGE "Turkish"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "TradChinese"

Var InputVer
Var VER
Var InputPackVer
Var PACKVER
Var MAINVER
Var SUBVER

Function nsDialogsPage
	nsDialogs::Create 1018
	Pop $0

	${NSD_CreateLabel} 0 0 100% 12u "Enter Version Number:"
	Pop $0
	${NSD_CreateText} 0 13u 100% 12u ""
	Pop $InputVer
	${NSD_CreateLabel} 0 50u 100% 12u "Enter Extension Pack Version Number:"
	Pop $0
	${NSD_CreateText} 0 63u 100% 12u ""
	Pop $InputPackVer

	nsDialogs::Show
FunctionEnd
Function nsDialogsPageLeave
	${NSD_GetText} $InputVer $R0
StrCmp $R0 "" 0 +3
	MessageBox MB_ICONEXCLAMATION `You must enter a version number!`
Abort
	StrCpy $VER "$R0" # 5.1.0-108711 5.2.0_BETA1-117406

StrCpy $MAINVER "$R0" -7 # 5.1.0
StrCpy $SUBVER "$R0" "" -6 # 108711

	${NSD_GetText} $InputPackVer $R0
	StrCpy $PACKVER "$R0"
FunctionEnd

Section "${APPNAME} Portable" main
SectionIn RO
DetailPrint "Installing ${APPNAME} Portable"

${If} ${FileExists} "$EXEDIR\VirtualBox-$VER-Win.exe"
ExecWait `"$EXEDIR\VirtualBox-$VER-Win.exe" --extract --silent --path "$TEMP\${APP}PortableTemp"`

${Else}

Call CheckConnected
	inetc::get "${RELEASURL}/$MAINVER/VirtualBox-$VER-Win.exe" "$TEMP\${APP}PortableTemp\VirtualBox-$VER-Win.exe" /END
	Pop $0
StrCmp $0 "OK" +3
	MessageBox MB_ICONEXCLAMATION "VirtualBox-$VER-Win.exe not found in $EXEDIR and download: $0"
	Abort
ExecWait `"$TEMP\${APP}PortableTemp\VirtualBox-$VER-Win.exe" --extract --silent --path "$TEMP\${APP}PortableTemp"`
${EndIf}

	SetOutPath "$INSTDIR"
		File "..\..\..\${FOLDER}\${APP}Portable.exe"
	SetOutPath "$INSTDIR\App\DefaultData\${APP}"
		File "${APP}.xml"

DetailPrint "Installing ${APPNAME} Portable"

	nsExec::Exec `"$SYSDIR\msiexec.exe" /a "$TEMP\${APP}PortableTemp\${APP}-$MAINVER-r$SUBVER.msi" TARGETDIR="$TEMP\${APP}PortableTemp\${APP}Setup" /qn`

	SetOutPath "$INSTDIR\App\${APP}"
	CopyFiles /SILENT "$TEMP\${APP}PortableTemp\${APP}Setup\PFiles\Oracle\VirtualBox\*.*" "$INSTDIR\App\${APP}"

!ifdef DESCRIPTION
Call AppInfo
!endif
!ifdef SOURCES
Call Sources
	SetOutPath "$INSTDIR\Other\Source"
	File "${APP}.xml"
!endif
!ifdef SOURCES & DESCRIPTION
Call SourceInfo
!endif

SectionEnd

Function .onGUIEnd
!ifdef DESCRIPTION
	Call AppInfo
!endif
!ifdef SOURCES
	Call Sources
!endif
!ifdef SOURCES & DESCRIPTION
	Call SourceInfo
!endif
!ifndef TEST
	RMDir "/r" "$TEMP\${APP}PortableTemp"
!endif
FunctionEnd


Section /o "${APPNAME} Extension Pack Portable" extpack
${If} ${FileExists} "$EXEDIR\Oracle_VM_VirtualBox_Extension_Pack-$PACKVER.vbox-extpack"
	nsExec::Exec `"$TEMP\${APP}PortableTemp\7za.exe" x "$EXEDIR\Oracle_VM_VirtualBox_Extension_Pack-$PACKVER.vbox-extpack" -aoa -o"$TEMP\${APP}PortableTemp\${APP}ExtUnPack"`
${Else}
	inetc::get "${RELEASURL}/$MAINVER/Oracle_VM_VirtualBox_Extension_Pack-$PACKVER.vbox-extpack" "$TEMP\${APP}PortableTemp\Oracle_VM_VirtualBox_Extension_Pack-$PACKVER.vbox-extpack" /END
	Pop $0
StrCmp $0 "OK" +3
	MessageBox MB_USERICON "Download of Oracle_VM_VirtualBox_Extension_Pack-$PACKVER.vbox-extpack: $0"
	Abort
	nsExec::Exec `"$TEMP\${APP}PortableTemp\7za.exe" x "$TEMP\${APP}PortableTemp\Oracle_VM_VirtualBox_Extension_Pack-$PACKVER.vbox-extpack" -aoa -o"$TEMP\${APP}PortableTemp\${APP}ExtUnPack"`
${EndIf}
	SetOutPath "$INSTDIR\App\${APP}\ExtensionPacks\Oracle_VM_VirtualBox_Extension_Pack"
	nsExec::Exec `"$TEMP\${APP}PortableTemp\7za.exe" x "$TEMP\${APP}PortableTemp\${APP}ExtUnPack\Oracle_VM_VirtualBox_Extension_Pack-$PACKVER" -aoa -o"$INSTDIR\App\${APP}\ExtensionPacks\Oracle_VM_VirtualBox_Extension_Pack"`

SectionEnd

Function Init
SectionSetSize ${extpack} 41027 # kB
FunctionEnd
