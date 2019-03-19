#!/bin/bash
# Script updates project to work with the latest
# version of Saleor. Please check releases notes before run it.

echo "----- Download latest Saleor release archive -----"
wget https://api.github.com/repos/mirumee/saleor/zipball/2.4.0 -O saleor.zip

echo "----- Unzip archive -----"
unzip -q saleor.zip && mv mirumee-saleor-*/ tmp_saleor

echo "----- Copy directories -----"
\cp -Rf \
    tmp_saleor/saleor \
    tmp_saleor/locale \
    tmp_saleor/templates \
    .

echo "----- Copy files -----"
\cp -Rf \
    tmp_saleor/.editorconfig \
    tmp_saleor/.eslintrc.json \
    tmp_saleor/.gqlconfig \
    tmp_saleor/.npmrc \
    tmp_saleor/.nvmrc \
    tmp_saleor/.pylintrc \
    tmp_saleor/apollo.config.js \
    tmp_saleor/app.json \
    tmp_saleor/package-lock.json \
    tmp_saleor/package.json \
    tmp_saleor/Pipfile \
    tmp_saleor/Pipfile.lock \
    tmp_saleor/requirements_dev.txt \
    tmp_saleor/requirements.txt \
    tmp_saleor/tsconfig.json \
    tmp_saleor/tslint.json \
    tmp_saleor/webpack.config.js \
    tmp_saleor/webpack.d.ts \
    .

echo "----- Cleaning up -----"
rm -rf saleor.zip tmp_saleor

echo "----- Done -----"
