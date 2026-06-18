;Erstellt by Rndl :)
;F10 Starten / F11 Stoppen
;Sollten probleme auftauchen gerne im DC melden :) - spontaneboost -
;!Änder auf keinen fall irgendwelche Timings Werte oder Namen hier das macht das ganze script kaputt!
;Achtet auf die Dateinamen.

#Requires AutoHotkey v2.0
SendMode "Input"
SetWorkingDir A_ScriptDir

; ==========================================
; UPDATE-KONFIGURATION (AHK v2 kompatibel)
; ==========================================
global CurrentVersion := "0.0.1"
global User := "Helloworldsads"
global Repo := "FH6AHK"

; URLs zu den rohen Dateien auf GitHub
global VersionURL := "https://raw.githubusercontent.com/" . User . "/" . Repo . "/main/version.txt"
global DownloadURL := "https://raw.githubusercontent.com/" . User . "/" . Repo . "/main/FH6AHK.ahk" 

; Automatische Update-Prüfung direkt beim Start ausführen
CheckForUpdates()
; ==========================================

; Setze den Fenstertitel für das Spiel. 
global GameTitle := "ahk_exe ForzaHorizon6.exe" 
global Running := false

; --- START-NACHRICHT ---
Sleep(2000)
ToolTip("SKRIPT AB JETZT AKTIVIERBAR MIT F10! (Ich verschwinde gleich)") ; sofern nicht voher schon F10 Gedrückt wurde Zeigt Text am Mauszeiger
SetTimer(() => ToolTip(), -8000) ; Hinweis kurz sichtbar halten
; -----------------------


; F10 Startet den Ablauf
F10:: {
    global Running
    
    if (Running) {
        MsgBox("Skript läuft bereits!")
        return
    }
    
    Running := true
    MsgBox("Endlos-Ablauf gestartet. Drücke F11 zum Beenden oder Bestätige mit 'OK' und Lass mich machen! Have a nice Race! :)")
    
    ; Wartet nach dem Klick auf "OK" genau 3 Sekunden
    Sleep(3000) 
    
    while (Running) {
        
        ; --- STEP 1-3 ---
        SendeTaste("{Esc}")
        Sleep(1000)
        
        if KlickeAufBild("menue_online.png") {
            Sleep(500)
        } else {
            MsgBox("Fehler: 'menue_online' wurde nicht gefunden!")
            Running := false
            break
        }
        
        if KlickeAufBild("kachel_rivalen.png") {
            SendeTaste("{Enter}")
            Sleep(800)
        } else {
            MsgBox("Fehler: 'kachel_rivalen.png' wurde nicht gefunden!")
            Running := false
            break
        }
        
        if KlickeAufBild("horizon_rivalen.png") {
            Sleep(800)
        } else {
            MsgBox("Fehler: 'horizon_rivalen.png' wurde nicht gefunden!")
            Running := false
            break
        }
        
        if KlickeAufBild("strecken_rennen.png") {
            Sleep(800)
        } else {
            MsgBox("Fehler: 'strecken_rennen.png' wurde nicht gefunden!")
            Running := false
            break
        }
        
        ; --- Ab HIER Könnte es Buggen ---
        Sleep(800)
        SendeTaste("a")       
        Sleep(400)
        SendeTaste("a")       
        Sleep(800)      
        SendeTaste("{Enter}") 
        Sleep(800)     
        SendeTaste("d")       
        Sleep(400)
        SendeTaste("d")       
        Sleep(400)
        
        if KlickeAufBild("r_class.png") {
            Sleep(800)
        } else {
            MsgBox("Fehler: 'r_class.png' wurde nicht gefunden!")
            Running := false
            break
        }
        Sleep(800)
        
        ; --- STEP 5 (Jetzt mit Warteschleife) ---
        ToolTip("Suche Bestenliste... Ja wo isse denn?")
        SetTimer(() => ToolTip(), -3000)

        while (!WarteAufBild("bestenliste_knopf.png") && Running) {
            Sleep(200)
        }

        if (!Running) {
            break
        }
        
        if KlickeAufBild("bestenliste_knopf.png") {
            ToolTip("Ah Rivale wechseln gefunden! (Ich verschwinde gleich)") 
            SetTimer(() => ToolTip(), -2000) 
            Sleep(800)
        } else {
            MsgBox("Fehler: 'bestenliste_knopf.png' wurde nicht gefunden! Passiert geh einfach zum Freeroam und drück erneut F10!")
            Running := false
            break
        }
        
        ; --- STEP 5.2 ---
        SendeTaste("{Enter}")
        Sleep(1500)     
        
        ; --- STEP 6 ---
        SendeTaste("{Enter}") 
        Sleep(4000)
        
        SendeTaste("{Enter}") 
        Sleep(1000)
        SendeTaste("{Enter}") 
        Sleep(400)
        SendeTaste("{Enter}")
        Sleep(400) 
        SendeTaste("{Enter}")
        Sleep(400)
        SendeTaste("{Enter}") 
        Sleep(400)
        SendeTaste("{Enter}")
        Sleep(400) 
        SendeTaste("{Enter}") 
        
        ; --- WARTEN AUF RENNSTART ---
        while (!WarteAufBild("rennen_starten.png") && Running) {
            Sleep(500)
        }
        if (!Running) {
            break 
        }
        
        SendeTaste("{Enter}")
        Sleep(2000) 
        
        ; --- WARTEN AUF RUNDE 2 ---
        ToolTip("Runde 2 läuft -Ich Warte Ca 5 min und schau nochmal ob du Fertig bist :)")
        SetTimer(() => ToolTip(), -3000)
        Sleep(310000) 
        ToolTip("Lass mal sehen bist Du durch?")
        SetTimer(() => ToolTip(), -1000)
        Sleep(1000)
        while (!WarteAufBild("2_runden.png") && Running) {
            ToolTip("Hallo Ziel ?!?")
            SetTimer(() => ToolTip(), -2000)    
            Sleep(1000)
        }

        if (!Running) {
            break
        }

        ToolTip("Runde 2 erkannt")
        SetTimer(() => ToolTip(), -1000)
        
        ; In Runde 2 angekommen
        Sleep(1000) 
        SendeTaste("{Esc}")
        Sleep(1000)        
        SendeTaste("d")       
        Sleep(400)
        SendeTaste("{Enter}")
        
        if (!Running) {
            break
        }
        
        Sleep(1000)
        SendeTaste("{Enter}")
        Sleep(500)
        SendeTaste("{Enter}")
        
        
        ToolTip("Schaue ob du ein Tuning angewendet hast...")
        SetTimer(() => ToolTip(), -2000) 

        
        StartZeit := A_TickCount
        
        while ((A_TickCount - StartZeit) < 7000 && Running) {
            if KlickeAufBild("abbrechen.png") {
                ToolTip("Tuning Bewertung Abbrechen (Geklickt)")
                SetTimer(() => ToolTip(), -2000)    
                Sleep(500) ; Kurze Pause nach dem Klick
                SendeTaste("{Enter}") ; Bestätigungs-Enter hinterher
                break
            }
            Sleep(200)
        
            Sleep(1000)
            SendeTaste("{Enter}")
            Sleep(500)
            SendeTaste("{Enter}") 
        }
        
        ; --- SICHERHEITS-CHECK FÜR NEUSTART 
        while (!WarteAufBild("restart.png") && Running) {
            ToolTip("Suche nach Anna")
            SetTimer(() => ToolTip(), -2000)
            Sleep(500) 
        }
        
        if (!Running) {
            break
        }
    
        ToolTip("Anna Erkannt Fange neu an")
        SetTimer(() => ToolTip(), -1000)
    }
}

