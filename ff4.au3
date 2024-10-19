#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Eric Bulloch

 Script Function:
   Provide the capablility to play the Final Fantasy IV game manually or have
   the bot play the game for you. It has 3 modes that the game plays in:

   * Manual - You control the game
   * Attack only grind - The bot will move back and forth to get in battle and
     only attack when in a battle.
   * Gambit grind - The bot will move back and forth to get in battle and then
     use data to make decisions on what action to take for each character.
     Currently, you just uncomment out the enemy you are fighting.

#ce ----------------------------------------------------------------------------
#include <GUIConstantsEx.au3>
Local $configurationFile = 'ff4.ini'
Local $section = '640x480'
Local $black = '00000000'
Local $eggShellWhite = '00DBDBDB'
Local $white = '00FFFFFF'
Local $stairsPixel = '002B3C4F'

if WinActivate('Final Fantasy IV') == 0 Then
   Exit -1
EndIf

Local $battleHandXOffset = ReadValue($configurationFile, $section, 'BATTLE_HAND_X_OFFSET')
Local $battleHandYOffset = ReadValue($configurationFile, $section, 'BATTLE_HAND_Y_OFFSET')
Local $postBattleCursorXOffset = ReadValue($configurationFile, $section, 'POST_BATTLE_CURSOR_X_OFFSET')
Local $postBattleCursorYOffset = ReadValue($configurationFile, $section, 'POST_BATTLE_CURSOR_Y_OFFSET')
Local $postBattleLootCursorXOffset = ReadValue($configurationFile, $section, 'POST_BATTLE_LOOT_CURSOR_X_OFFSET')
Local $postBattleLootCursorYOffset = ReadValue($configurationFile, $section, 'POST_BATTLE_LOOT_CURSOR_Y_OFFSET')
Local $postBattleLevelTextXOffset = ReadValue($configurationFile, $section, 'POST_BATTLE_LEVEL_TEXT_X_OFFSET')
Local $postBattleLevelTextYOffset = ReadValue($configurationFile, $section, 'POST_BATTLE_LEVEL_TEXT_Y_OFFSET')
Local $postBattleLevelCursorXOffset = ReadValue($configurationFile, $section, 'POST_BATTLE_LEVEL_CURSOR_X_OFFSET')
Local $postBattleLevelCursorYOffset = ReadValue($configurationFile, $section, 'POST_BATTLE_LEVEL_CURSOR_Y_OFFSET')
Local $bottomNameXOffset = ReadValue($configurationFile, $section, 'BOTTOM_NAME_X_OFFSET')
Local $bottomNameYOffset = ReadValue($configurationFile, $section, 'BOTTOM_NAME_Y_OFFSET')
Local $movementStateXOffset = ReadValue($configurationFile, $section, 'MOVEMENT_STATE_X_OFFSET')
Local $movementStateYOffset = ReadValue($configurationFile, $section, 'MOVEMENT_STATE_Y_OFFSET')
$x = ReadValue($configurationFile, $section, 'WINDOW_X')
$y = ReadValue($configurationFile, $section, 'WINDOW_Y')
WinMove('[ACTIVE]', '', $x, $y)

Func Grind()
   If Not (WinGetTitle("[ACTIVE]") = "Final Fantasy IV") Then
	  Return
   EndIf
   Local $battleHandColor = PixelGetColor($x + $battleHandXOffset, $y + $battleHandYOffset)
   Local $postBattleCursor = PixelGetColor($x + $postBattleCursorXOffset, $y + $postBattleCursorYOffset)
   Local $postBattleLootCursor = PixelGetColor($x + $postBattleLootCursorXOffset, $y + $postBattleLootCursorYOffset)
   Local $postBattleLevelText = PixelGetColor($x + $postBattleLevelTextXOffset, $y + $postBattleLevelTextYOffset)
   Local $postBattleLevelCursor = PixelGetColor($x + $postBattleLevelCursorXOffset, $y + $postBattleLevelCursorYOffset)
   If Hex($battleHandColor) = $white Then
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($postBattleCursor) = $eggShellWhite Then
	  KeyPress("ENTER", 3, 25)
   ElseIf Hex($postBattleLootCursor) = $eggShellWhite Then
	  KeyPress("ENTER", 3, 25)
   ; Keeping the next one due to when a new magic ability is gained.
   ElseIf Hex($postBattleLevelCursor) = $eggShellWhite Then
	  KeyPress("ENTER", 2, 200)
   ElseIf Hex($postBattleLevelText) = $white Then
	  KeyPress("ENTER", 2, 25)
   Else
	  KeyPress("LEFT", 1, 150)
	  Sleep(25)
	  KeyPress("RIGHT", 1, 150)
   EndIf
