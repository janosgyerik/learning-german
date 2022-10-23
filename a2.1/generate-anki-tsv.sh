#!/usr/bin/env bash
#
# Converts .flashcards files to .anki.tsv files.
#
# Format of .flashcards:
# 2 lines per card, the first line is the front, the second is the back.
#
# Format of .anki.tsv:
# front and back sides are separated by tab
#
# For each card in .flashcards, this tool generates
# front-back and back-front entries in .anki.tsv
# As you add new entries at the end of a .flashcards file,
# the new entries generated in .anki.tsv will be appended,
# preserving the previously generated prefix.
# This is in the hope of better user experience with reimporting in Anki.
#

set -euo pipefail

cd "$(dirname "$0")"

fatal() {
    echo >&2 "fatal: $*"
    exit 1
}

info() {
    echo "* $*"
}

strip_trailing_dot() {
    echo "${1%.}"
}

convert_flashcards_to_anki_tsv() {
    local flashcards_file
    flashcards_file=$1

    local front back

    while read front; do
        read back || fatal 'could not read back side of card'
        front=$(strip_trailing_dot "$front")
        back=$(strip_trailing_dot "$back")
        printf "%s\t%s\n" "$front" "$back"
        printf "%s\t%s\n" "$back" "$front"
    done < "$flashcards_file"
}

for f in *.flashcards; do
    info "generating for $f ..."
    convert_flashcards_to_anki_tsv "$f" > "$f.anki.tsv"
done
