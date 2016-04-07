#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance ;同じスクリプトを複数起動できないようにする
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;メインループ
Loop
{
	;Factorio.exeが起動しているか
	IfWinExist, ahk_exe Factorio.exe
	{
		;@が入力されるまで5秒待つ．もしチャット開始キーが違う場合は最後の@の部分をそのキーに変更
		Input ,Key,T5V,@
		;タイムアウトの場合
		If ErrorLevel = Timeout
			Continue
	}Else{
		;ループから抜ける
		Break
	}

	;Factorio.exeがアクティブだった場合
	IfWinActive, ahk_exe Factorio.exe
	{
		;入力のボックスを表示させる
		InputBox, OutputVar , チャット入力, 文字を入力してください, , 375, 130

		;ウィンドウフォーカスをFactorio.exeに変更
		Process,Exist,Factorio.exe
		If ErrorLevel<>0
			WinActivate,ahk_pid %ErrorLevel%

		;クリップボードに取得した文字列を代入
		clipboard = %OutputVar%
		;キー入力
		Send, ^v
		Send,{Enter}
	}
}

;プログラム終了
ExitApp