EndFunc

Func Gambit()
   ; GambitGreenOrYellowDragonOrArmoredFiend()
   ; GambitFlanPrincess()
   ; GambitRedDragon()
   GambitLilith()
EndFunc

Func GambitFlanPrincess()
   If Not (WinGetTitle("[ACTIVE]") = "Final Fantasy IV") Then
	  Return
   EndIf
   Local $bottomNamePixel = PixelGetColor($x + $bottomNameXOffset, $y + $bottomNameYOffset)
   ; If Hex($bottomNamePixel) = $white Then
   ;   ConsoleWrite('No Good' & @CRLF)
   ;   Return
   ; EndIf
   Local $battleHandColor = PixelGetColor($x + $battleHandXOffset, $y + $battleHandYOffset)
   Local $postBattleCursor = PixelGetColor($x + $postBattleCursorXOffset, $y + $postBattleCursorYOffset)
   Local $postBattleLootCursor = PixelGetColor($x + $postBattleLootCursorXOffset, $y + $postBattleLootCursorYOffset)
   Local $postBattleLevelText = PixelGetColor($x + $postBattleLevelTextXOffset, $y + $postBattleLevelTextYOffset)
   Local $postBattleLevelCursor = PixelGetColor($x + $postBattleLevelCursorXOffset, $y + $postBattleLevelCursorYOffset)
   Local $movementStateColor = PixelGetColor($x + $movementStateXOffset, $y + $movementStateYOffset)
   If Hex($battleHandColor) = $white Then
	  ConsoleWrite('Battle' & @CRLF)
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($postBattleCursor) = $eggShellWhite Then
	  ConsoleWrite('Post Battle' & @CRLF)
	  KeyPress("ENTER", 3, 25)
   ElseIf Hex($postBattleLootCursor) = $eggShellWhite Then
	  ConsoleWrite('Battle Loot' & @CRLF)
	  KeyPress("ENTER", 3, 25)
   ; Keeping the next one due to when a new magic ability is gained.
   ElseIf Hex($postBattleLevelCursor) = $eggShellWhite Then
	  ConsoleWrite('Level' & @CRLF)
	  KeyPress("ENTER", 2, 200)
   ElseIf Hex($postBattleLevelText) = $white Then
	  ConsoleWrite('Level Text' & @CRLF)
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($movementStateColor) = $black Then
	  ; Revive Cecil
	  ConsoleWrite('Movement' & @CRLF)
	  KeyPress2("TAB", 1, 750)
	  If MainMenuKeyPress("DOWN", 1, 50) = False Then
		 Return 0
	  EndIf
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("DOWN", 3, 200)
	  KeyPress2("ENTER", 1, 750)
	  ; KeyPress2("DOWN", 1, 200)
	  ; KeyPress2("RIGHT", 2, 200)
	  ; KeyPress2("ENTER", 1, 200)
	  ; KeyPress2("DOWN", 2, 150)
	  ; KeyPress2("ENTER", 1, 200)
	  ; Heal Cecil
	  ; KeyPress2("BACKSPACE", 1, 750)
	  ; KeyPress2("UP", 1, 200)
	  ; KeyPress2("LEFT", 2, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("DOWN", 2, 200)
	  KeyPress2("ENTER", 4, 200)
	  ; Start Flan Princess Battle
	  KeyPress2("BACKSPACE", 2, 500)
	  KeyPress2("BACKSPACE", 1, 1500)
	  KeyPress2("BACKSPACE", 1, 500)
      KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 1, 1000)
	  KeyPress2("RIGHT", 1, 100)
	  KeyPress2("DOWN", 5, 100)
	  KeyPress2("ENTER", 1, 100)
   Else
	  ConsoleWrite('Nothing' & @CRLF)
   EndIf
EndFunc

