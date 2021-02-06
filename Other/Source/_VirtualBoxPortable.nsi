; NSIS with Registry.nsh in Include and Registry.dll, FindProcDLL.dll, KillProcDLL.dll and SimpleSC.dll in Plugins
; **************************************************************************
; === Define constants ===
; **************************************************************************
!define VER 		"0.0.0.0"	; version of launcher
!define APPNAME 	"VirtualBox"	; complete name of program
!define APP 		"VirtualBox"	; short name of program without space and accent  this one is used for the final executable an in the directory structure
!define APPEXE 		"VirtualBox.exe"	; main exe name
!define APPDIR 		"App\VirtualBox"	; main exe relative path
!define APPSWITCH 	``	; some default Parameters

; --- Define RegKeys ---
	!define REGKEY1 "HKEY_CURRENT_USER\Software\Oracle"
	!define REGKEY2 "HKEY_CURRENT_USER\Software\QtProject"
	!define REGKEY3 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\TypeLib\{d7569351-1750-46f0-936e-bd127d5bc264}"
	!define REGKEY4 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\VirtualBox.Session"
	!define REGKEY5 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\VirtualBox.Session.1"
	!define REGKEY6 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\VirtualBox.VirtualBox"
	!define REGKEY7 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\VirtualBox.VirtualBox.1"
	!define REGKEY8 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\VirtualBox.VirtualBoxClient"
	!define REGKEY9 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\VirtualBox.VirtualBoxClient.1"
	!define REGKEY10 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AppID\{819B4D85-9CEE-493C-B6FC-64FFE759B3C9}"
	!define REGKEY11 "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU\vbox"
	!define REGKEY12 "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbox"
	!define REGKEY13 "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.vbox"
	; 64-bit keys
	!define REGKEY14 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{0bb3b78c-1807-4249-5ba5-ea42d66af0bf}"
	!define REGKEY15 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{3c02f46d-c9d2-4f11-a384-53f0cf917214}"
	!define REGKEY16 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{b1a7a4f2-47b9-4a1e-82b2-07ccd5323c3f}"
	!define REGKEY17 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{dd3fc71d-26c0-4fe1-bf6f-67f633265bba}"
	!define REGKEY18 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Interface\{0169423f-46b4-cde9-91af-1e9d5b6cd945}"
	!define REGKEY19 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Interface\{97c78fcd-d4fc-485f-8613-5af88bfcfcdc}"
	!define REGKEY20 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Interface\{c1bcc6d5-7966-481d-ab0b-d0ed73e28135}"
	!define REGKEY21 "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Interface\{d2937a8e-cb8d-4382-90ba-b7da78a74573}"

; --- Define System Files ---
	!define LOCALSYSTEMFILE1 "$SYSDIR\msvcp100.dll"
	!define LOCALSYSTEMFILE2 "$SYSDIR\msvcr100.dll"
	!define PORTABLESYSTEMFILE1 "$EXEDIR\${APPDIR}\msvcp100.dll"
	!define PORTABLESYSTEMFILE2 "$EXEDIR\${APPDIR}\msvcr100.dll"

; --- Define install path relative to Program Files (used down) ---
!define LOCALDIR "Oracle\VirtualBox"
; --- Define RegServer Shared DLLs ---
	!define LOCALDLL1 "$PROGRAMFILES\${LOCALDIR}\VBoxC.dll"
	!define PORTABLEDLL1 "$EXEDIR\${APPDIR}\VBoxC.dll"
	!define LOCALDLL2 "$SYSDIR\VBoxNetFltNobj.dll"
	!define PORTABLEDLL2 "$EXEDIR\${APPDIR}\drivers\network\netflt\VBoxNetFltNobj.dll"

