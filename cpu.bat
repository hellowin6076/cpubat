::내용확인할라믄 on으로
@echo off
::카운터 변수설정
set /a cnt=0

::반복을 위한 라벨 문제는 1초라고 보장은 안해줘 거의 1초단위로 실행하긴해도 정확하게 1초로는 안되는거 
:Re
::포문으로 명령어 실행해서 앞부분 짤르고 변수에 넣어줌
for /f "delims=LoadPercentage= " %%i in ('"wmic cpu get LoadPercentage  /value  |find "P" "') do (
	set Cpu_Use=%%i
)
::변수에 넣은거 출력해주는건데 필요없으면 삭제
echo [CPU : %Cpu_Use%%%]
::변수가 80보다 크면
if %Cpu_Use% GEQ 80 (
	::카운터 1증가
	set /a cnt+=1
	::카운터가 30 넘어가면 메세지
	if %cnt% GEQ 30 (
		::메세지 출력(근데 이부분이 우리집컴으로는 안됬는데 겐바컴으로는 됨 이거때매 시간 오래걸렷어)
		msg * "Enter Your Message"
		::계속 메세지 뜨면 짜증나니까 일단 뜨고 나면 리셋 
		set /a cnt=0
	)
) else (
	::연속으로 안넘어가면 0로 해줌
	set /a cnt=0
)

::날짜, 시간, 씨퓨를 csv파일형태로 넣어줌::로그파일 날짜 설정해줘서 덮어쓰는 식으로 해줌으로 하루넘어가면 다른 날짜로 기록
echo %date% %time%,%Cpu_Use% >> log"%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%".csv
::RE로 가라!!
goto Re