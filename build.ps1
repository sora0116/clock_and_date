# Builds the debug APK inside Docker.
# Output: app/build/outputs/apk/debug/app-debug.apk
# Docker writes progress to stderr, so rely on exit codes instead of "Stop".
$ErrorActionPreference = "Continue"
docker build -t clock-and-date-builder "$PSScriptRoot/docker"
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
# .android/ keeps the debug signing key between builds. Without it every build
# gets a fresh key and Android refuses to update the installed app.
New-Item -ItemType Directory -Force "$PSScriptRoot/.android" | Out-Null
docker run --rm `
  -v "${PSScriptRoot}:/project" `
  -v "${PSScriptRoot}/.android:/root/.android" `
  -v clock-and-date-gradle-cache:/root/.gradle `
  clock-and-date-builder
exit $LASTEXITCODE