; --- Define Services ---
	!define SRC1 "VBoxDrv"
	!define SRCNAME1 "VirtualBox Service"
	!define LOCALSRC1 "$SYSDIR\DRIVERS\VBoxDrv.sys"
	!define PORTABLESRC1 "$EXEDIR\${APPDIR}\drivers\vboxdrv\VBoxDrv.sys"
	!define STARTSRC1 "2"
	!define TYPESRC1 "1"

	!define SRC2 "VBoxNetAdp"
	!define SRCNAME2 "VirtualBox Host-Only Ethernet Adapter"
	!define LOCALSRC2 "$SYSDIR\DRIVERS\VBoxNetAdp.sys"
	!define PORTABLESRC2 "$EXEDIR\${APPDIR}\drivers\network\netadp\VBoxNetAdp.sys"
	!define STARTSRC2 "3"
	!define TYPESRC2 "1"

	!define SRC3 "VBoxNetFlt"
	!define SRCNAME3 "VirtualBox Bridged Networking Service"
	!define LOCALSRC3 "$SYSDIR\DRIVERS\VBoxNetFlt.sys"
	!define PORTABLESRC3 "$EXEDIR\${APPDIR}\drivers\network\netflt\VBoxNetFlt.sys"
	!define STARTSRC3 "3"
	!define TYPESRC3 "1"

	!define SRC4 "VBoxUSBMon"
	!define SRCNAME4 "VirtualBox USB Monitor Driver"
	!define LOCALSRC4 "$SYSDIR\DRIVERS\VBoxUSBMon.sys"
	!define PORTABLESRC4 "$EXEDIR\${APPDIR}\drivers\USB\filter\VBoxUSBMon.sys"
	!define STARTSRC4 "2"
	!define TYPESRC4 "1"

; **************************************************************************
; === Best Compression ===
; **************************************************************************
SetCompressor /SOLID lzma
SetCompressorDictSize 32

; **************************************************************************
; === Includes ===
; **************************************************************************
!include "..\_Include\Launcher.nsh" 
!include "LogicLib.nsh"
!include "x64.nsh"
!include "TextReplace.nsh"

; **************************************************************************
; === Set basic information ===
; **************************************************************************
Name "${APPNAME} Portable"
OutFile "..\..\..\${APP}Portable\${APP}Portable.exe"
Icon "${APP}.ico"
RequestExecutionLevel admin

; **************************************************************************
; === Other Actions ===
; **************************************************************************
Function Init
CreateDirectory "$EXEDIR\Data"
IfFileExists "$EXEDIR\Data\${APP}\${APP}.xml" +4
WriteINIStr "$EXEDIR\Data\${APP}Portable.ini" "${APP}Portable" "LastDirectory" "X:\"
CreateDirectory "$EXEDIR\Data\${APP}"
CopyFiles "$EXEDIR\App\DefaultData\${APP}\${APP}.xml" "$EXEDIR\Data\${APP}\${APP}.xml"
ReadINIStr $0 "$EXEDIR\Data\${APP}Portable.ini" "${APP}Portable" "LastDirectory"
StrCpy $1 $0 3
StrCpy $2 $EXEDIR 3
StrCmp $1 $2 +3
	${textreplace::ReplaceInFile} "$EXEDIR\Data\${APP}\${APP}.xml" "$EXEDIR\Data\${APP}\${APP}.xml" "$1" "$2" "" $0
	${textreplace::Unload}

	System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("VBOX_USER_HOME", "$EXEDIR\Data\${APP}").r0'

FunctionEnd

Function Close
		System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("VBOX_USER_HOME", 0).r0'

FunctionEnd

; **************************************************************************
; ==== Running ====
; **************************************************************************

Section "Main"

	; Call CheckRegWrite
	Call CheckRunExe
	Call CheckGoodExit

	CreateDirectory "$EXEDIR\Data"
; ${If} ${RunningX64}
; ${AndIf} ${FileExists} "$EXEDIR\${APPDIR}_amd64\${APPEXE}"
	; SetRegView 64
	; WriteINIStr "$EXEDIR\Data\${APP}Portable.ini" "${APP}Portable" "Run" "amd64"
	; Rename "$EXEDIR\${APPDIR}_amd64" "$EXEDIR\${APPDIR}"
