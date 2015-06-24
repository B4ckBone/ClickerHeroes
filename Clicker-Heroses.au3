; B4ckBOne's Clicker Heroes Autoit Script
; ToDo:
; Integrate planned and dps optimised Hero and Skill upgrades
; And choose the upgrades
; 1 cid lvl 100
; 2 Treebeast 100
; 3 Ivan the brawler 100,
; 5 Wandering fisherman 100
; 6 Betty clicker lvl 100
; 8 Leon 75
; 10 Alexa 100
; 12 mercedes dutches of blades100
; 13 Bobby 100
; 14 Broyle 10 - 100 Metall detector
; 15 Sir George II 100
; 16 king Midas 100
; 17 Referi 100
; 18 Abbadon 100 Dark ritual
; 20 Amenhotep 150
; 21 Beastlord 100
; ... http://clickerheroes.wikia.com/wiki/Upgrades

#include <Misc.au3>
#include <array.au3>
#include <MsgBoxConstants.au3>
#include <ImageSearch.au3>

;ImageSearch
Global $result = False ;image search result
Global $x1 ;image search result
Global $y1 ;image search result

Global $hWnd = WinActivate("Clicker Heroes")
WinMove("Clicker Heroes","",100,100,1143,672)
Global $WinPos[3]
$WinPos = WinGetPos("Clicker Heroes")
;~ Consolewrite($winpos[0]&$winpos[1]&@crlf)
;Size 1599,1120
Opt("MouseCoordMode", 0) ;1=absolute, 0=relative, 2=client - need to shift all coordinates o.O
Local $hDLL = DllOpen("user32.dll")
		Opt("SendKeyDelay", 200)
		Opt("SendKeyDownDelay", 200)
HotKeySet("{PAUSE}", "TogglePause")
HotKeySet("{END}", "Terminate")
Global $paused = False
Global $rot=False
Global $ChangeFound = True
Global $x = 0
Global $x = 0
Global $x1 = 0
Global $y1 = 0
Global $x4 = 0
Global $y4 = 0
Global $g1 = 0
Global $g2 = 0
Global $lvldown = False
Global $upgrade =False
Global $counter = 0
Global $Boss =False
Global $click = 0
Global $diff = 0
Global $goldinnerx = 250
Global $goldinnery = 50
Global $goldouterx = 350
Global $goldoutery = 85
Dim $Bild1[361][91]
Dim $Bild2[361][91]
Global $Title = "Clicker Heroes" ; Name of the Window
Global $RunState = True

While true
	consolewrite(@crlf)
	if $lvldown = True Then
		For $i=0 to 10 Step +1
			click()
		Next
	Else
		click()
	EndIf
	upgrades()
	lvlcheck()
	consolewrite("Lvl upgrade?" & $upgrade & " "& "Boss found?" & $Boss & " " & @crlf)
	if $upgrade = True Then;& $Boss = False Then
		lvlup()
	Endif
	if $Boss = True Then
		bossfight()
		goldcheck()
		consolewrite("Gold Changing?" & $ChangeFound & @crlf)
		if $ChangeFound=True Then
			lvlup()
			$lvldown = False
		Else
			lvldown()
			$lvldown = True
		EndIf
	EndIf
WEnd

Func click()
	goldfish()
	For $i=1 to 50 Step +1
		MClick(850,400,10,10)
		sleep(250)
	Next
EndFunc

Func MClick($x, $y, $times = 1, $speed = 0)
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($Title, "", "", "main", "1", $x, $y)
;~ 			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		ControlClick($Title, "", "", "main", "1", $x, $y)
	EndIf
EndFunc   ;==>Click

Func lvlcheck()
	; check for bouncing yellow !
	$lvl = PixelSearch(915+$WinPos[0], 40+$WinPos[1],925+$WinPos[0],50+$WinPos[1],0xFFFF00,2)
	if IsArray($lvl)=True Then
		$upgrade = True
	Else
		$upgrade = False
	EndIf
	; check for boss clock pixel
	$lvl = PixelSearch(820+$WinPos[0], 198+$WinPos[1],826+$WinPos[0],204+$WinPos[1],0x4D5C81)
	if IsArray($lvl)=True Then
		$boss = True
	Else
		$boss = False
	EndIf
EndFunc

Func lvlup()
	MClick(925,70,1,10)
	sleep(500)
	lvlcheck()
Endfunc

Func lvldown()
	MClick(790,70,1,10)
Endfunc

Func upgrades() ; alwas upgrades the most expensive hero untill next lvl
		Opt("SendKeyDelay", 500)
		Opt("SendKeyDownDelay", 500)
		MClick(551,241,5,1); click scrollbar all the way up
		click()
		MClick(553,600,5,1); click scrollbar all the way down
		click()
		MClick(92,496,1,0); click scrollbar all the way down
