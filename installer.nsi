Unicode true
 
; headers
!include "MUI2.nsh" 
!include "x64.nsh" 
; define const

!define APP_NAME "APP_NAME"
!define APP_DIR "APP_DIR"
!define FILE_VERSION "1.0.0.0"
!define PRODUCT_VERSION "1.0.0.0"
!define MANUFACTURER "Trollonion03"
!define REG_APP_NAME "APP"
!define REG_HKLM_UNINST "Software\Microsoft\Windows\CurrentVersion\Uninstall"
 
; metadata

Name "${APP_NAME}"

OutFile "Installer_${PRODUCT_VERSION}.exe"

InstallDir "$PROGRAMFILES32\${APP_DIR}"

#XPStyle ons

#SetCompressor zlib

ShowInstDetails show
 
 
; file descriptions

VIProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey "FileVersion" "${PRODUCT_VERSION}"
VIAddVersionKey "ProductVersion" "${PRODUCT_VERSION}"
VIAddVersionKey "ProductName" "${APP_NAME}"
VIAddVersionKey "CompanyName" "${MANUFACTURER}"
VIAddVersionKey "FileDescription" "NSIS ????"
VIAddVersionKey "LegalCopyright" "${MANUFACTURER}"
 
; MUI config

!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\nsis3-install-alt.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\nsis3-uninstall.ico"
!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\nsis3-metro.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "${NSISDIR}\Contrib\Graphics\Header\nsis3-metro-right.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\nsis3-metro.bmp"
!define MUI_WELCOMEFINISHPAGE_UNBITMAP "${NSISDIR}\Contrib\Graphics\Wizard\nsis3-grey.bmp"
 
; inst pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
 
; uninst pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH
 
!insertmacro MUI_LANGUAGE "Korean"
 
Section "main"

SetOutPath "$INSTDIR"

File /r "${APP_DIR}"

${DisableX64FSRedirection}
${EnableX64FSRedirection}

SectionEnd

Section "-post"

DetailPrint "register uninstall information"

WriteUninstaller "${APP_DIR}\uninstall.exe"

SetShellVarContext all 
CreateDirectory $SMPROGRAMS\LGE_MOTORCM
SetOutPath "$INSTDIR\${APP_DIR}"
CreateShortCut "$SMPROGRAMS\${APP_NAME}_UNINSTALL.lnk" "$INSTDIR\${APP_DIR}\uninstall.exe"
SetOutPath "$INSTDIR\${APP_DIR}"
CreateShortCut "$SMPROGRAMS\${APP_NAME}.lnk" "$INSTDIR\${APP_DIR}\KAL.exe"

${DisableX64FSRedirection}
; windows scripts here
${EnableX64FSRedirection}


WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "DisplayName" "${APP_NAME}"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "DisplayIcon" "$INSTDIR\${APP_DIR}\uninstall.exe"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "DisplayVersion" "${PRODUCT_VERSION}"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "InstallLocation" "$INSTDIR"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "Publisher" "${MANUFACTURER}"
WriteRegStr HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}" "UninstallString" "$INSTDIR\${APP_DIR}\uninstall.exe"
SectionEnd
 

Section Uninstall
SectionIn RO
RMDir /r "$INSTDIR\*"
RMDir "$INSTDIR"
SetShellVarContext all
RMDir /r "$STARTMENU\${APP_NAME}"
Delete "$SMPROGRAMS\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\${APP_NAME}_UNINSTALL.lnk"
DeleteRegKey HKLM "${REG_HKLM_UNINST}\${REG_APP_NAME}"
SectionEnd