Func GambitRedDragon()
   If Not (WinGetTitle("[ACTIVE]") = "Final Fantasy IV") Then
	  Return
   EndIf
   Local $battleHandColor = PixelGetColor($x + $battleHandXOffset, $y + $battleHandYOffset)
   Local $postBattleCursor = PixelGetColor($x + $postBattleCursorXOffset, $y + $postBattleCursorYOffset)
   Local $postBattleLootCursor = PixelGetColor($x + $postBattleLootCursorXOffset, $y + $postBattleLootCursorYOffset)
   Local $postBattleLevelText = PixelGetColor($x + $postBattleLevelTextXOffset, $y + $postBattleLevelTextYOffset)
   Local $postBattleLevelCursor = PixelGetColor($x + $postBattleLevelCursorXOffset, $y + $postBattleLevelCursorYOffset)
   Local $movementStateColor = PixelGetColor($x + 274, $y + 297)
   If Hex($battleHandColor) = $white Then
	  ConsoleWrite('Battle' & @CRLF)
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($postBattleCursor) = $eggShellWhite Then
	  ConsoleWrite('Post Battle' & @CRLF)
	  KeyPress("ENTER", 3, 25)
   ElseIf Hex($postBattleLootCursor) = $eggShellWhite Then
	  ConsoleWrite('Battle Loot' & @CRLF)
	  KeyPress("ENTER", 3, 25)
   ; Keeping the next one due to when a new magic ability is gained.
   ElseIf Hex($postBattleLevelCursor) = $eggShellWhite Then
	  ConsoleWrite('Level' & @CRLF)
	  KeyPress("ENTER", 2, 200)
   ElseIf Hex($postBattleLevelText) = $white Then
	  ConsoleWrite('Level Text' & @CRLF)
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($movementStateColor) = $stairsPixel Then
	  ; Revive Cecil
	  ConsoleWrite('Movement' & @CRLF)
	  KeyPress2("TAB", 1, 1000)
	  If MainMenuKeyPress("DOWN", 1, 50) = False Then
		 Return 0
	  EndIf
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("DOWN", 3, 200)
	  KeyPress2("ENTER", 1, 750)
	  ; KeyPress2("DOWN", 1, 200)
	  ; KeyPress2("RIGHT", 2, 200)
	  ; KeyPress2("ENTER", 1, 200)
	  ; KeyPress2("DOWN", 2, 150)
	  ; KeyPress2("ENTER", 1, 200)
	  ; Heal Cecil
	  ; KeyPress2("BACKSPACE", 1, 750)
	  ; KeyPress2("UP", 1, 200)
	  ; KeyPress2("LEFT", 2, 200)
	  KeyPress2("DOWN", 2, 200)
	  KeyPress2("RIGHT", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  ; Start Flan Princess Battle
	  KeyPress2("BACKSPACE", 2, 500)
	  KeyPress2("BACKSPACE", 1, 1500)
	  KeyPress2("BACKSPACE", 1, 500)
      KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 1, 1000)
	  KeyPress2("RIGHT", 1, 100)
	  KeyPress2("DOWN", 5, 100)
	  KeyPress2("ENTER", 1, 100)
   Else
	  ConsoleWrite('Nothing' & @CRLF)
   EndIf
EndFunc

