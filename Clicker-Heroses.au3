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
; Cid 1 .. 4 down 10 first ability go back to 2 get 100lvl and ability
; Most hero souls in the least time

#include <File.au3>
#include <Misc.au3>
#include <array.au3>
#include <MsgBoxConstants.au3>
#include <ImageSearch.au3>
#include <FileConstants.au3>
;~ FileRead(settings.txt)
Global $hWnd = WinActivate("Clicker Heroes")
WinMove("Clicker Heroes", "", 3097, 205, 1143, 672)
Global $WinPos[3]
$WinPos = WinGetPos("Clicker Heroes")
;~ Consolewrite($winpos[0]&$winpos[1]&@crlf)
;Size 1599,1120
Opt("MouseCoordMode", 0) ;1=absolute, 0=relative, 2=client - need to shift all coordinates o.O
Local $hDLL = DllOpen("user32.dll")
Opt("SendKeyDelay", 100)
Opt("SendKeyDownDelay", 100)
HotKeySet("{PAUSE}", "TogglePause")
HotKeySet("{END}", "Terminate")
Global $paused = False
Global $rot = False
Global $ChangeFound = True
Global $result = False ;image search result
Global $x = 0
Global $x = 0
Global $hirex = 0
Global $hirey = 0
Global $lvlx = 0
Global $lvly = 0
Global $x1 = 0
Global $y1 = 0
Global $x4 = 0
Global $y4 = 0
Global $g1 = 0
Global $g2 = 0
Global $lvldown = False
Global $upgrade = False
Global $counter = 0
Global $Boss = False
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

Global $arr[35][2] ; List of HeroLVL that is usefull
For $i = 0 To 34 Step +1
	For $n = 0 To 1 Step +1
		$arr[$i][$n] = 0
	Next
Next
;Assign some data
Func SetArray()
	$arr[0][0] = 100; Hero 1 "Cid" LvL up to 100
	$arr[1][0] = 100; Hero 2 "Treebeast" LvL up to 100
	$arr[2][0] = 100; Hero 3 "Ivan The brawler" LvL up to 100
	$arr[3][0] = 10; Hero 4 "Brittany" No need to lvl
	$arr[4][0] = 100; Hero 5 "Wandering Fisherman" lvlup to 100 --> gives click dmg
	$arr[5][0] = 100; Hero 6 "Betty Clicker" Lvlup to 100 gives click DPS
	$arr[6][0] = 10; Hero 7 "The masked samurai" No need to lvl
	$arr[7][0] = 100; Hero 8 "Leon" LVLup 100 25% DPS to all Heros
	$arr[8][0] = 10; Hero 9 "The grand forest seer" No need to lvl
	$arr[9][0] = 10; Hero 10 "Alexa Assassin" LVLup 100

	$arr[10][0] = 10; Hero 11 "Natalia"
	$arr[11][0] = 100; Hero 12 "Mercedes"
	$arr[12][0] = 100; Hero 13 "Bobby"
	$arr[13][0] = 10; Hero 14 "Broyle Lindeoven"
	$arr[14][0] = 100; Hero 15 "Sir George II"
	$arr[15][0] = 100; Hero 16 "King Midas"
	$arr[16][0] = 100; Hero 17 "Referi Jerator"
	$arr[17][0] = 100; Hero 18 "Abaddon" Dark Ritual 1,05% increased dmg
	$arr[18][0] = 10; Hero 19 "Ma Zhu"
	$arr[19][0] = 150; Hero 20 "Amenhotep" Ascension!!!!!

	$arr[20][0] = 100; Hero 21 "Beastlord"
	$arr[21][0] = 10; Hero 22 "Athena"
	$arr[22][0] = 10; Hero 23 "Aphrodite"
	$arr[23][0] = 25; Hero 24 "Shinatobe"
	$arr[24][0] = 50; Hero 25 "Grant the General"
	$arr[25][0] = 75; Hero 26 "Frostleaf"
	$arr[26][0] = 10; Hero 27 "Dread Knight"
	$arr[27][0] = 10; Hero 28 "Atlas"F
	$arr[28][0] = 10; Hero 29 "Terra"
	$arr[29][0] = 10; Hero 30 "Phthalo"

	$arr[30][0] = 10; Hero 31 "Orntchya Gladeye"
	$arr[31][0] = 10; Hero 32 "Lillin"
	$arr[32][0] = 10; Hero 33 "Cadmia"
	$arr[33][0] = 10; Hero 24 "Alabaster"
	$arr[34][0] = 10; Hero 25 "Astraea"
