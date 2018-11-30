#!/bin/bash
if [ -e './tempde.json' ]; then 
	mv ./tempde.json ./de.json
fi &&

if [ -e './tempen.json' ]; then 
	mv ./tempen.json ./en.json
fi &&
if [ -e './tempel.json' ]; then 
	mv ./tempel.json ./el.json
fi &&
if [ -e './tempes.json' ]; then 
	mv ./tempes.json ./es.json
fi &&
if [ -e './es.json' ]; then
	cp -i -r ~/Documents/csvAndJsonHandler/app/assets/convert_Temps/es.json ~/Documents/beat-ya/src/assets/i18n/es.json
fi &&
if [ -e './el.json' ]; then
	cp -i -r ~/Documents/csvAndJsonHandler/app/assets/convert_Temps/el.json ~/Documents/beat-ya/src/assets/i18n/el.json
fi &&
if [ -e './en.json' ]; then
	cp -i -r ~/Documents/csvAndJsonHandler/app/assets/convert_Temps/en.json ~/Documents/beat-ya/src/assets/i18n/en.json
fi &&
if [ -e './de.json' ]; then
	cp -i -r ~/Documents/csvAndJsonHandler/app/assets/convert_Temps/de.json ~/Documents/beat-ya/src/assets/i18n/de.json
fi

