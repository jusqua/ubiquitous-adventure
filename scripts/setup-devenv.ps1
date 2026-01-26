$ErrorActionPreference = "Stop"

if (Test-Path "api")
{
    Remove-Item -Path "api" -Recurse -Force
}
if (Test-Path "EmmyLuaLOVEGenerator")
{
    Remove-Item -Path "EmmyLuaLOVEGenerator" -Recurse -Force
}
if (Test-Path "love-api")
{
    Remove-Item -Path "love-api" -Recurse -Force
}

git clone --depth 1 https://github.com/love2d-community/love-api
git clone --depth 1 https://github.com/anaissls/EmmyLuaLOVEGenerator

Move-Item -Path "EmmyLuaLOVEGenerator/genEmmyAPI.lua" -Destination "love-api" -Force

if (-not (Test-Path "love-api/api"))
{
    New-Item -ItemType Directory -Path "love-api/api" -Force | Out-Null
}

Push-Location "love-api"
lua genEmmyAPI.lua
Pop-Location

Move-Item -Path "love-api/api" -Destination "." -Force

Remove-Item -Path "EmmyLuaLOVEGenerator" -Recurse -Force
Remove-Item -Path "love-api" -Recurse -Force
