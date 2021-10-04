## 1. appbundle build 하기

#### APP/ucms 로 이동

``` cd APP/ucms ```

#### appbundle 만들기

``` flutter build appbundle ```

## 2. appbundle 로 apks 만들기

#### APP 으로 이동

``` cd .. ```

#### bundletool 사용하여 apks 만들기

``` java -jar ./bundletool-all-1.8.0.jar build-apks --bundle=/workspaces/app_web_IoT_UMCS_Team60/APP/ucms/build/app/outputs/bundle/release/app-release.aab --ouput=/workspaces/app_web_IoT_UMCS_Team60/APP/ucms.apks ```

## 3. 기기 PC 에 연결

아래 링크 참고 

[하드웨어 기기에서 앱 실행](https://developer.android.com/studio/run/device)

## 4. 기기에 apks 설치하기

#### OPTION 1) USB 로 연결된 기기에 apks 옮기기

#### OPTION 2) bundletool 사용하여 apks-install (되는지 확인 못함!)

``` java -jar ./bundletool-all-1.8.0.jar install-apks --apks=/workspaces/app_web_IoT_UMCS_Team60/APP/ucms.apks```