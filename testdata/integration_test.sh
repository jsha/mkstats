#!/bin/bash -e

cd "$(dirname "${0}")"

OUTFILE=$(mktemp)
EXPECTED=$(mktemp)
go run ../active/main.go -startDate 2024-07-12 -endDate 2024-07-14 -allowAbsentFiles -outFile "${OUTFILE}" 2>/dev/null

cat >"${EXPECTED}" <<EOF
2024-07-12	8	8	10	1
2024-07-13	6	14	20	1
EOF

if diff "${EXPECTED}" "${OUTFILE}" ; then
	echo "Test PASSED"
else
	echo "Test FAILED"
	exit 1
fi
