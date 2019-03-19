#!/bin/bash
# Script updates project to work with the latest
# version of Saleor. Please check releases notes before run it.

echo "----- Download latest Saleor release archive -----"
wget https://github.com/mirumee/saleor/zipball/master -O tmp.zip

echo "----- Unzip archive -----"
mkdir tmp && unzip tmp.zip
cp -R mirumee-saleor-*/* tmp

echo "----- Copy Saleor app -----"
cp -R tmp/saleor .

echo "----- Copy other needed files to root -----"
cp -R apollo.config.js tslint.json tsconfig.json \
   webpack.config.js webpack.d.ts app.json \
   Pipfile Pipfile.lock Procfile package.json \
   package-lock.json requirements.txt \
   requirements_dev.txt locale templates .

echo "----- Removing tmp files -----"
rm -rf tmp.zip tmp mirumee-saleor-*
echo "----- Done -----"