; ${Else}
	; WriteINIStr "$EXEDIR\Data\${APP}Portable.ini" "${APP}Portable" "Run" "x86"
	; Rename "$EXEDIR\${APPDIR}_x86" "$EXEDIR\${APPDIR}"
; ${EndIf}

; Rename "$EXEDIR\${APPDIR}_common\doc" "$EXEDIR\${APPDIR}\doc"
; Rename "$EXEDIR\${APPDIR}_common\nls" "$EXEDIR\${APPDIR}\nls"
; Rename "$EXEDIR\${APPDIR}_common\sdk" "$EXEDIR\${APPDIR}\sdk"
; Rename "$EXEDIR\${APPDIR}_common\ExtensionPacks" "$EXEDIR\${APPDIR}\ExtensionPacks"
; Rename "$EXEDIR\${APPDIR}_common\License_en_US.rtf" "$EXEDIR\${APPDIR}\License_en_US.rtf"
; Rename "$EXEDIR\${APPDIR}_common\VBoxEFI32.fd" "$EXEDIR\${APPDIR}\VBoxEFI32.fd"
; Rename "$EXEDIR\${APPDIR}_common\VBoxEFI64.fd" "$EXEDIR\${APPDIR}\VBoxEFI64.fd"
; Rename "$EXEDIR\${APPDIR}_common\VBoxGuestAdditions.iso" "$EXEDIR\${APPDIR}\VBoxGuestAdditions.iso"
; Rename "$EXEDIR\${APPDIR}_common\VirtualBox.chm" "$EXEDIR\${APPDIR}\VirtualBox.chm"

	Call BackupLocalKeys
	Call RestorePortableKeys

	Call RestorePortableFiles

	Call UnRegLocalDLL
	Call RegPortableDLL

	Call DelLocalSrc
	Call CreatePortableSrc

	Call Init

		Call SplashLogo
		Call Launch

	Call Restore

SectionEnd

Function Restore

	Call Close

		Sleep 250
	FindProcDLL::FindProc "VBoxSVC.exe"
		Pop $R0
		StrCmp $R0 "1" -3 +1

	Call DelPortableSrc
	Call CreateLocalSrc

	Call UnRegPortableDLL
	Call RegLocalDLL

	Call RestoreLocalFiles

	Call BackupPortableKeys
	Call RestoreLocalKeys

; Rename "$EXEDIR\${APPDIR}\doc" "$EXEDIR\${APPDIR}_common\doc"
; Rename "$EXEDIR\${APPDIR}\nls" "$EXEDIR\${APPDIR}_common\nls"
; Rename "$EXEDIR\${APPDIR}\sdk" "$EXEDIR\${APPDIR}_common\sdk"
; Rename "$EXEDIR\${APPDIR}\ExtensionPacks" "$EXEDIR\${APPDIR}_common\ExtensionPacks"
; Rename "$EXEDIR\${APPDIR}\License_en_US.rtf" "$EXEDIR\${APPDIR}_common\License_en_US.rtf"
; Rename "$EXEDIR\${APPDIR}\VBoxEFI32.fd" "$EXEDIR\${APPDIR}_common\VBoxEFI32.fd"
; Rename "$EXEDIR\${APPDIR}\VBoxEFI64.fd" "$EXEDIR\${APPDIR}_common\VBoxEFI64.fd"
; Rename "$EXEDIR\${APPDIR}\VBoxGuestAdditions.iso" "$EXEDIR\${APPDIR}_common\VBoxGuestAdditions.iso"
; Rename "$EXEDIR\${APPDIR}\VirtualBox.chm" "$EXEDIR\${APPDIR}_common\VirtualBox.chm"

; ReadINIStr $0 "$EXEDIR\Data\${APP}Portable.ini" "${APP}Portable" "Run"
; ${If} $0 == 'x86'
; Rename "$EXEDIR\${APPDIR}" "$EXEDIR\${APPDIR}_x86"
; ${ElseIf} $0 == 'amd64'
; Rename "$EXEDIR\${APPDIR}" "$EXEDIR\${APPDIR}_amd64"
; ${Else}
; ${EndIf}
; DeleteINIStr "$EXEDIR\Data\${APP}Portable.ini" "${APP}Portable" "Run"

