# Builds the debug APK inside Docker.
# Output: app/build/outputs/apk/debug/app-debug.apk
# Docker writes progress to stderr, so rely on exit codes instead of "Stop".
$ErrorActionPreference = "Continue"
docker build -t clock-and-date-builder "$PSScriptRoot/docker"
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
docker run --rm `
  -v "${PSScriptRoot}:/project" `
  -v clock-and-date-gradle-cache:/root/.gradle `
  clock-and-date-builder
exit $LASTEXITCODE
