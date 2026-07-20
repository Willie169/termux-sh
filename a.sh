ln -sf ${PREFIX:-/usr}/bin/bash ${TMPDIR:-/tmp}/bash-link1
for i in $(seq 1 10); do
ln -sf ${TMPDIR:-/tmp}/bash-link$i ${TMPDIR:-/tmp}/bash-link$(( i + 1 ))
${TMPDIR:-/tmp}/bash-link$(( i + 1 )) --version >/dev/null
done
