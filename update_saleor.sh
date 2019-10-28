#!/bin/bash
# Script updates project to work with the latest
# version of Saleor. Please check releases notes before run it.

echo "----- Download latest Saleor release archive -----"
wget https://api.github.com/repos/mirumee/saleor/zipball/2.9.0 -O saleor.zip

echo "----- Unzip archive -----"
unzip -q saleor.zip && mv mirumee-saleor-*/ tmp_saleor

echo "----- Copy directories -----"
rm -rf saleor/
rm -rf locale/
rm -rf templates/
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
rm -rf templates/templated_email/compiled/.gitkeep
rm -rf saleor.zip tmp_saleor
# rm -rf Pipfile Pipfile.lock requirements.txt requirements_dev.txt
find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

echo "Manually implement the 'saleor/settings.py' changes to 'settings.py'"
echo "Manually implement the 'saleor/urls.py' changes to 'urls.py'"
echo "Manually generate requirements.in from: https://pypi.org/project/pipenv-to-requirements/"
echo "Manually update the requirements.in file as there are some special cases"
echo "Check the changelog for further adaptions: https://github.com/mirumee/saleor"
echo "----- Done -----"
