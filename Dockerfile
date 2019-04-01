FROM aldryn/base-project:py3-3.25.1

# <SOURCE>
COPY . /app
# </SOURCE>

RUN apt-get update && \
    apt-get -y install curl gnupg gettext && \
    # Cleanup apt cache
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG STATIC_URL
ENV STATIC_URL ${STATIC_URL:-/static/}

# <NODE>
ADD build /stack/boilerplate

ENV NODE_VERSION=10.15.1 \
    NPM_VERSION=6.4.1

RUN bash /stack/boilerplate/install.sh

ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules \
      PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
# </NODE>

WORKDIR /app

# install node dependencies
RUN npm install
RUN STATIC_URL=${STATIC_URL} && \
    npm run build-assets --production && \
    npm run build-emails --production
RUN cp -a /app/saleor/static/. /app/static
RUN cp -a /app/webpack-bundle.json /app/webpack/

# install python dependencies
RUN pip install pipenv
RUN pipenv install --system --deploy --dev

ENV PIP_INDEX_URL=${PIP_INDEX_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM:-aldryn-baseproject-py3}/+simple/} \
    WHEELSPROXY_URL=${WHEELSPROXY_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM:-aldryn-baseproject-py3}/}
RUN pip-reqs compile && \
    pip-reqs resolve && \
    pip install \
        --no-index --no-deps \
        --requirement requirements.urls

# <STATIC>
RUN DJANGO_MODE=build python manage.py collectstatic --noinput
# </STATIC>
