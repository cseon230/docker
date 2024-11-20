# 1. Cloud Native Technologies

## 소프트웨어 아키텍처

- SW를 구성하는 요소와 요소 간의 관계 정의
- 전체 구성 관계, 포함 관계, 호출 관계
- 전반적인 프로덕트를 만드는 과정을 지휘
    - 이해관계자들이 시스템을 이해하는 수준은 모두 다르다.
- Antifragile
    - Auto Scaling
    - Microservice
    - Chaos engineering
    - Continuous deployments

### Cloud Native Architecture

- 확장 가능한 아키텍쳐
- 탄력적 아키텍쳐
- 장애 격리
- MSA Application
- DevOps and CI/CD
- const Efficiency
- innovative Technologies


# 2. Docker Essentials - Container

## 컨테이너 가상화 기술과 Docker

### 가상화 기술의 이해

서버 가상화 방식

: 운영체제 위에 Hypervisor라는 프로그램을 띄우고 그 하이퍼바이저가 우리가 필요로 하는 VM을 실행시켜준다. 즉 호스트PC위에 게스트OS를 가동하는데, 그 가동을 하이퍼바이저가 해준다.

이미지 : 운영체제 자체를 하나의 압축파일처럼 묶어서 사용하는 단위.

컨테이너 가상화

: 가상화를 실행시켜주는 단위가 컨테이너라는 단위로 분리. 컨테이너가 운영체제일 수도 있고 데이터베이스 같은 미들웨어일 수도 있고 파이썬이나 자바같은 웹 서버 같은 형태로 제공될 수도 있다.

컨테이너 런타임은 운영체제가 따로 없다. 따라서 적은 리소스를 가지고 빠른 VM 형태를 운영할 수 있다는 장점이 있다.

도커 그룹끼리 묶어서 네트워크를 함께 쓸 수 있고 두 개의 네트워크 그룹을 격리시킬 수도 있고 두 개의 네트워크를 묶는 세번째 네트워크도 만들 수 있다.

도커 daemon = 도커 서버

도커 컨테이너 = 사용 가능한 인스턴스. 실체화되어 있는 상태.

도커 볼륨 = 데이터 저장소

도커는 리눅스 태생이고, 리눅스 베이스로 실행된다.

### Docker Image 구조

docker image는 변경 불가능한 형태의 단일 파일이다. 이미지를 컨테이너 라는 이름으로 실체화해서 사용해야한다. Docker Hub 사이트에 등록되어 있는걸 사용하거나 독립적인 Docker Registry 저장소를 직접 만들어서 관리한다.

이미지는 다양한 계층구조로 나뉘어 구성되어있다. 이 계층구조를 Layer방식이라고 한다. 여러 개의 Layer를 하나의 파일 시스템으로 사용 가능하다.

도커 이미지를 만들기 위해 확장자가 없는 상태에서 Dockerfile 이라는 파일을 만들어준다. 이름을 바꿔도 상관없지만 기본은 Dockerfile임

Docker image를 생성하기 위한 스크립트 파일

예시

```docker
FROM node:alpine as builder
WORKDIR /app
COPY ./package.json .
RUN npm install
COPY ..
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html/
```

dockerfile 로 이미지를 만들고 그 이미지로 컨테이너화 시킨다

### Docker Container 명령어 - 1

도커 컨테이너의 이해 

- 도커 이미지를 실행한 상태를 “컨테이너” 라고 부른다. (메모리에 올라간 인스턴스를 뜻함)
- 격리 된 시스템 자원 및 네트워크를 사용할 수 있는 독립적인 실행 단위
- 읽기 전용 상태인 이미지에 변경 된 사항을 저장할 수 있는 컨테이너 계층에 저장

이미지가 준비되어 있는 상태에서 `docker run`을 입력하면 컨테이너화 된다. 이 컨테이너는 고유의 ID가 부여된다. 컨테이너 이름을 지정할 수도 있다.

컨테이너의 라이프 사이클

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/6b922040-a4b7-4630-98cc-0c4bd79a53ca/969719ea-f910-475f-bc10-50777ac2ceae/image.png)

mysql 컨테이너 생성.

```java
docker run -d -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD=true --name mysql mysql:5.7
```

- -p 3306:3306 의미 : Docker컨테이너는 외부에서 접근할 수 없는 격리된 네트워크 환경에서 실행된다. -p 옵션을 사용하면 컨테이너 내부의 포트를 호스트 시스템(사용자 컴퓨터)과 연결하여 외부에서 접근 가능하게 만든다. `-p <호스트 포트>:<컨테이너 포트>`
- 3306 표준 포트는 데이터베이스에서 mysql과 mariadb가 기본적으로 사용하는 표준 포트이다