FunctionEnd

; **************************************************************************
; === Run Application ===
; **************************************************************************
Function Launch
${GetParameters} $0
ExecWait `"$EXEDIR\${APPDIR}\${APPEXE}"${APPSWITCH} $0`
	FindProcDLL::FindProc "${APPEXE}"
		Pop $R0
		Sleep 250
		StrCmp $R0 "1" -3 +1
	FindProcDLL::FindProc "VBoxManage.exe"
		Pop $R0
		Sleep 250
		StrCmp $R0 "1" -3 +1

WriteINIStr "$EXEDIR\Data\${APP}Portable.ini" "${APP}Portable" "GoodExit" "true"
newadvsplash::stop
FunctionEnd

; **************************************************************************
; ==== Actions on Registry Keys =====
; **************************************************************************
Function BackupLocalKeys
	${registry::BackupKey} "${REGKEY1}"
	${registry::BackupKey} "${REGKEY2}"
	${registry::BackupKey} "${REGKEY3}"
	${registry::BackupKey} "${REGKEY4}"
	${registry::BackupKey} "${REGKEY5}"
	${registry::BackupKey} "${REGKEY6}"
	${registry::BackupKey} "${REGKEY7}"
	${registry::BackupKey} "${REGKEY8}"
	${registry::BackupKey} "${REGKEY9}"
	${registry::BackupKey} "${REGKEY10}"
	${registry::BackupKey} "${REGKEY11}"
	${registry::BackupKey} "${REGKEY12}"
	${registry::BackupKey} "${REGKEY13}"
	${registry::BackupKey} "${REGKEY14}"
	${registry::BackupKey} "${REGKEY15}"
	${registry::BackupKey} "${REGKEY16}"
	${registry::BackupKey} "${REGKEY17}"
	${registry::BackupKey} "${REGKEY18}"
	${registry::BackupKey} "${REGKEY19}"
	${registry::BackupKey} "${REGKEY20}"
	${registry::BackupKey} "${REGKEY21}"
FunctionEnd

Function RestorePortableKeys
${registry::RestoreKey} "$EXEDIR\Data\${APP}.reg" $R0
Sleep 200
${registry::Unload}
FunctionEnd

Function BackupPortableKeys
Delete "$EXEDIR\Data\${APP}.reg"
CreateDirectory "$EXEDIR\Data"
	${registry::SaveKey} "${REGKEY1}" "$EXEDIR\Data\${APP}.reg" "/A=1" $R0
Sleep 100
FunctionEnd

Function RestoreLocalKeys
	${registry::RestoreBackupKey} "${REGKEY1}"
	${registry::RestoreBackupKey} "${REGKEY2}"
	${registry::RestoreBackupKey} "${REGKEY3}"
	${registry::RestoreBackupKey} "${REGKEY4}"
	${registry::RestoreBackupKey} "${REGKEY5}"
	${registry::RestoreBackupKey} "${REGKEY6}"
	${registry::RestoreBackupKey} "${REGKEY7}"
	${registry::RestoreBackupKey} "${REGKEY8}"
	${registry::RestoreBackupKey} "${REGKEY9}"
	${registry::RestoreBackupKey} "${REGKEY10}"
	${registry::RestoreBackupKey} "${REGKEY11}"
	${registry::RestoreBackupKey} "${REGKEY12}"
	${registry::RestoreBackupKey} "${REGKEY13}"
	${registry::RestoreBackupKey} "${REGKEY14}"
	${registry::RestoreBackupKey} "${REGKEY15}"
	${registry::RestoreBackupKey} "${REGKEY16}"
	${registry::RestoreBackupKey} "${REGKEY17}"
	${registry::RestoreBackupKey} "${REGKEY18}"
	${registry::RestoreBackupKey} "${REGKEY19}"
	${registry::RestoreBackupKey} "${REGKEY20}"
	${registry::RestoreBackupKey} "${REGKEY21}"
