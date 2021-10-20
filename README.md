# UMCS(untact movement control system) 
### 비대면이동통제시스템
![image](https://user-images.githubusercontent.com/28801695/137842853-77403590-036b-4f38-9bfb-480d93c263c4.png)

</p>
<p align="center">
	<a href="https://github.com/osamhack2021/app_web_IoT_UMCS_Team60/search?l=JavaScript&type=code"><img alt="GitHub language count" src="https://img.shields.io/github/languages/count/osamhack2021/app_web_IoT_UMCS_Team60"></a>
	<a href="https://github.com/osamhack2021/app_web_IoT_UMCS_Team60/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/osamhack2021/app_web_IoT_UMCS_Team60?color=success"></a>
	<a href="https://github.com/osamhack2021/app_web_IoT_UMCS_Team60/blob/main/LICENSE"><img alt="GitHub license" src="https://img.shields.io/github/license/osamhack2021/app_web_IoT_UMCS_Team60"></a>
</p>
</p>
<p align="center">
	<a href="https://team60.gitbook.io/militaryumcs/"><img src='https://img.shields.io/badge/DOCUMENT-blue?style=for-the-badge'></a>
	<a href="https://github.com/osamhack2021/app_web_IoT_UMCS_Team60"><img src='https://img.shields.io/badge/VIDEO-blue?style=for-the-badge'></a>
</p>

### APP, WEB 로고
<table><tbody>
 <tr>
  <td>
   <div align="center"> <img src="https://user-images.githubusercontent.com/28801695/137842313-936caec0-67ff-4b50-a336-b816bbb46c65.png" width="270" height="270"/> </div>
  </td>
 </tr>
 </tbody></table>



## UMCS 프로젝트 소개
### :mask: 배경
- 끝나지 않는 코로나, 예방적인 **실시간 비대면 유동병력 관리 개선** 필요성 증대
- 평시에도 코로나 대비 관리가 필요하며 **집단 확진** 시 **코호트격리로 병력 관리의 어려움**으로 인한 솔루션 필요
### :key: 목적
- 평시 코로나 대비 유동병력 관리와 집단확진 시 효과적인 코호트 격리를 할 수 있는 시스템 제공
- **비대면 이동 보고**, **실시간 병력 현황 확인 및 관리**, **코호트 격리 기능**으로 통합 솔루션 개발
### :computer: 시스템
- 군부대 보안으로 인해 **사진과 GPS를 사용이 불가**하므로 각 시설에 **블루투스 IoT** 설치로 **실시간 위치 파악**
- 병사들은 **APP으로 비대면보고 및 위치 전송**하며 간부는 **WEB으로 실시간 병력관리** 및 격리 편리 제공


## 시스템 구성도
![오픈소스로 구성된 시스템](https://user-images.githubusercontent.com/28801695/135297278-a9e6bc05-35f4-4896-ace6-8f75a90bd685.jpg)


## 기능 설명
![image](https://user-images.githubusercontent.com/28801695/137847000-9a8856d9-4d9d-45c0-af3e-4988a6236ff8.png)<br><br>
![image](https://user-images.githubusercontent.com/28801695/137847063-02f300fe-e201-4640-94df-84ef775d087f.png)<br><br>
![image](https://user-images.githubusercontent.com/28801695/137847123-5cbee7a3-98a5-42bc-b436-dfb87dc07816.png)<br><br>
![image](https://user-images.githubusercontent.com/28801695/137847184-111a8eb5-6da1-45e6-baba-bc24541241b0.png)<br><br>
![image](https://user-images.githubusercontent.com/28801695/137847248-09834e6a-a65e-497c-b344-d3dc587348f6.png)<br><br>



## 컴퓨터 구성 / 필수 조건 안내 (Prerequisites)
### 웹 최소 사양
- ECMAScript 6 지원 브라우저 사용
- 권장: Google Chrome Version 77 이상, Edge Version 93 이상

### 앱 최소 사양
- 최소사양: Android 5.0(API 21) 이상
- 권장: Android 8.0(API 26) 이상

### 서버 최소 사양
- Node.js 14.18 이상 
- Operating Systems
    - Ubuntu (16.04/18.04/20.04)
- Database
    - Mysql 8.0 이상

## 기술 스택 (Technique Used) 
### Infra
<table><tbody>
 <tr>
  <td>
   <div align="center"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" width="40" height="40"/> <br>Git</div>
  </td>
  <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-original.svg" width="40" height="40"/><br>Docker</div>
  </td>
    <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/amazonwebservices/amazonwebservices-original.svg" width="40" height="40"/><br>AWS</div>
  </td>
      <td>
   <div align="center"><img src="https://icon-library.com/images/web-application-firewall-icon/web-application-firewall-icon-21.jpg" width="40" height="40"/><br>WAF</div>
  </td>
      <td>
   <div align="center"><img src="https://www.pngkey.com/png/detail/898-8981784_aws-codedeploy-logo-png-transparent-aws-code-deploy.png" width="40" height="40"/><br>codepipeline</div>
  </td>
 </tr>
 </tbody></table>
 
### Backend
<table><tbody>
 <tr>
   <td>
   <div align="center"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg" width="40" height="40"/> <br>MySQL</div>
  </td>
  <td>
   <div align="center"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/nodejs/nodejs-original-wordmark.svg" width="40" height="40"/> <br>Node.js</div>
  </td>
  <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/express/express-original-wordmark.svg" width="40" height="40"/><br>Express</div>
  </td>
    <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg" width="40" height="40"/><br>Javascript</div>
  </td>
      <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/linux/linux-original.svg" width="40" height="40"/><br>Linux</div>
  </td>
      <td>
   <div align="center"><img src="https://img.stackshare.io/service/8309/advancedRESTclient.png" width="40" height="40"/><br>ARC</div>
  </td>
  <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/socketio/socketio-original.svg" width="40" height="40"/><br>socket.io</div>
  </td>
  <td>
<div align="center"> <img src="https://jwt.io/img/pic_logo.svg" alt="jwt" width="40" height="40"/><br>JWT</div>
  </td>
    <td>
   <div align="center"><img src="https://leolanchas.com/wp-content/uploads/2013/07/0d184ee3-fd8d-4b94-acf4-b4e686e57375.png" height="40"/><br>passport.js</div>
  </td>
  
 </tr>
 </tbody></table>

### Frontend - web
<table><tbody>
 <tr>
  <td>
   <div align="center"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vuejs/vuejs-original.svg" height="40"/> <br>Vue</div>
  </td>
  <td>
   <div align="center"> <img src="https://yamoo9.github.io/vuex/images/vuex.png" width="40" height="40"/> <br>Vuex</div>
  </td>
  <td>
   <div align="center"> <img src="https://seeklogo.com/images/V/vuetify-logo-3BCF73C928-seeklogo.com.png" height="40"/> <br>Vuetify</div>
  </td>
  <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg" height="40"/><br>HTML</div>
  </td>
    <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/css3/css3-original.svg" height="40"/><br>CSS</div>
  </td>
  <td>
   <div align="center"> <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Sass_Logo_Color.svg/1200px-Sass_Logo_Color.svg.png" height="40"/> <br>SCSS</div>
  </td>
  <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg" height="40"/><br>JavaScript</div>
  </td>
  <td>
   <div align="center"> <img src="https://seeklogo.com/images/E/eslint-logo-DDFB6EBCF6-seeklogo.com.png" height="40"/> <br>Eslint</div>
  </td>
  <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/socketio/socketio-original.svg" height="40"/><br>socket.io</div>
  </td>      
  <td>
   <div align="center"><img src="https://leolanchas.com/wp-content/uploads/2013/07/0d184ee3-fd8d-4b94-acf4-b4e686e57375.png" height="40"/><br>passport.js</div>
  </td>
 </tr>
 </tbody></table>
 
### Frontend - app
<table><tbody>
 <tr>
  <td>
   <div align="center"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" width="40" height="40"/> <br>Flutter</div>
  </td>
  <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg" width="40" height="40"/><br>Dart</div>
  </td>
    <td>
<div align="center"> <img src="https://jwt.io/img/pic_logo.svg" alt="jwt" width="40" height="40"/><br>JWT</div>
  </td>
    <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg" width="40" height="40"/><br>Javascript</div>
  </td>
    <td>
   <div align="center"><img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/socketio/socketio-original.svg" width="40" height="40"/><br>socket.io</div>
  </td>      
 </tr>
 </tbody></table>
 
 ### IoT
<table><tbody>
 <tr>
  <td>
   <div align="center"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/arduino/arduino-original.svg" width="40" height="40"/> <br>Arduino</div>
  </td>
 </tr>
 </tbody></table>


## 설치 안내 (Installation Process)
 
 [Server 설치 안내](./WEB/Server/README.md)
 
 [WEB 설치 안내](./WEB/umcs-web/readme.md)

 [APP 설치 안내](./APP/README.md)

 [DB 설치 안내](./DB/README.md)
 


## 프로젝트 사용법 (Getting Started)
본 시스템은 부대 단위로 도입되게 됩니다.

1. 부대 시설 간 비콘 설치

용사들의 이동 보고를 받고 싶은 곳들에 블루투스 비콘을 설치합니다. 각 비콘들의 mac 주소를 종합하여 서버에 등록합니다.

2. 당직근무자 WEB page 등록

위에서 서술한 바와 같이 서버를 부대 단위로 새로 개설하고, 이곳에 당직근무자를 추가합니다. 관리자는 각 비콘들의 mac 주소와 기본 사용자 정보를 서버에 입력해 넣습니다. 

3. 용사 등록

용사들은 개개인의 휴대폰에 본 APP 버전을 설치하고, 각각 회원가입을 통해 사용자 등록을 합니다. 



 
## 팀 정보 (Team Information)
|이름|역할|소개|github|이메일
|:-------:|:---:|:---------:|:---:|:---:|
|박재형<br>중위|팀장,infra 담당(DB,AWS)|아주대 졸, 무선통신 전공|<a href="https://github.com/namingsense"> <img src="http://img.shields.io/badge/-green?style=social&logo=github"/>|<a href="mailto:skyvieweye@gmail.com"> <img src="https://img.shields.io/badge/skyvieweye@gmail.com-green?logo=gmail&style=social">
|김명승<br>병장|IoT,backend 담당<br>(Arduino, Node.js)|중앙대 2학년 휴학,<br> 소프트웨어학부|<a href="https://github.com/mskim9967"> <img src="http://img.shields.io/badge/-green?style=social&logo=github"/> |<a href="mailto:mskim9967@gmail.com"> <img src="https://img.shields.io/badge/mskim9967@gmail.com-green?logo=gmail&style=social"> |
|최경민<br>상병|app-frontend 담당(Flutter)| 광주과기원 1학년 휴학,<br>기초교육학부(자유전공)  |<a href="https://github.com/2ood"> <img src="http://img.shields.io/badge/-green?style=social&logo=github"/> |<a href="mailto:kyungmin.official0@gmail.com"> <img src="https://img.shields.io/badge/kyungmin.official0@gmail.com-green?logo=gmail&style=social"> |
|정재욱<br>상병|web-frontend 담당(Vue.js)| 아주대 2학년 휴학<br>소프트웨어학과 전공 |<a href="https://github.com/Wo-ogie"> <img src="http://img.shields.io/badge/-green?style=social&logo=github"/> | <a href="mailto:siwall0105@gmail.com"> <img src="https://img.shields.io/badge/siwall0105@gmail.com-green?logo=gmail&style=social">| 

## 저작권 및 사용권 정보 (Copyleft / End User License)
 [Apache 2.0](https://github.com/osamhack2021/app_web_IoT_UMCS_Team60/blob/main/license.md)

This project is licensed under the terms of the Apache 2.0 license.

### 오픈소스 인용 정보

[APP 오픈소스 인용 정보](APP/open_source.md)

[WEB 오픈소스 인용 정보](WEB/open_source.md)

[SERVER 오픈소스 인용 정보](https://github.com/osamhack2021/app_web_IoT_UMCS_Team60/blob/main/WEB/open_source.md#back-end)

[IoT 오픈소스 인용 정보](IoT/open_source.md)

[기타 프로젝트 간 오픈소스 인용 정보](open_source.md)
