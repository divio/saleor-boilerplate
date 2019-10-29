# <WARNING>
# Everything within sections like <TAG> is generated and can
# be automatically replaced on deployment. You can disable
# this functionality by simply removing the wrapping tags.
# </WARNING>

# <DOCKER_FROM>
FROM divio/base:4.15-py3.6-slim-stretch
# </DOCKER_FROM>

# <NODE>
ADD build /stack/boilerplate

ENV NODE_VERSION=10.15.1 \
    NPM_VERSION=6.4.1

RUN bash /stack/boilerplate/install.sh

ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules \
      PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
# </NODE>

# install node dependencies
COPY webpack.config.js app.json package.json package-lock.json /app/
RUN npm install

# build static files
COPY ./saleor/static /app/saleor/static/
COPY ./templates /app/templates/

ENV STATIC_URL ${STATIC_URL:-/static/}

RUN npm run build-assets --production && \
    npm run build-emails --production

RUN mkdir -p /app/media /app/static /app/webpack
RUN cp -a /app/saleor/static/. /app/static
RUN cp -a /app/webpack-bundle.json /app/webpack

# <PYTHON>
ENV PIP_INDEX_URL=${PIP_INDEX_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM:-aldryn-baseproject-py3}/+simple/} \
    WHEELSPROXY_URL=${WHEELSPROXY_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM:-aldryn-baseproject-py3}/}
COPY requirements.* /app/
COPY addons-dev /app/addons-dev/
RUN pip-reqs compile && \
    pip-reqs resolve && \
    pip install \
        --no-index --no-deps \
        --requirement requirements.urls
# </PYTHON>

# <SOURCE>
COPY . /app
# </SOURCE>

# <STATIC>
RUN DJANGO_MODE=build python manage.py collectstatic --noinput
# </STATIC>
