#!/bin/sh

rm -rf api
rm -rf EmmyLuaLOVEGenerator
rm -rf love-api

git clone --depth 1 https://github.com/love2d-community/love-api
git clone --depth 1 https://github.com/anaissls/EmmyLuaLOVEGenerator

mv EmmyLuaLOVEGenerator/genEmmyAPI.lua love-api

mkdir -p love-api/api

cd love-api
lua genEmmyAPI.lua
cd ..

mv love-api/api .

rm -rf EmmyLuaLOVEGenerator
rm -rf love-api
