-- ���O : Myoga S. Tomonaka
-- Twitter : https://twitter.com/Myoga1012

-- �����������ł��B
function Initialize()
	-- �J�����_�[�̕����X�^�C����ݒ肵�܂��B
	for cur = 0, 41 do
		-- ���j�͐Ԍn�A�y�j�͐n�A�����͔��n�ł��B
		if cur % 7 == 0 then
			SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, 1 ), 'MeterStyle', 'FontDateSun' )
		elseif cur % 7 == 6 then
			SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, 7 ), 'MeterStyle', 'FontDateSat' )
		else
			SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'MeterStyle', 'FontDate' )
		end
		-- ���t��XY���W��ݒ肵�܂��B
		SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'X', 40 * ( cur % 7 ) + 50 )
		SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'Y', 40 * ( math.floor( cur / 7 ) ) + 90 )
	end	
end

Season = { Name = 'Season%d' }
Days = { Name = 'MeterW%dD%d' }

-- ���񏈗��ł��B�X�L���ݒ�t�@�C����[Rainmeter].Update�̎��Ԃ��ƂɌĂяo����܂��B
function Update()
	-- �G�߂ɍ��킹�Ęg�F��ς��܂��B
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
 	-- �X�L���ݒ�t�@�C������N�����j�����擾���A1���̗j���ƌ����������߂܂��B
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
	-- �J�����_�[���o�͂��܂��B
	for curDay = 1, lastDay do
		cur = curDay + prePad - 1
		SKIN:Bang( '!SetOption', Days.Name:format( cur / 7 + 1, cur % 7 + 1 ), 'Text', curDay )
	end	
	return 0
end

-- Calender.lua�i Rainmeter�̃X�L���p �j
-- Copyright (c) 2014 Myoga S. Tomonaka All Rights Reserved.
-- This script is released under the Creative Commons BY-NC-SA 3.0 License.