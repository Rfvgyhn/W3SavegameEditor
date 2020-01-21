#!/usr/bin/env sh

set -e

[ -z "${LIGET_API_KEY}" ] && echo "Must provide LIGET_API_KEY variable" && exit 1

config="release"
dest="dist"

rm -rf "${dest}"
mkdir -p "${dest}"
dotnet pack -c "${config}" -o "${dest}" #--include-symbols --include-source

find "${dest}" -name "W3SavegameEditor.Core.*.nupkg" | \
  xargs dotnet nuget push --source https://nuget.nsaas.io/api/v3/index.json --api-key "${LIGET_API_KEY}"