EndFunc   ;==>SetArray
SetArray()
_FileReadToArray("save.txt", $arr, 4, "|")
;~ _ArrayDisplay($arr)

While True
	; Some testing stuff....
;~ 	sleep(1000)
;~ 	ControlClick($Title, "", "", "main",270,430)
;~ 	ConsoleWrite(@error & " " & @extended & @crlf)
;~  	MouseClick("left",270,430,1,10)
;~ herolvl()
;~ sleep(2000)
;~ SetArray()

	;MAIN:
	ConsoleWrite(@CRLF)
	If $lvldown = True Then
		For $i = 0 To 25 Step +1
			ConsoleWrite("purClick # " & $i & @crlf)
			pureclick()
		Next
		ConsoleWrite("Herolvl # " & $n & @crlf)
		MClick(551, 241, 5, 1); click scrollbar all the way up
		sleep(200)
		MClick(553, 600, 5, 1); click scrollbar all the way down
		sleep(200)
		Herolvl()
		Herolvl()
		Herolvl()
		$lvldown = False
	Else
		click()
	EndIf

;~ 	upgrades()
	lvlit()
	lvlcheck()
	ConsoleWrite("Lvl upgrade?" & $upgrade & " " & "Boss found?" & $Boss & " " & @CRLF)
	If $upgrade = True Then;& $Boss = False Then
		lvlup()
	EndIf
	If $Boss = True Then
		bossfight()
		goldcheck()
		ConsoleWrite("Gold Changing?" & $ChangeFound & @CRLF)
		If $ChangeFound = True Then
			lvlup()
			$lvldown = False
		Else
			lvldown()
			$lvldown = True
		EndIf
	EndIf
	_FileWriteFromArray("save.txt", $arr, Default, Default, "|")
WEnd

Func click()
	For $i = 1 To 50 Step +1
		MClick(850, 400, 10, 10)
		Sleep(250)
	Next
	goldfish()
	Herolvl()
EndFunc   ;==>click

Func pureclick()
	For $i = 1 To 50 Step +1
		MClick(850, 400, 10, 10)
		Sleep(250)
	Next
	goldfish()
EndFunc   ;==>click

Func MClick($x, $y, $times = 1, $speed = 0)
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($Title, "", "", "main", "1", $x, $y)
;~ 			If _Sleep($speed, False) Then ExitLoop
		Next
	Else
		ControlClick($Title, "", "", "main", "1", $x, $y)
	EndIf
EndFunc   ;==>MClick

Func lvlcheck()
	; check for bouncing yellow !
	$lvl = PixelSearch(910 + $WinPos[0], 35 + $WinPos[1], 930 + $WinPos[0], 55 + $WinPos[1], 0xFFFF00, 2)
	If IsArray($lvl) = True Then
		$upgrade = True
	Else
		$upgrade = False
	EndIf
	; check for boss clock pixel
	$lvl = PixelSearch(820 + $WinPos[0], 198 + $WinPos[1], 826 + $WinPos[0], 204 + $WinPos[1], 0x4D5C81)
	If IsArray($lvl) = True Then
		$Boss = True
	Else
		$Boss = False
	EndIf
EndFunc   ;==>lvlcheck

Func lvlup()
	MClick(925, 70, 1, 10)
	Sleep(500)
	lvlcheck()