도커는 이미지로 컨테이너를 실행시켰을 때 프로세스가 돌아가는데 없으면 종료된다. 프로세스를 계속 유지하기위해 위해 `-it` 라는 옵션을 작성한다. interactive tty 라는 건데, 입력을 계속 받도록 세션을 열여두는 것이다.

컨테이너의 Name을 지정해주지 않으면 무작위로 Name이 생성된다.

```java
docker run -d -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true —name my-mariadb mariadb
```

- —name my-mariadb : 컨테이너 이름을 지정하는 옵션
- mariadb : 이 컨테이너가 사용할 이미지를 지정

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/6b922040-a4b7-4630-98cc-0c4bd79a53ca/4f2b7cef-ecd5-4c93-b7de-59cae87a927d/image.png)

- docker container ls : docker ps 와 동일. 컨테이너의 목록을 나타낸다
- docker container stop : 컨테이너 중지
- docker container rm : 컨테이너 삭제
- docker container logs : 특정 컨테이너의 로그를 확인. -f 는 로그를 실시간으로 출력
- docker container exec : 실행 중인 컨테이너 내부에서 명령어 실행
- docker container inspect : 특정 컨테이너에 대한 자세한 정보 출력
- docker image ls : 다운로드된 모든 이미지 조회
- docker image rm : 특정 이미지 삭제
- docker image pull : Docker hub 또는 레지스트리에서 이미지 다운로드
- docker system prune : 사용하지 않는 Docker 리소스 정리. 삭제 대상은 중지된 컨테이너, 사용하지 않는 네트워크, Dangling이미지(태그 없는 이미지), 사용하지 않는 볼륨

### Port Mapping

도커 컨테이너에서 사용하고자 하는 Port를 자유롭게 설정 가능함

호스트 시스템에서 도커 컨테이너 Port를 사용하기 위해서는 Port Mapping이 필요하다.

```docker
$ docker run -p 80:8080 <IMAGE NAME>
```

-p : Port Mapping 의 줄임

호스트PC의 포트를 80으로 설정하고 컨테이너포트를 8080으로 설정함.

```docker
$ docker run -p 80:80 nginx
```

nginx는 기본적으로 80 이라는 포트를 가지고 서비스되고 있다. 주소창에 포트번호를 입력하지 않으면 기본적으로 80이라는 포트값이 설정된다. 

**HTTP 프로토콜 포트 : 80**

**HTTPS 프로토콜 포트 : 443**

```docker
docker run nginx
```

위 명령어를 입력하면 nginx 이미지를 다운로드 받고 컨테이너를 실행한다. 기본적으로 nginx 는 80번 포트에서 HTTP 서버를 실행한다.

```docker
docker exec -it [containerID] bash
```

위 명령어를 입력하여 컨테이너 내부로 접속한다. 컨테이너 내부는 리눅스 환경과 유사하며, nginx 웹 서버가 이미 실행 중이다.

```docker
curl http://127.0.0.1
```

curl 명령어는 특정 URL로 HTTP 요청을 보내고 그 응답 내용을 출력한다. http://127.0.0.1 은 **컨테이너 내부에서 자신**을 의미하고, 현재 실행 중인 nginx 서버에 요청을 보낸 것이다.

컨테이너 내부는 기본적으로 외부에서 접근이 불가능하다. 외부에서 nginx서버에 접속하려면, 컨테이너의 포트를 호스트 머신에 매핑해야 한다.

```docker
docker run -d -p 8080:80 nginx
```

위 명령어는 호스트 8080 포트를 컨테이너의 80 포트에 연결한다. 따라서, 브라우저에서 http://localhost:8080으로 접속하면 nginx 기본 페이지를 볼 수 있다.

localhost는 기본적으로 127.0.0.1 로 매핑된다. 두 주소는 같은 의미를 가진다.

**127.0.0.1 주소는 루프백 IP 주소다. 컴퓨터 자신을 가리킨다.**

네트워크 요청을 컴퓨터 외부로 보내지 않고 자신에게 돌려보내는 역할을 한다.

외부에서 컨테이너 DB로 접속

```docker
$ docker run -d -p 3307:3306 -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true --name my-mariadb mariadb
```

사용자가 3307 포트로 요청을 보내면 docker daemon이 그것을 3306으로 포워딩해준다. 컨테이너의 응답도 3306 포트에서 3307 포트로 반환된다.