Func GambitLilith()
   If Not (WinGetTitle("[ACTIVE]") = "Final Fantasy IV") Then
	  Return
   EndIf
   Local $battleHandColor = PixelGetColor($x + $battleHandXOffset, $y + $battleHandYOffset)
   Local $postBattleCursor = PixelGetColor($x + $postBattleCursorXOffset, $y + $postBattleCursorYOffset)
   Local $postBattleLootCursor = PixelGetColor($x + $postBattleLootCursorXOffset, $y + $postBattleLootCursorYOffset)
   Local $postBattleLevelText = PixelGetColor($x + $postBattleLevelTextXOffset, $y + $postBattleLevelTextYOffset)
   Local $postBattleLevelCursor = PixelGetColor($x + $postBattleLevelCursorXOffset, $y + $postBattleLevelCursorYOffset)
   Local $movementStateColor = PixelGetColor($x + 321, $y + 206)
   If Hex($battleHandColor) = $white Then
	  ConsoleWrite('Battle' & @CRLF)
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($postBattleCursor) = $eggShellWhite Then
	  ConsoleWrite('Post Battle' & @CRLF)
	  KeyPress("ENTER", 3, 25)
   ElseIf Hex($postBattleLootCursor) = $eggShellWhite Then
	  ConsoleWrite('Battle Loot' & @CRLF)
	  KeyPress("ENTER", 3, 25)
   ; Keeping the next one due to when a new magic ability is gained.
   ElseIf Hex($postBattleLevelCursor) = $eggShellWhite Then
	  ConsoleWrite('Level' & @CRLF)
	  KeyPress("ENTER", 2, 200)
   ElseIf Hex($postBattleLevelText) = $white Then
	  ConsoleWrite('Level Text' & @CRLF)
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($movementStateColor) = $black Then
	  ; Revive Cecil
	  ConsoleWrite('Movement' & @CRLF)
	  KeyPress2("TAB", 1, 1000)
	  If MainMenuKeyPress("DOWN", 1, 50) = False Then
		 Return 0
	  EndIf
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("DOWN", 3, 200)
	  KeyPress2("ENTER", 1, 750)
	  ; KeyPress2("DOWN", 1, 200)
	  ; KeyPress2("RIGHT", 2, 200)
	  ; KeyPress2("ENTER", 1, 200)
	  ; KeyPress2("DOWN", 2, 150)
	  ; KeyPress2("ENTER", 1, 200)
	  ; Heal Cecil
	  ; KeyPress2("BACKSPACE", 1, 750)
	  ; KeyPress2("UP", 1, 200)
	  ; KeyPress2("LEFT", 2, 200)
	  KeyPress2("DOWN", 2, 200)
	  KeyPress2("RIGHT", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("ENTER", 1, 200)
	  ; Start Flan Princess Battle
	  KeyPress2("BACKSPACE", 2, 500)
	  KeyPress2("BACKSPACE", 1, 1500)
	  KeyPress2("BACKSPACE", 1, 500)
      KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 1, 1000)
	  ; KeyPress2("RIGHT", 1, 100)
	  KeyPress2("DOWN", 5, 100)
	  KeyPress2("ENTER", 1, 100)
   Else
	  ConsoleWrite('Nothing' & @CRLF)
   EndIf
EndFunc

Func GambitGreenOrYellowDragonOrArmoredFiend()
   If Not (WinGetTitle("[ACTIVE]") = "Final Fantasy IV") Then
	  Return
   EndIf
   Local $battleHandColor = PixelGetColor($x + $battleHandXOffset, $y + $battleHandYOffset)
   Local $postBattleCursor = PixelGetColor($x + $postBattleCursorXOffset, $y + $postBattleCursorYOffset)
   Local $postBattleLootCursor = PixelGetColor($x + $postBattleLootCursorXOffset, $y + $postBattleLootCursorYOffset)
   Local $postBattleLevelText = PixelGetColor($x + $postBattleLevelTextXOffset, $y + $postBattleLevelTextYOffset)
   Local $postBattleLevelCursor = PixelGetColor($x + $postBattleLevelCursorXOffset, $y + $postBattleLevelCursorYOffset)
   Local $movementStateColor = PixelGetColor($x + $movementStateXOffset, $y + $movementStateYOffset)
   If Hex($battleHandColor) = $white Then
	  ConsoleWrite('Battle' & @CRLF)
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($postBattleCursor) = $eggShellWhite Then
	  ConsoleWrite('Post Battle' & @CRLF)
	  KeyPress("ENTER", 3, 25)
   ElseIf Hex($postBattleLootCursor) = $eggShellWhite Then
	  ConsoleWrite('Battle Loot' & @CRLF)
	  KeyPress("ENTER", 3, 25)
   ; Keeping the next one due to when a new magic ability is gained.
   ElseIf Hex($postBattleLevelCursor) = $eggShellWhite Then
	  ConsoleWrite('Level' & @CRLF)
	  KeyPress("ENTER", 2, 200)
   ElseIf Hex($postBattleLevelText) = $white Then
	  ConsoleWrite('Level Text' & @CRLF)
	  KeyPress("ENTER", 2, 25)
   ElseIf Hex($movementStateColor) = $black Then
	  ; Heal Cecil
	  ConsoleWrite('Movement' & @CRLF)
	  KeyPress2("TAB", 1, 1000)
	  If MainMenuKeyPress("DOWN", 1, 50) = False Then
		 Return 0
	  EndIf
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("DOWN", 3, 200)
	  KeyPress2("ENTER", 1, 750)
	  ; KeyPress2("DOWN", 1, 200)
	  ; KeyPress2("RIGHT", 2, 200)
	  ; KeyPress2("ENTER", 1, 200)
	  ; KeyPress2("DOWN", 2, 150)
	  ; KeyPress2("ENTER", 1, 200)
	  ; Heal Cecil
	  ; KeyPress2("BACKSPACE", 1, 750)
	  ; KeyPress2("UP", 1, 200)
	  ; KeyPress2("LEFT", 2, 200)
	  KeyPress2("ENTER", 1, 200)
	  KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 4, 200)
	  ; Start Green Dragon Battle
	  KeyPress2("BACKSPACE", 1, 250)
	  KeyPress2("BACKSPACE", 1, 750)
	  KeyPress2("BACKSPACE", 1, 2000)
	  KeyPress2("BACKSPACE", 1, 1000)
      KeyPress2("UP", 1, 200)
	  KeyPress2("ENTER", 1, 1000)
	  KeyPress2("RIGHT", 1, 100)
	  KeyPress2("DOWN", 5, 100)
	  KeyPress2("ENTER", 1, 100)
   Else
	  ConsoleWrite('Nothing' & @CRLF)
   EndIf