; F11 drücken zum Beenden
F11:: {
    global Running
    Running := false
    MsgBox("Skript gestoppt und beendet. Danke für's Nutzen.")
    ExitApp()
}

; --- Hilfsfunktion für den Spielfokus ---
FokusiereSpiel() {
    global GameTitle, Running
    if (!Running)
        return false
        
    if !WinActive(GameTitle) {
        if WinExist(GameTitle) {
            WinActivate(GameTitle)
            WinWaitActive(GameTitle, , 5) 
            Sleep(500) 
        } else {
            return false
        }
    }
    return true
}

; --- Hilfsfunktion für sichere Tastendrücke mit Fokus-Check ---
SendeTaste(Taste) {
    if FokusiereSpiel() {
        Send(Taste)
    }
}

; --- Fensterbasierte Bildschirmerkennung mit Alternativbild-Support ---
KlickeAufBild(Dateiname, AlternativDatei := "") {
    if !FokusiereSpiel()
        return false

    if WinExist(GameTitle) {
        WinGetPos(,, &WinWidth, &WinHeight, GameTitle)
        
        ; 1. Versuch: Standardbild
        OptionenUndDatei := "*100 " . Dateiname
        if ImageSearch(&FoundX, &FoundY, 0, 0, WinWidth, WinHeight, OptionenUndDatei) {
            KlickAblauf(FoundX, FoundY)
            return true
        }
        
        ; 2. Versuch: Alternativbild (Nacht), falls angegeben
        if (AlternativDatei != "") {
            OptionenUndAlternativ := "*100 " . AlternativDatei
            if ImageSearch(&FoundX, &FoundY, 0, 0, WinWidth, WinHeight, OptionenUndAlternativ) {
                return true
            }
        }
    }
    return false
}