EndFunc   ;==>lvlup

Func lvldown()
	MClick(790, 70, 1, 10)
EndFunc   ;==>lvldown

Func upgrades() ; alwas upgrades the most expensive hero untill next lvl
	Opt("SendKeyDelay", 500)
	Opt("SendKeyDownDelay", 500)
	MClick(551, 241, 5, 1); click scrollbar all the way up
	click()
;~ 		MClick(551,500,5,1); click scrollbar all the way up
;~ 		click()
;~ 		MClick(551,300,5,1); click scrollbar all the way up
;~ 		click()
;~ 		MClick(551,400,5,1); click scrollbar all the way up
;~ 		click()
;~ 		MClick(551,550,5,1); click scrollbar all the way up
;~ 		click()
;~ 		MClick(551,320,5,1); click scrollbar all the way up
;~ 		click()
	MClick(553, 600, 5, 1); click scrollbar all the way down
	click()
;~ 		MClick(92,496,1,0); click scrollbar all the way down
;~ 	For $i=520 to 150 Step -20
;~ 		MClick(198,$i,1,10)
;~ 	Next
;~ 	For $i=520 to 150 Step -45
;~ 		MClick(100,$i,1,10)
;~ 	Next
;~ 	MClick(553,649,30,1); click scrollbar down arrow
;~ 	MClick(553,506,30,1); click scrollbar dark area
;~ 	MouseClickDrag("left",550,250,550,600); pull scrollbar down
	Opt("SendKeyDelay", 100)
	Opt("SendKeyDownDelay", 100)
EndFunc   ;==>upgrades

Func lvlit()
		For $i = 0 To 2 step +1
		Opt("SendKeyDelay", 300)
		Opt("SendKeyDownDelay", 300)
		MClick(551, 241, 5, 1); click scrollbar all the way up
		Herolvl()
		MClick(551, 500, 5, 1); click scrollbar all the way up
		Herolvl()
		MClick(551, 300, 5, 1); click scrollbar all the way up
		Herolvl()
		MClick(551, 400, 5, 1); click scrollbar all the way up
		Herolvl()
		MClick(551, 550, 5, 1); click scrollbar all the way up
		Herolvl()
		MClick(551, 320, 5, 1); click scrollbar all the way up
		Herolvl()
		MClick(553, 600, 5, 1); click scrollbar all the way down
		Herolvl()
		Herolvl()
		Herolvl()
		Herolvl()
		Next
Endfunc

Func bossfight()
	For $i = 450 To 200 Step -50
		MClick(611, $i, 1, 0)
		Sleep(250)
	Next
EndFunc   ;==>bossfight

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
		$ChangeFound = False
	EndIf
	$diff = 0
EndFunc   ;==>goldcheck

Func goldfish()
	;consolewrite("Searching GoldFish goldfish24bit" & @crlf)
	Local $result = _ImageSearchArea('goldfish24bit.bmp', 1, $WinPos[0], $WinPos[1], $WinPos[0] + 1143, $WinPos[0] + 672, $g1, $g2, 20)
	If $result = 1 Then
		ConsoleWrite("Goldfish found?" & $result & " " & $g1 & " " & $g2 & @CRLF)
		$g1 = $g1 - $WinPos[0]
		$g2 = $g2 - $WinPos[1]
		MouseClick("left", $g1, $g2, 9, 10)
;~ 			MouseMove($g1, $g2)
;~ 			MouseClick($g1, $g2,9,10)
	EndIf

	Local $result = _ImageSearchArea('gf2.bmp', 1, $WinPos[0], $WinPos[1], $WinPos[0] + 1143, $WinPos[0] + 672, $g1, $g2, 20)
	If $result = 1 Then
		ConsoleWrite("Goldfish found?" & $result & " " & $g1 & " " & $g2 & @CRLF)
		$g1 = $g1 - $WinPos[0]
		$g2 = $g2 - $WinPos[1]
		MouseClick("left", $g1, $g2, 9, 10)