;~ 	For $i=610 to 350 Step -45
;~ 		MClick(100,$i,1,10)
;~ 	Next
	;~ 	MClick(553,649,30,1); click scrollbar down arrow
;~ 	MClick(553,506,30,1); click scrollbar dark area
;~ 	MouseClickDrag("left",550,250,550,600); pull scrollbar down
Endfunc

Func bossfight()
	For $i=200 to 450 step +50
	MClick(611,$i,1,0)
	sleep(300)
	Next
Endfunc

Func goldcheck() ;Gold Change detections
;~ 	consolewrite("Bild1"&@crlf)
	For $x = $goldinnerx To $goldouterx Step +10
		$x4 = $x + $WinPos[0]
		For $y = $goldinnery To $goldoutery Step +5
			$y4 = $y + $WinPos[1]
		$Bild1[$x][$y] = PixelGetColor($x4, $y4)
 		;ConsoleWrite ($Bild1[$x][$y] &" " &$x &" " &$y& " " & @CRLF)
		Next
	Next
	click()
	click()
;~ 	Global $goldinnerx = 250
;~ Global $goldinnery = 50
;~ Global $goldouterx = 350
;~ Global $goldoutery = 85
	$x = 0
	$y = 0
	$x4 = 0
	$y4 = 0
	;ConsoleWrite ($counter & @CRLF)
	;Bild2 einlesen
;~ 	consolewrite("Bild 2"&@crlf)
	For $x = $goldinnerx To $goldouterx Step +10
		$x4 = $x + $WinPos[0]
		For $y = $goldinnery To $goldoutery Step +5
			$y4 = $y + $WinPos[1]
			$Bild2[$x][$y] = PixelGetColor($x4, $y4)
;~ 			ConsoleWrite ($Bild2[$x][$y] &" " &$x &" " &$y& " " & @CRLF)
			If $Bild2[$x][$y] <> $Bild1[$x][$y] Then
				$diff = $diff + 1
			EndIf
		Next
	Next
	If $diff > 0 Then
;~ 	If $diff > 0 and $diff < 10 Then
;~ 	   ConsoleWrite ("found" & $diff & @CRLF)
		$ChangeFound = True
		Sleep(100)
	Else
;~ 		ConsoleWrite ("NOT found" & $diff & @CRLF)
		$ChangeFound=False
	EndIf
	$diff = 0
EndFunc

Func goldfish()
	;consolewrite("Searching GoldFish goldfish24bit" & @crlf)
	local $result = _ImageSearchArea('goldfish24bit.bmp',1,$WinPos[0],$WinPos[1],$WinPos[0]+1143,$WinPos[0]+672, $g1, $g2, 10)
		If $result = 1 Then
			ConsoleWrite("Goldfish found?" & $result & " " & $g1 & " " & $g2 & @crlf)
			$g1 = $g1 - $WinPos[0]
			$g2 = $g2 - $WinPos[1]
			MClick($g1, $g2,9,10)
;~ 			MouseMove($g1, $g2)
;~ 			MouseClick($g1, $g2,9,10)
		EndIf

	local $result = _ImageSearchArea('gf2.bmp',1,$WinPos[0],$WinPos[1],$WinPos[0]+1143,$WinPos[0]+672, $g1, $g2, 10)
		If $result = 1 Then
			ConsoleWrite("Goldfish found?" & $result & " " & $g1 & " " & $g2 & @crlf)
			$g1 = $g1 - $WinPos[0]
			$g2 = $g2 - $WinPos[1]
			MClick($g1, $g2,9,10)
;~ 			MouseMove($g1, $g2)
;~ 			MouseClick($g1, $g2,9,10)
		EndIf

	local $result = _ImageSearchArea('bee.bmp',1,$WinPos[0],$WinPos[1],$WinPos[0]+1143,$WinPos[0]+672, $g1, $g2, 10)
		If $result = 1 Then
			ConsoleWrite("Bee found?" & $result & " " & $g1 & " " & $g2 & @crlf)
			$g1 = $g1 - $WinPos[0]
			$g2 = $g2 - $WinPos[1]
			MClick($g1, $g2,9,10)
;~ 			MouseMove($g1, $g2)
;~ 			MouseClick($g1, $g2,9,10)
		EndIf
EndFunc

Func TogglePause()
	$Paused = NOT $Paused
	While $Paused
		sleep(100)
		ToolTip('Script is "Paused"',0,0)
	WEnd
	ToolTip("")
EndFunc

Func Terminate()
	Exit 0
EndFunc