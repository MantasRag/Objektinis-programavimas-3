!include "MUI2.nsh"

;--------------------------------
; Konstantos
!define PRODUCT_NAME "Studentai v3.0"
!define INSTALL_DIR "VU\Mantas-Ragaisis"

;--------------------------------
; Pagrindiniai nustatymai
Name "${PRODUCT_NAME}"
OutFile "Studentai_v3_Setup.exe"
InstallDir "$PROGRAMFILES64\${INSTALL_DIR}"
RequestExecutionLevel admin

;--------------------------------
; Diegimo puslapiai
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Isdiegimo puslapiai
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Kalbos
!insertmacro MUI_LANGUAGE "English"

;--------------------------------
Section "Main"
  SetOutPath "$INSTDIR"
  File "build\Studentai_v3.exe"   ; pagrindinis failas

  ; Sukurti nuorodas su Run as administrator
  CreateDirectory "$SMPROGRAMS\VU\Mantas-Ragaisis"
  CreateShortCut "$DESKTOP\Studentai v3.0.lnk" "$INSTDIR\Studentai_v3.exe" "" "" 1
  CreateShortCut "$SMPROGRAMS\VU\Mantas-Ragaisis\Studentai v3.0.lnk" "$INSTDIR\Studentai_v3.exe" "" "" 1

  ; Isdiegimo programa
  WriteUninstaller "$INSTDIR\uninst.exe"

  ; Registracija Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\Studentai_v3.exe" "" "$INSTDIR\Studentai_v3.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Studentai v3.0" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Studentai v3.0" "UninstallString" "$INSTDIR\uninst.exe"
SectionEnd

;--------------------------------
Section "Uninstall"
  ; Istrinti visus failus aplanke
  Delete "$INSTDIR\*.*"
  Delete "$SMPROGRAMS\VU\Mantas-Ragaisis\*.*"

  ; Istrinti nuorodas
  Delete "$DESKTOP\Studentai v3.0.lnk"
  Delete "$SMPROGRAMS\VU\Mantas-Ragaisis\Studentai v3.0.lnk"

  ; Istrinti katalogus rekursyviai
  RMDir /r "$INSTDIR"
  RMDir /r "$SMPROGRAMS\VU\Mantas-Ragaisis"
  RMDir /r "$SMPROGRAMS\VU"

  ; Istrinti registrus
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Studentai v3.0"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\Studentai_v3.exe"
SectionEnd
