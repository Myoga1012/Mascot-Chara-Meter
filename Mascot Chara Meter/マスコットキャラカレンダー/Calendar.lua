-- 名前 : Myoga Screw-bright
-- Twitter : https://twitter.com/Myoga1012


-- 変数の定義です。

-- フォーマット：Season[( 月 + 9 ) % 12 / 3]
-- Season0 : 春（ 3～5 ）→（ 0～2 ）→ 0
-- Season1 : 夏（ 6～8 ）→（ 3～5 ）→ 1
-- Season2 : 秋（ 9～11 ）→（ 6～8 ）→ 2
-- Season3 : 冬（ 12～2 ）→（ 9～11 ）→ 3
season = 'Season%d'

-- フォーマット：MeterW[週]D[曜日]
days = 'MeterW%dD%d'

-- 現在の年月日・曜日の保持用変数です。
now = { Year = -1, Month = 0, Day = -1, Date = -1 }


-- 初期化処理です。
function Initialize()
	-- カレンダーの文字スタイルを設定します。
	for cur = 0, 41 do
		-- 日曜は赤系、土曜は青系、平日は白系です。
		if cur % 7 == 0 then
			-- 文字列はformat関数で書式指定をすることができます。
			SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), 0 ), 'MeterStyle', 'FontDateSun' )
		elseif cur % 7 == 6 then
			SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), 6 ), 'MeterStyle', 'FontDateSat' )
		else
			SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'MeterStyle', 'FontDate' )
		end
		-- 日付のXY座標を設定します。
		SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'X', 40 * ( cur % 7 ) + 50 )
		SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'Y', 40 * ( math.floor( cur / 7 ) ) + 90 )
	end
	
end

-- 周回処理です。スキン設定ファイルの[Rainmeter].Updateの時間ごとに呼び出されます。
function Update()

	-- 現在の年月を取得し、保持用の変数と等しければ、Update関数を終了します。
	current = { Year = SKIN:GetMeasure( 'MeasureDateY' ):GetValue(), Month = SKIN:GetMeasure( 'MeasureDateM' ):GetValue() }
	if now.Month == current.Month and now.Year == current.Year then
		return 0
	end

	-- 現在の年月が変わっていたら、日付や枠色の更新を行います。
	now.Year = current.Year
	now.Month = current.Month

	-- 季節に合わせて枠色を変えます。
	SKIN:Bang( '!SetOption', 'MeterBorderTop', 'SolidColor',
		SKIN:GetVariable( season:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderBottom', 'SolidColor',
		SKIN:GetVariable( season:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderLeft', 'SolidColor',
		SKIN:GetVariable( season:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderRight', 'SolidColor',
		SKIN:GetVariable( season:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
 
	-- 日付をクリアします。
	for cur = 0 , 41 do
		SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'Text', '' )
	end
	
 	-- スキン設定ファイルから日・曜日を取得し、月初め（1日）の曜日と月末日を求めます。
	-- ※年月はすでにcurrent.Yearとcurrent.Monthで取得し、now.Yearとnow.Monthに代入されています。
	now.Day = SKIN:GetMeasure( 'MeasureDateDay' ):GetValue()		-- 日
	now.Date = SKIN:GetMeasure( 'MeasureDateDate' ):GetValue()		-- 曜日（ 日曜：0、月曜：1、・・・、土曜：6 ）
	
	-- 現在日とその曜日から当月初日（1日）の曜日を求めます。
	-- ( now.Day - 1 ) % 7で月初めの曜日を日曜日(0)した時に対する now.Dayの曜日を求めます。
	-- now.Date + 7から上式を引き、7の余剰で当月初日の曜日を求めることができます。
	prePad = ( now.Date + 7 - ( now.Day - 1 ) % 7 ) % 7

	-- 月末日を求めます。
	if now.Month == 2 then	-- 2月の時
		if now.Year % 4 == 0 then lastDay = 29 else lastDay = 28 end
	else				-- 2月以外の時
		-- Lua言語の不等価演算子は「~=」です。（cf: C言語などでは「!=」）
		if now.Month <= 7 and now.Month % 2 ~= 0 or now.Month >= 8 and now.Month % 2 == 0 then lastDay = 31 else lastDay = 30 end
	end
	
	-- カレンダーを出力します。
	for curDay = 1, lastDay do
		cur = curDay + prePad - 1
		-- 「MeterW%dD%d」の「%d」に週( 0～5 )、曜日( 0～6 )のインデックスが入ります。
		SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'Text', curDay )
	end	
	return 0
end

-- Calender.lua（ マスコットキャラカレンダー用スクリプト ） / Ver. 1.15
-- Copyright (C) 2014-2015 Myoga-TN.net All Rights Reserved.
-- This script is released under the Creative Commons BY-NC-SA 4.0 License.