;~ 			MouseMove($g1, $g2)
;~ 			MouseClick($g1, $g2,9,10)
	EndIf

	Local $result = _ImageSearchArea('fish.bmp', 1, $WinPos[0], $WinPos[1], $WinPos[0] + 1143, $WinPos[0] + 672, $g1, $g2, 20)
	If $result = 1 Then
		ConsoleWrite("Goldfish found?" & $result & " " & $g1 & " " & $g2 & @CRLF)
		$g1 = $g1 - $WinPos[0]
		$g2 = $g2 - $WinPos[1]
		MouseClick("left", $g1, $g2, 9, 10)
;~ 			MouseMove($g1, $g2)
;~ 			MouseClick($g1, $g2,9,10)
	EndIf

	Local $result = _ImageSearchArea('bee.bmp', 1, $WinPos[0], $WinPos[1], $WinPos[0] + 1143, $WinPos[0] + 672, $g1, $g2, 10)
	If $result = 1 Then
		ConsoleWrite("Bee found?" & $result & " " & $g1 & " " & $g2 & @CRLF)
		$g1 = $g1 - $WinPos[0]
		$g2 = $g2 - $WinPos[1]
		MClick($g1, $g2, 9, 10)
;~ 			MouseMove($g1, $g2)
;~ 			MouseClick($g1, $g2,9,10)
	EndIf
EndFunc   ;==>goldfish

Func Herolvl()
	Local $hero = 0
	For $hero = 34 To 0 Step -1
		$HeroBmp = $hero + 1
		$HeroBmp &= '.PNG'
		$HeroBmp = @WorkingDir & '\hero\' & $HeroBmp
;~ 		consolewrite($HeroBmp & " " & $arr[$hero]& @crlf)
		;look for Hero names
		Local $result = _ImageSearchArea($HeroBmp, 1, $WinPos[0] + 160, $WinPos[1] + 190, $WinPos[0] + 450, $WinPos[1] + 550, $g1, $g2, 50)
		;look for Hero pieces
		;local $result = _ImageSearchArea($HeroBmp,1,$WinPos[0]+420,$WinPos[1]+190,$WinPos[0]+530,$WinPos[0]+650, $g1, $g2, 140)
		If $result = 1 Then
;~ 			ConsoleWrite("Hero Found" & $hero & " " & $g1 & " " & $g2 & @crlf)
			;Click abilities
			Local $h = $g2 - $WinPos[1] + 57
;~ 			ConsoleWrite($h & @crlf)
			Local $result = _ImageSearchArea(@WorkingDir & '\hero\ehire.bmp', 1, $WinPos[0], $g2, $WinPos[0] + 250, $g2 + 150, $hirex, $hirey, 50)
			If $result = 1 Then
				ConsoleWrite("Hiring" & $hero + 1 & " " & $g1 & " " & $g2 & @CRLF)
				MClick($hirex - $WinPos[0], $hirey - $WinPos[1], 1, 0)
;~ 				ConsoleWrite("Hiring Hero " & $hero + 1 & " Set herolvl db 1" & @CRLF)
				$arr[$hero][1] = 1
			EndIf
			;lvl hero to array value
;~ 			local $startx =$WinPos[0]
;~ 			local $starty =$g2
;~ 			local $endx =$WinPos[0]+200
;~ 			local $endy = $WinPos[1]+$g2+100
;~ 			consolewrite($WinPos[0] &" "& $g2 &" "& $WinPos[0]+200 &" "& $g2+100 & @crlf)
			Local $result = _ImageSearchArea(@WorkingDir & '\hero\lvlup.bmp', 1, $WinPos[0], $g2, $WinPos[0] + 200, $g2 + 100, $lvlx, $lvly, 50)
;~ 			ConsoleWrite("running lvlup check" & $startx &" "& $starty &" "& $endx  &" "&$endy&@crlf)
			If $result = 1 Then

