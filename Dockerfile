FROM klakegg/hugo:0.54.0-onbuild AS hugo
MAINTAINER Sysdig Training Team
FROM nginx

COPY --from=hugo /onbuild /usr/share/nginx/html