EndFunc

Func KeyPress($controlKey, $count, $delayTime)
   for $i = 1 to $count
	  Send("{" & $controlKey & " down}")
	  Sleep($delayTime)
	  Send("{" & $controlKey & " up}")
   Next
EndFunc

Func KeyPress2($controlKey, $count, $delayTime, $keyDelayTime = 25)
   for $i = 1 to $count
	  Send("{" & $controlKey & " down}")
	  Sleep($keyDelayTime)
	  Send("{" & $controlKey & " up}")
	  Sleep($delayTime)
   Next
EndFunc

Func MainMenuKeyPress($controlKey, $count, $delayTime, $keyDelayTime = 25)
   Local $mainMenuBarColor = PixelGetColor(790, 650)
   If Hex($mainMenuBarColor) = '00D5D5D5' Then
	  KeyPress2($controlKey, $count, $delayTime, $keyDelayTime)
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func ReadValue($filePath, $section, $key)
   Local $value = IniRead($filePath, $section, $key, '')
   if $value = '' Then
	  ConsoleWrite("Could not find a value in the " & $filePath & " file, under the '" & $section & "' section, using the key of '" & $key & ".")
	  Exit -1
   EndIf
   Return $value
EndFunc

Local $leftMargin = 10
Local $window = GUICreate("Final Fantasy IV Bot", 200, 240)
Local $actionLabel = GUICtrlCreateLabel("Current mode: Manual", $leftMargin, 30, 180, 40)
Local $manualButton = GUICtrlCreateButton("Manual", $leftMargin, 70, 180, 40)
Local $grindFightButton = GUICtrlCreateButton("Grind - Fight Only", $leftMargin, 110, 180, 40)
Local $grindGambitButton = GUICtrlCreateButton("Grind - Gambit", $leftMargin, 150, 180, 40)
Local $refocusButton = GUICtrlCreateButton("Refocus", $leftMargin, 190, 180, 40)
GUISetState(@SW_SHOW, $window)

Local $message = 0
Local $action = 0
While True
   $message = GUIGetMsg()
   Switch $message
   Case $manualButton
		 GUICtrlSetData($actionLabel, "Current mode: Manual")
         $action = 0
      Case $grindFightButton
		 GUICtrlSetData($actionLabel, "Current mode: Grind - Fight Only")
         $action = 1
      Case $grindGambitButton
		 GUICtrlSetData($actionLabel, "Current mode: Grind - Gambit")
         $action = 2
	  Case $refocusButton
		 WinMove('Final Fantasy IV', '', $x, $y)
      Case $GUI_EVENT_CLOSE
         ExitLoop
   EndSwitch
   If $action = 1 Then
      Grind()
   ElseIf $action = 2 Then
	  Gambit()
   EndIf
WEnd
GUIDelete($window)