;~ 				ConsoleWrite("Herolvlbutton f hero Nr." & $hero + 1& " Herolvl in db " & $arr[$hero][1] & " " & @crlf)
;~ 				Consolewrite("Check" & $arr[$hero][1] & " <= " & $arr[$hero][0] &" "& $lvlx-$WinPos[0] &" "& $lvly & @crlf)
				Local $levelist = $arr[$hero][1]
				Local $levelsoll = $arr[$hero][0]
;~ 				ConsoleWrite($levelist & " " & $levelsoll & @CRLF)
				If $levelist <> $levelsoll Then
					MouseClick("left", 200, $h, 1, 2)
					MouseClick("left", 232, $h, 1, 2)
					MouseClick("left", 264, $h, 1, 2)
					If $hero <> 19 Then
						MouseClick("left", 296, $h, 1, 2)
						MouseClick("left", 328, $h, 1, 2)
						MouseClick("left", 380, $h, 1, 2)
						MouseClick("left", 412, $h, 1, 2)
						MouseClick("left", 444, $h, 1, 2)
					EndIf
					ConsoleWrite("lvling hero " & $hero + 1 & " " & $lvlx & " " & $lvly - $WinPos[1] & @CRLF)
					Opt("SendKeyDelay", 300)
					Opt("SendKeyDownDelay", 300)
					MClick($lvlx - $WinPos[0], $lvly - $WinPos[1], 1, 0)
					Opt("SendKeyDelay", 100)
					Opt("SendKeyDownDelay", 100)
;~ 					ConsoleWrite("LvlingHero " & $hero + 1 &" Setting herolvl in db to +1" &  @crlf)
					$arr[$hero][1] = $arr[$hero][1] + 1
				EndIf
			EndIf
			If $hero = 26 Then
				ascend()
			EndIf
;~ 			lvlup @ x = 100
		EndIf
	Next
EndFunc   ;==>Herolvl

Func ascend()
	AscendArray()
	For $i = 0 To 250 Step +1
		Opt("SendKeyDelay", 300)
		Opt("SendKeyDownDelay", 300)
		MClick(551, 241, 5, 1); click scrollbar all the way up
		Herolvl()
		Herolvl()
		MClick(551, 500, 5, 1); click scrollbar all the way up
		Herolvl()
		Herolvl()
		MClick(551, 300, 5, 1); click scrollbar all the way up
		Herolvl()
		Herolvl()
		MClick(551, 400, 5, 1); click scrollbar all the way up
		Herolvl()
		Herolvl()
		MClick(551, 550, 5, 1); click scrollbar all the way up
		Herolvl()
		Herolvl()
		MClick(551, 320, 5, 1); click scrollbar all the way up
		Herolvl()
		Herolvl()
		MClick(553, 600, 5, 1); click scrollbar all the way down
		Herolvl()
		Herolvl()
	Next
	If $arr[26][1] = 10 Then
		Opt("SendKeyDelay", 300)
		Opt("SendKeyDownDelay", 300)
		MClick(553, 600, 5, 1); click scrollbar all the way down
		MouseClick("left", 300, 300, 1, 10)
		For $i = 0 To 50 Step +1
			MouseWheel("up", 2)
			Local $hero = 0
			For $hero = 34 To 0 Step -1
				$HeroBmp = $hero + 1
				$HeroBmp &= '.PNG'
				$HeroBmp = @WorkingDir & '\hero\' & $HeroBmp
