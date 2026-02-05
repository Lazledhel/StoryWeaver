!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "x64.nsh"

; =========================
; Config
; =========================
!define APP_NAME     "StoryWeaver"
!define APP_VERSION  "3.2.1"
!define COMPANY      "StoryWeaver"

!define EXE_NAME     "StoryWeaverLauncher.exe"
!define UPDATER_NAME "updater.exe"

; Папка, где лежит готовая сборка (exe + _internal + editor)
; Путь относительно папки, где лежит этот setup.nsi
!define SOURCE_DIR   "..\dist"

; =========================
; UI (Modern)
; =========================
Unicode True
SetCompressor /SOLID lzma
!define MUI_ABORTWARNING

!define MUI_ICON "..\\storyweaver.ico"
!define MUI_UNICON "..\\storyweaver.ico"

Name "${APP_NAME}"
OutFile "${APP_NAME}_Setup_${APP_VERSION}.exe"

; Персональная установка без админ-прав (самый безболезненный вариант)
InstallDir "$LOCALAPPDATA\${APP_NAME}"
InstallDirRegKey HKCU "Software\${COMPANY}\${APP_NAME}" "InstallDir"
RequestExecutionLevel user

; ----- Pages -----
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "Russian"

; =========================
; Install
; =========================
Section "Основные файлы" SEC_MAIN
  SetOutPath "$INSTDIR"

  ; Сохраним путь установки
  WriteRegStr HKCU "Software\${COMPANY}\${APP_NAME}" "InstallDir" "$INSTDIR"

  ; --- Корневые exe ---
  File /oname=${EXE_NAME}     "${SOURCE_DIR}\${EXE_NAME}"
  File /oname=${UPDATER_NAME} "${SOURCE_DIR}\${UPDATER_NAME}"

  ; --- _internal ---
  CreateDirectory "$INSTDIR\_internal"
  SetOutPath "$INSTDIR\_internal"
  File /r "${SOURCE_DIR}\_internal\*.*"

  ; --- editor ---
  CreateDirectory "$INSTDIR\editor"
  SetOutPath "$INSTDIR\editor"
  File /r "${SOURCE_DIR}\editor\*.*"

  ; --- Start Menu shortcut ---
  CreateDirectory "$SMPROGRAMS\${APP_NAME}"
  CreateShortCut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${EXE_NAME}" "" "$INSTDIR\${EXE_NAME}" 0

  ; --- Uninstaller ---
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Publisher" "${COMPANY}"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
SectionEnd

; Опционально: ярлык на рабочем столе (можно снять галочку на Components)
Section /o "Ярлык на рабочем столе" SEC_DESKTOP
  CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${EXE_NAME}" "" "$INSTDIR\${EXE_NAME}" 0
SectionEnd

; =========================
; Uninstall
; =========================
Section "Uninstall"
  ; shortcuts
  Delete "$DESKTOP\${APP_NAME}.lnk"
  Delete "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk"
  RMDir /r "$SMPROGRAMS\${APP_NAME}"

  ; files
  RMDir /r "$INSTDIR\editor"
  RMDir /r "$INSTDIR\_internal"
  Delete "$INSTDIR\${EXE_NAME}"
  Delete "$INSTDIR\${UPDATER_NAME}"
  Delete "$INSTDIR\Uninstall.exe"

  ; try remove install dir
  RMDir "$INSTDIR"

  ; registry
  DeleteRegKey HKCU "Software\${COMPANY}\${APP_NAME}"
  DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
SectionEnd
