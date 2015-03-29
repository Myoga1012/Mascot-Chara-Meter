-- ���O : Myoga Screw-bright
-- Twitter : https://twitter.com/Myoga1012


-- �ϐ��̒�`�ł��B

-- �t�H�[�}�b�g�FSeason[( �� + 9 ) % 12 / 3]
-- Season0 : �t�i 3�`5 �j���i 0�`2 �j�� 0
-- Season1 : �āi 6�`8 �j���i 3�`5 �j�� 1
-- Season2 : �H�i 9�`11 �j���i 6�`8 �j�� 2
-- Season3 : �~�i 12�`2 �j���i 9�`11 �j�� 3
season = 'Season%d'

-- �t�H�[�}�b�g�FMeterW[�T]D[�j��]
days = 'MeterW%dD%d'

-- ���݂̔N�����E�j���̕ێ��p�ϐ��ł��B
now = { Year = -1, Month = 0, Day = -1, Date = -1 }


-- �����������ł��B
function Initialize()
	-- �J�����_�[�̕����X�^�C����ݒ肵�܂��B
	for cur = 0, 41 do
		-- ���j�͐Ԍn�A�y�j�͐n�A�����͔��n�ł��B
		if cur % 7 == 0 then
			-- �������format�֐��ŏ����w������邱�Ƃ��ł��܂��B
			SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), 0 ), 'MeterStyle', 'FontDateSun' )
		elseif cur % 7 == 6 then
			SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), 6 ), 'MeterStyle', 'FontDateSat' )
		else
			SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'MeterStyle', 'FontDate' )
		end
		-- ���t��XY���W��ݒ肵�܂��B
		SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'X', 40 * ( cur % 7 ) + 50 )
		SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'Y', 40 * ( math.floor( cur / 7 ) ) + 90 )
	end
	
end

-- ���񏈗��ł��B�X�L���ݒ�t�@�C����[Rainmeter].Update�̎��Ԃ��ƂɌĂяo����܂��B
function Update()

	-- ���݂̔N�����擾���A�ێ��p�̕ϐ��Ɠ�������΁AUpdate�֐����I�����܂��B
	current = { Year = SKIN:GetMeasure( 'MeasureDateY' ):GetValue(), Month = SKIN:GetMeasure( 'MeasureDateM' ):GetValue() }
	if now.Month == current.Month and now.Year == current.Year then
		return 0
	end

	-- ���݂̔N�����ς���Ă�����A���t��g�F�̍X�V���s���܂��B
	now.Year = current.Year
	now.Month = current.Month

	-- �G�߂ɍ��킹�Ęg�F��ς��܂��B
	SKIN:Bang( '!SetOption', 'MeterBorderTop', 'SolidColor',
		SKIN:GetVariable( season:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderBottom', 'SolidColor',
		SKIN:GetVariable( season:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderLeft', 'SolidColor',
		SKIN:GetVariable( season:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
	SKIN:Bang( '!SetOption', 'MeterBorderRight', 'SolidColor',
		SKIN:GetVariable( season:format( math.floor( ( SKIN:GetMeasure( 'MeasureDateM' ):GetValue() + 9 ) % 12 / 3 ) ), '00000000' ) )
 
	-- ���t���N���A���܂��B
	for cur = 0 , 41 do
		SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'Text', '' )
	end
	
 	-- �X�L���ݒ�t�@�C��������E�j�����擾���A�����߁i1���j�̗j���ƌ����������߂܂��B
	-- ���N���͂��ł�current.Year��current.Month�Ŏ擾���Anow.Year��now.Month�ɑ������Ă��܂��B
	now.Day = SKIN:GetMeasure( 'MeasureDateDay' ):GetValue()		-- ��
	now.Date = SKIN:GetMeasure( 'MeasureDateDate' ):GetValue()		-- �j���i ���j�F0�A���j�F1�A�E�E�E�A�y�j�F6 �j
	
	-- ���ݓ��Ƃ��̗j�����瓖�������i1���j�̗j�������߂܂��B
	-- ( now.Day - 1 ) % 7�Ō����߂̗j������j��(0)�������ɑ΂��� now.Day�̗j�������߂܂��B
	-- now.Date + 7����㎮�������A7�̗]��œ��������̗j�������߂邱�Ƃ��ł��܂��B
	prePad = ( now.Date + 7 - ( now.Day - 1 ) % 7 ) % 7

	-- �����������߂܂��B
	if now.Month == 2 then	-- 2���̎�
		if now.Year % 4 == 0 then lastDay = 29 else lastDay = 28 end
	else				-- 2���ȊO�̎�
		-- Lua����̕s�������Z�q�́u~=�v�ł��B�icf: C����Ȃǂł́u!=�v�j
		if now.Month <= 7 and now.Month % 2 ~= 0 or now.Month >= 8 and now.Month % 2 == 0 then lastDay = 31 else lastDay = 30 end
	end
	
	-- �J�����_�[���o�͂��܂��B
	for curDay = 1, lastDay do
		cur = curDay + prePad - 1
		-- �uMeterW%dD%d�v�́u%d�v�ɏT( 0�`5 )�A�j��( 0�`6 )�̃C���f�b�N�X������܂��B
		SKIN:Bang( '!SetOption', days:format( math.floor( cur / 7 ), cur % 7 ), 'Text', curDay )
	end	
	return 0
end

-- Calender.lua�i �}�X�R�b�g�L�����J�����_�[�p�X�N���v�g �j / Ver. 1.15
-- Copyright (C) 2014-2015 Myoga-TN.net All Rights Reserved.
-- This script is released under the Creative Commons BY-NC-SA 4.0 License.