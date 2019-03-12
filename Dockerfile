### Build static assets
FROM node:10 as build-nodejs

ARG STATIC_URL
ENV STATIC_URL ${STATIC_URL:-/static/}

COPY webpack.config.js app.json package.json package-lock.json tsconfig.json tslint.json webpack.d.ts /app/
WORKDIR /app
RUN npm install

# Build static
COPY ./saleor/static /app/saleor/static/
COPY ./templates /app/templates/
RUN STATIC_URL=${STATIC_URL} npm run build-assets --production \
  && npm run build-emails --production

### Final image
# <DOCKER_FROM>
FROM aldryn/base-project:py3-3.25.1
# </DOCKER_FROM>

# <SOURCE>
COPY . /app
# </SOURCE>

RUN apt-get -y update \
  && apt-get install -y gettext \
  # Cleanup apt cache
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install pipenv
COPY ./Pipfile ./Pipfile.lock /app/
WORKDIR /app
RUN pipenv install --system --deploy --dev

ARG STATIC_URL
ENV STATIC_URL ${STATIC_URL:-/static/}

COPY --from=build-nodejs /app/saleor/static /app/static
COPY --from=build-nodejs /app/webpack-bundle.json /app/webpack/
COPY --from=build-nodejs /app/templates /app/templates
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
