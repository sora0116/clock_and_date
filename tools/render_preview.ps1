# Regenerates app/src/main/res/drawable-nodpi/widget_preview.png in Docker.
$ErrorActionPreference = "Continue"
$root = Split-Path -Parent $PSScriptRoot
New-Item -ItemType Directory -Force "$root/app/src/main/res/drawable-nodpi" | Out-Null
docker run --rm `
  -v "${root}:/project" `
  -w /project `
  python:3.12-slim `
  sh -c "apt-get update -qq && apt-get install -y -qq --no-install-recommends fonts-noto-cjk > /dev/null && pip install -q --root-user-action=ignore pillow && python tools/render_preview.py app/src/main/res/drawable-nodpi/widget_preview.png"
exit $LASTEXITCODE
