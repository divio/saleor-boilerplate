FROM aldryn/base-project:py3-3.25.1

# <SOURCE>
COPY . /app
# </SOURCE>

RUN apt-get update
RUN apt-get -y install curl gnupg
RUN apt-get -y update \
  && apt-get install -y gettext \
  # Cleanup apt cache
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION=10.15.1 \
    NPM_VERSION=6.4.1

ARG STATIC_URL
ENV STATIC_URL ${STATIC_URL:-/static/}

RUN sh /app/build/install.sh
ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules \
      PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

COPY webpack.config.js app.json package.json package-lock.json tsconfig.json tslint.json webpack.d.ts /app/
WORKDIR /app
RUN npm install

# Build static
COPY ./saleor/static /app/saleor/static/
COPY ./templates /app/templates/
RUN STATIC_URL=${STATIC_URL} npm run build-assets --production \
  && npm run build-emails --production

# Install Python dependencies
RUN pip install pipenv
COPY ./Pipfile ./Pipfile.lock /app/
WORKDIR /app
RUN pipenv install --system --deploy --dev

RUN cp -a /app/saleor/static/. /app/static
RUN cp -a /app/webpack-bundle.json /app/webpack/
WORKDIR /app

# Install Python dependencies
RUN pip install pipenv
COPY ./Pipfile ./Pipfile.lock /app/
WORKDIR /app
RUN pipenv install --system --deploy --dev

ENV PIP_INDEX_URL=${PIP_INDEX_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM:-aldryn-baseproject-py3}/+simple/} \
    WHEELSPROXY_URL=${WHEELSPROXY_URL:-https://wheels.aldryn.net/v1/aldryn-extras+pypi/${WHEELS_PLATFORM:-aldryn-baseproject-py3}/}
COPY requirements.* ./
RUN pip-reqs compile && \
    pip-reqs resolve && \
    pip install \
        --no-index --no-deps \
        --requirement requirements.urls

# <STATIC>
RUN DJANGO_MODE=build python manage.py collectstatic --noinput
# </STATIC>
