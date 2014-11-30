-- 名前 : Myoga S. Tomonaka
-- Twitter : https://twitter.com/Myoga1012

-- 初期化処理です。
function Initialize()
	-- カレンダーの文字スタイルを設定します。
	for cur = 0, 41 do
		-- 日曜は赤系、土曜は青系、平日は白系です。
		if cur % 7 == 0 then
			SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, 1 ), 'MeterStyle', 'FontDateSun' )
		elseif cur % 7 == 6 then
			SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, 7 ), 'MeterStyle', 'FontDateSat' )
		else
			SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'MeterStyle', 'FontDate' )
		end
		-- 日付のXY座標を設定します。
		SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'X', 40 * ( cur % 7 ) + 50 )
		SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'Y', 40 * ( math.floor( cur / 7 ) ) + 90 )
	end	
end

Season = { Name = 'Season%d' }
Days = { Name = 'MeterW%dD%d' }

-- 周回処理です。スキン設定ファイルの[Rainmeter].Updateの時間ごとに呼び出されます。
function Update()
	-- 季節に合わせて枠色を変えます。
	SKIN:Bang( '!SetOption', 'MeterBorderTop', 'SolidColor',
		SKIN:GetVariable( Season.Name:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderBottom', 'SolidColor',
		SKIN:GetVariable( Season.Name:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderLeft', 'SolidColor',
		SKIN:GetVariable( Season.Name:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderRight', 'SolidColor',
		SKIN:GetVariable( Season.Name:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	for cur = 0 , 41 do
		SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'Text', '' )
	end
 	-- スキン設定ファイルから年月日曜日を取得し、1日の曜日と月末日を求めます。
	year = SKIN:GetMeasure( 'MeasureDateY' ):GetValue()
	mon = SKIN:GetMeasure( 'MeasureDateM' ):GetValue()
	day = SKIN:GetMeasure( 'MeasureDateDay' ):GetValue()
	date = SKIN:GetMeasure( 'MeasureDateDate' ):GetValue()
	prePad = ( 7 - ( day % 7 + 6 - date ) % 7 ) % 7
	if mon == 2 then
		if year % 4 == 0 then lastDay = 29 else lastDay = 28 end
	else
		if mon <= 7 and mon % 2 ~= 0 or mon >= 8 and mon % 2 == 0 then lastDay = 31 else lastDay = 30 end
	end
	-- カレンダーを出力します。
	for curDay = 1, lastDay do
		cur = curDay + prePad - 1
		SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'Text', curDay )
	end	
	return 0
end

-- Calender.lua（ Rainmeterのスキン用 ）
-- Copyright (c) 2014 Myoga S. Tomonaka All Rights Reserved.
-- This script is released under the Creative Commons BY-NC-SA 3.0 License.