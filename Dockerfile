FROM node:alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

# FROM부터 다음 FROM까지 모두 builder라는 것을 명시해준다.
# 여기서는 빌드파일을 생성하고 이를  /usr/src/app/build에 들어간다

FROM nginx
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# run stage에서는 Ngnix를 가동하고 이를 위한 베이스 이미지를 가져오고 
# --from-builder는 다른 스테이지에 있는 파일을 복사할 때 다르 stage 이름을 명시
# /usr/src/app/build에 있는 파일을 /usr/share/ngnix/html로 복사하여 ngnix가 웹브라우저의 http요청이 올 때마다 알맞은 파일을 전해줄 수 있도록 함.
# 이 경로에 파일을 넣어두면 ngnix가 웹 브라우저에 알맞은 파일을 제공할 수 있다. 그렇다.


# 빌드 파일을 생성하기 위함
# npm run build로 생성한 빌드 파일을 Nginx 서버가 브라우저에서 보일 수 있게 해준다.

# 운영 환경을 위한 Dockerfile 
# 1. build stage 빌드 파일 생성
# 2. Ngnix를 가동하고 생성된 빌드폴더의 파일을 웹 브라우저의 요청에 따라 제공한다. = Run stage
# 제발 좀 되라 wpqkfwpqkf