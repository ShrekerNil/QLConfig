@echo off
echo ~~~~~~~~~~~~~~~~~~~~~~~
echo ~ ��ѹ��MySQL��װ�ű� ~
echo ~~~~~~~~~~~~~~~~~~~~~~~

echo ֹͣmysql����������ڣ�
net stop mysql

rem ���²���·��
echo ��ǰ�̷���%~d0 
echo ��ǰ�̷���·����%~dp0
echo ��ǰ������ȫ·����%~f0
echo ��ǰ�̷���·���Ķ��ļ�����ʽ��%~sdp0
echo ��ǰCMDĬ��Ŀ¼��%cd%

set mypath=%~dp0
set mypath=%mypath:\=\\%
echo �������ļ�����·��תΪ˫б�ܶ���: %mypath%
echo ��ǰ��������������·��ת����: %cd:\=\\%

rem �ҵ���ǰ·��
rem ��temp.txt�ļ������ݿ�����temp.bat�ļ���
rem temp.txt�ļ��е������ǡ�set PathTemp=��
rem �ر�ע�⣺��=�����治�ܼӻس�
copy temp.txt temp.bat

rem ��·����ӵ�temp.bat�ļ���
cd>>temp.bat

rem ִ��temp.bat�ļ�������
rem temp.bat�ļ�ִ�к�·���Ѿ�������PathTemp������
call temp.bat

rem ɾ��temp.bat�ļ�
rem del temp.bat

rem ���� my-default.ini�ļ�
copy my-default.ini my.ini

rem ����my.ini�ı��λ
set tag=[mysqld]

rem ������ӵ�my.ini�ļ��е����ݿ�·��������·��
rem set datadir=datadir=%PathTemp%\data����˼�ǣ�
rem ���ַ�����datadir=��������PathTemp��Ӧ���ַ����Լ��ַ�����\data����ֵ��datadir����
set basedir=basedir=%PathTemp:\=\\%
set datadir=datadir=%PathTemp:\=\\%\data

rem �������л�������homedir
set homedir=%PathTemp%\bin

rem ���ñ����ӳ�
rem ע�⣺ʹ�ñ����ӳٺ���ر����ã�����Χ���������������ȷʶ��
setlocal enabledelayedexpansion

rem ѭ������my.ini�ļ��е�����
for /f "tokens=*" %%i in (my.ini) do (

rem ����my-default.ini�ļ��ж������ַ�������ֵ������p
set p=%%i

rem �������p�����ݺ�my-default.ini�ı��λ��ͬ
rem ������p������д��my.ini�ļ��У�ͬʱ�����������������ݣ�
rem basedir�����ݺ�datadir�����ݣ�
rem �����ͬ��ֻ������p������д��my.ini�ļ���
if "!p!"== "%tag%" (
echo !p!>>my.ini
echo !basedir!>>my.ini
echo !datadir!>>my.ini
echo #������ѯ����>>my.ini
echo explicit_defaults_for_timestamp=true>>my.ini 
)
if not "!p!"== "%tag%" echo !p!>>my.ini
)
rem TIMESTAMP with implicit DEFAULT value is deprecated
rem ����ɾ��mysql���������
set uninstallcmd=.\bin\mysqld.exe remove mysql
rem ����ɾ������
call !uninstallcmd!

rem ���ð�װmysql���������
set installcmd=.\bin\mysqld.exe -install mysql

rem ���ð�װ����
call !installcmd!

rem ����mysql����
net start mysql

rem ����update.sql�ļ��е�sql��䣬��mysql��Զ�̷��ʷ�ʽ�򿪣��Ա�Զ�̷��ʷ�������
rem ͬʱ����mysql��������ģ������������mysql�������Ϊroot
.\bin\mysql -u root <.\update.sql

rem ����mysql����
net stop mysql
net start mysql
echo ����ִ����ϣ�����������˳����򡣡���
pause>nul