${registry::Unload}
FunctionEnd

; **************************************************************************
; ====Actions on Files =====
; **************************************************************************
Function RestorePortableFiles

	${file::CopyLocal} "${PORTABLESYSTEMFILE1}" "${LOCALSYSTEMFILE1}"
	${file::CopyLocal} "${PORTABLESYSTEMFILE2}" "${LOCALSYSTEMFILE2}"
FunctionEnd

Function RestoreLocalFiles
	${file::DelLocal} "${LOCALSYSTEMFILE1}"
	${file::DelLocal} "${LOCALSYSTEMFILE2}"
FunctionEnd

; ************************************************************************
; ==== Actions on DLLs ====
; ************************************************************************
Function UnRegLocalDLL
	${dll::UnRegLocal} "${LOCALDLL1}"
	${dll::UnRegLocal} "${LOCALDLL2}"
FunctionEnd

Function RegPortableDLL
ExecWait `"$EXEDIR\${APPDIR}\VBoxSVC.exe" /ReRegServer`
ExecWait `"$SYSDIR\regsvr32.exe" /S "${PORTABLEDLL1}"`
	${dll::RegPortable} "${PORTABLEDLL2}"
FunctionEnd

Function UnRegPortableDLL
ExecWait `"$EXEDIR\${APPDIR}\VBoxSVC.exe" /UnRegServer`
	${dll::UnRegPortable} "${PORTABLEDLL1}"
	${dll::UnRegPortable} "${PORTABLEDLL2}"
FunctionEnd

Function RegLocalDLL
	${dll::RegLocal} "${LOCALDLL1}"
	${dll::RegLocal} "${LOCALDLL2}"
FunctionEnd

; **************************************************************************
; ==== Actions on Services ====
; **************************************************************************
Function DelLocalSrc
	${src::DelLocal} "${SRC1}" "${LOCALSRC1}"
	${src::DelLocal} "${SRC2}" "${LOCALSRC2}"
	${src::DelLocal} "${SRC3}" "${LOCALSRC3}"
	${src::DelLocal} "${SRC4}" "${LOCALSRC4}"
FunctionEnd

Function CreatePortableSrc
	${src::CreatePortable} "${SRC1}" "${SRCNAME1}" "${TYPESRC1}" "${STARTSRC1}" "${PORTABLESRC1}"
	${src::CreatePortable} "${SRC2}" "${SRCNAME2}" "${TYPESRC2}" "${STARTSRC2}" "${PORTABLESRC2}"
	${src::CreatePortable} "${SRC3}" "${SRCNAME3}" "${TYPESRC3}" "${STARTSRC3}" "${PORTABLESRC3}"
	${src::CreatePortable} "${SRC4}" "${SRCNAME4}" "${TYPESRC4}" "${STARTSRC4}" "${PORTABLESRC4}"
FunctionEnd

Function DelPortableSrc
	${src::DelPortable} "${SRC1}"
	${src::DelPortable} "${SRC2}"
	${src::DelPortable} "${SRC3}"
	${src::DelPortable} "${SRC4}"
FunctionEnd

Function CreateLocalSrc
	${src::CreateLocal} "${SRC1}" "${SRCNAME1}" "${TYPESRC1}" "${STARTSRC1}" "${LOCALSRC1}"
	${src::CreateLocal} "${SRC2}" "${SRCNAME2}" "${TYPESRC2}" "${STARTSRC2}" "${LOCALSRC2}"
	${src::CreateLocal} "${SRC3}" "${SRCNAME3}" "${TYPESRC3}" "${STARTSRC3}" "${LOCALSRC3}"
	${src::CreateLocal} "${SRC4}" "${SRCNAME4}" "${TYPESRC4}" "${STARTSRC4}" "${LOCALSRC4}"
FunctionEnd
