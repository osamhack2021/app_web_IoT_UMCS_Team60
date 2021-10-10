# Purpose
Arduino UNO보드를 Andriod, iOS 모두 인식할 수 있는 **iBeacon interface**로 제작한다.


# Materials
- Arduino UNO
- HM-10
- jumper wire


# HW Making
1. HM-10 모듈과 UNO보드의 VCC와 GND를 연결시킨다.
2. HM-10의 RXD를 UNO의 2번, TXD를 3번으로 연결시킨다.


# SW Making
1. beacon.ino를 UNO보드에 업로드한다.
2. Serial Monitor에 아래 명령어를 입력하여 iBeacon interface로 변경한다.
   ```js
   // 공장 초기화
   AT+RENEW 
   // Major Number 설정
   AT+MARJ0x1234
   // Minor Number설정
   AT+MINO0xFA01
   // 신호 송출 주기를 5로 설정
   AT+ADVI5 
   // 이름 설정
   AT+UMCSBEACON
   // 개별 블루투스 연결 불가능한 상태로 변경
   AT+ADTY3 
   //iBeacon 활성화
   T+IBEA1 
   // iBeacon 브로드캐스트 전용 모드로 설정
   AT+DELO2
   // 최소 절전 모드 설정
   AT+PWRM0 
   // 재시작
   AT+RESET
   ```