;~ 		consolewrite($HeroBmp & " " & $arr[$hero]& @crlf)
				;look for Hero names
				Local $result = _ImageSearchArea($HeroBmp, 1, $WinPos[0] + 160, $WinPos[1] + 190, $WinPos[0] + 450, $WinPos[1] + 550, $g1, $g2, 50)
				;look for Hero pieces
				;local $result = _ImageSearchArea($HeroBmp,1,$WinPos[0]+420,$WinPos[1]+190,$WinPos[0]+530,$WinPos[0]+650, $g1, $g2, 140)
				If $result = 1 Then
					If $hero = 19 Then
						Local $h = $g2 - $WinPos[1] + 57 ;######### Ascending
						MouseClick("left", 310, $h, 2, 5)
						MouseClick("left", 490, 445, 2, 5)
						SetArray()
						_FileWriteFromArray("save.txt", $arr)
						ConsoleWrite("KAAATSCHING" &@crlf)
					EndIf
;~ 			lvlup @ x = 100
				EndIf
			Next
		Next
	EndIf
EndFunc   ;==>ascend

Func AscendArray()
	$arr[0][0] = 500; Hero 1 "Cid" LvL up to 100
	$arr[1][0] = 500; Hero 2 "Treebeast" LvL up to 100
	$arr[2][0] = 500; Hero 3 "Ivan The brawler" LvL up to 100
	$arr[3][0] = 500; Hero 4 "Brittany" No need to lvl
	$arr[4][0] = 500; Hero 5 "Wandering Fisherman" lvlup to 100 --> gives click dmg
	$arr[5][0] = 500; Hero 6 "Betty Clicker" Lvlup to 100 gives click DPS
	$arr[6][0] = 500; Hero 7 "The masked samurai" No need to lvl
	$arr[7][0] = 500; Hero 8 "Leon" LVLup 100 25% DPS to all Heros
	$arr[8][0] = 500; Hero 9 "The grand forest seer" No need to lvl
	$arr[9][0] = 500; Hero 10 "Alexa Assassin" LVLup 100

	$arr[10][0] = 500; Hero 11 "Natalia"
	$arr[11][0] = 500; Hero 12 "Mercedes"
	$arr[12][0] = 500; Hero 13 "Bobby"
	$arr[13][0] = 500; Hero 14 "Broyle Lindeoven"
	$arr[14][0] = 500; Hero 15 "Sir George II"
	$arr[15][0] = 500; Hero 16 "King Midas"
	$arr[16][0] = 500; Hero 17 "Referi Jerator"
	$arr[17][0] = 500; Hero 18 "Abaddon" Dark Ritual 1,05% increased dmg
	$arr[18][0] = 500; Hero 19 "Ma Zhu"
	$arr[19][0] = 500; Hero 20 "Amenhotep" Ascension!!!!!

	$arr[20][0] = 200; Hero 21 "Beastlord"
	$arr[21][0] = 200; Hero 22 "Athena"
	$arr[22][0] = 200; Hero 23 "Aphrodite"
	$arr[23][0] = 100; Hero 24 "Shinatobe"
	$arr[24][0] = 100; Hero 25 "Grant the General"
	$arr[25][0] = 75; Hero 26 "Frostleaf"
	$arr[26][0] = 10; Hero 27 "Dread Knight"
	$arr[27][0] = 10; Hero 28 "Atlas"F
	$arr[28][0] = 10; Hero 29 "Terra"
	$arr[29][0] = 10; Hero 30 "Phthalo"

	$arr[30][0] = 10; Hero 31 "Orntchya Gladeye"
	$arr[31][0] = 10; Hero 32 "Lillin"
	$arr[32][0] = 10; Hero 33 "Cadmia"
	$arr[33][0] = 10; Hero 24 "Alabaster"
	$arr[34][0] = 10; Hero 25 "Astraea"
	_FileWriteFromArray("save.txt", $arr)
EndFunc   ;==>AscendArray

Func TogglePause()
	_FileWriteFromArray("save.txt", $arr)
	$paused = Not $paused
	While $paused
		Sleep(100)
		ToolTip('Script is "Paused"', 0, 0)
	WEnd
	ToolTip("")
EndFunc   ;==>TogglePause

Func Terminate()
	_FileWriteFromArray("save.txt", $arr)
	Exit 0
EndFunc   ;==>Terminate