WarteAufBild(Dateiname, AlternativDatei := "") {
    if !FokusiereSpiel()
        return false

    if WinExist(GameTitle) {
        WinGetPos(,, &WinWidth, &WinHeight, GameTitle)
        
        ; Prüfe erstes Bild
        OptionenUndDatei := "*100 " . Dateiname
        if ImageSearch(&FoundX, &FoundY, 0, 0, WinWidth, WinHeight, OptionenUndDatei) {
            return true
        }
        
        ; Prüfe Alternativbild
        if (AlternativDatei != "") {
            OptionenUndAlternativ := "*100 " . AlternativDatei
            if ImageSearch(&FoundX, &FoundY, 0, 0, WinWidth, WinHeight, OptionenUndAlternativ) {
                return true
            }
        }
    }
    return false
}

; Interne Hilfsfunktion für den Klickablauf
KlickAblauf(X, Y) {
    ZielX := X + 50
    ZielY := Y + 20
    MouseMove(ZielX, ZielY)
    Sleep(200) 
    Click("Down") 
    Sleep(150)   
    Click("Up")   
    Sleep(200)
}


; ==========================================
; UPDATER FUNKTIONEN (AHK v2)
; ==========================================

CheckForUpdates() {
    global CurrentVersion, VersionURL
    
    whr := ComObject("WinHttp.WinHttpRequest.5.1")
    try {
        whr.Open("GET", VersionURL, true)
        whr.Send()
        whr.WaitForResponse()
        OnlineVersion := Trim(whr.ResponseText, " `t`r`n")
    } catch {
        return
    }
    
    if (OnlineVersion != "" && OnlineVersion != CurrentVersion) {
        Result := MsgBox("Eine neue Version (" . OnlineVersion . ") ist verfügbar.`nMöchtest du das Update jetzt automatisch installieren?", "Update verfügbar!", "YesNo 32")
        if (Result = "Yes") {
            PerformUpdate()
        }
    }
}

PerformUpdate() {
    global User, Repo
    
    ToolTip("Update wird geladen...")
    ZipFile := A_ScriptDir . "\update.zip"
    ExtractDir := A_ScriptDir . "\update_temp"
    ZipURL := "https://github.com/" . User . "/" . Repo . "/archive/refs/heads/main.zip"
    
    if FileExist(ZipFile)
        FileDelete(ZipFile)
    if DirExist(ExtractDir)
        DirDelete(ExtractDir, true)
        
    try {
        Download(ZipURL, ZipFile)
    } catch {
        MsgBox("Fehler beim Download der ZIP-Datei.", "Update Fehler", 48)
        ToolTip()
        return
    }
    
    ToolTip("Dateien werden nativ extrahiert...")
    DirCreate(ExtractDir)
    
    try {
        shell := ComObject("Shell.Application")
        zipFolder := shell.NameSpace(ZipFile)
        items := zipFolder.Items()
        targetFolder := shell.NameSpace(ExtractDir)
        targetFolder.CopyHere(items, 4 | 16)
    } catch {
        MsgBox("Fehler beim Entpacken. Bitte entpacke 'update.zip' manuell.", "Update Fehler", 48)
        ToolTip()
        return
    }
    
    ToolTip("Dateien werden im Verzeichnis ersetzt...")
    Sleep(500)
    
    SourceDir := ""
    Loop Files, ExtractDir . "\*", "D" {
        SourceDir := A_LoopFileFullPath
        break
    }
    
    if (SourceDir = "") {
        MsgBox("Der entpackte GitHub-Ordner wurde nicht gefunden.", "Update Fehler", 48)
        ToolTip()
        return
    }

    ; Alle Assets und Bilder sofort live überschreiben
    Loop Files, SourceDir . "\*", "R" {
        RelPath := SubStr(A_LoopFileFullPath, StrLen(SourceDir) + 2)
        DestPath := A_ScriptDir . "\" . RelPath
        
        if (A_LoopFileFullPath = A_ScriptFullPath || DestPath = A_ScriptFullPath)
            continue
            
        SplitPath(DestPath, , &DestDir)
        if !DirExist(DestDir)
            DirCreate(DestDir)
            
        FileCopy(A_LoopFileFullPath, DestPath, true)
    }

    NewScriptFile := SourceDir . "\" . A_ScriptName
    if FileExist(NewScriptFile) {
        ; Löscht stattdessen im Nachgang brav die ZIP und Temp-Ordner.
        CmdLine := 'cmd.exe /c timeout /t 1 /nobreak && del /f /q "' . A_ScriptFullPath . '" && move /y "' . NewScriptFile . '" "' . A_ScriptFullPath . '" && del /q "' . ZipFile . '" && rd /s /q "' . ExtractDir . '"'
        Run(CmdLine, , "Hide")
        
        ; Dem Nutzer Bescheid geben, dass er einmal manuell starten soll
        MsgBox("Das Update wurde erfolgreich installiert!`n`nBitte starte das Skript jetzt einmal kurz manuell neu, damit die Änderungen aktiv werden.", "Update erfolgreich", "64")
    } else {
        FileDelete(ZipFile)
        DirDelete(ExtractDir, true)
        MsgBox("Skript-Datei im Update nicht gefunden. Bitte starte manuell neu.", "Update Hinweis")
    }
    
    ExitApp()
}
