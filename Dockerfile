# Node.js 표준 이미지 사용
FROM node:alpine

# Alpine 환경일 경우 빌드 도구 설치
# RUN apk add --no-cache python3 make g++

# 작업 디렉토리 설정
WORKDIR /home/app

# 종속성 파일 복사
COPY ./my-nodejs/package.json ./package.json

# npm 최신 버전 설치 (선택 사항)
RUN npm install -g npm@latest

# npm install 실행
RUN npm install --legacy-peer-deps

# 애플리케이션 파일 복사
COPY ./my-nodejs/app.js ./app.js

# 애플리케이션 실행
CMD ["node", "app.js"]
