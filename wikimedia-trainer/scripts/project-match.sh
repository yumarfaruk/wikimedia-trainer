#!/usr/bin/env bash
# project-match.sh
# WHAT: Suggests Wikimedia projects and one safe first task based on a person's
#       interest and experience level. It is a helper, not an official Wikimedia tool.
# RUN:  bash scripts/project-match.sh --interest photos --experience new
#       bash scripts/project-match.sh --interest "history" --experience experienced
#       bash scripts/project-match.sh --help
# NEEDS: Bash 3.2 or newer. On Windows, use Git Bash.
# NOTE: Always check the official project pages for current rules.

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: bash scripts/project-match.sh [options]

Options:
  -i, --interest TEXT      Your interest, such as photos, history, data,
                           languages, books, news, teaching, travel, code,
                           audio, or general. Default: general
  -e, --experience LEVEL   new, some, or experienced. Default: new
  -h, --help               Show this help

Examples:
  bash scripts/project-match.sh --interest photos --experience new
  bash scripts/project-match.sh -i data -e experienced
EOF
}

interest="general"
experience="new"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --interest|-i)
      if [ "$#" -lt 2 ]; then
        echo "Error: --interest needs a value." >&2
        exit 1
      fi
      interest="$2"
      shift 2
      ;;
    --experience|-e)
      if [ "$#" -lt 2 ]; then
        echo "Error: --experience needs a value." >&2
        exit 1
      fi
      experience="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [ -z "$interest" ]; then
  echo "Error: --interest cannot be empty." >&2
  exit 1
fi

interest_key="$(printf '%s' "$interest" | tr '[:upper:]' '[:lower:]')"

case "$experience" in
  new|beginner|none|first-time|firsttime)
    experience="new"
    ;;
  some|intermediate|casual)
    experience="some"
    ;;
  experienced|expert|advanced)
    experience="experienced"
    ;;
  *)
    echo "Error: --experience must be new, some, or experienced." >&2
    exit 1
    ;;
esac

primary_name=""
primary_what=""
primary_link=""
secondary_name=""
secondary_what=""
secondary_link=""
starter_task=""

case "$interest_key" in
  *photo*|*image*|*camera*|*picture*|*visual*|*design*)
    primary_name="Wikimedia Commons"
    primary_what="The shared library of free photos, diagrams, audio, and video used by Wikipedia and other projects."
    primary_link="https://commons.wikimedia.org/wiki/Commons:First_steps"
    secondary_name="Wikipedia"
    secondary_what="The free encyclopedia, where a suitable photo can illustrate an article after you check that article's rules."
    secondary_link="https://en.wikipedia.org/wiki/Wikipedia:Contributing_to_Wikipedia"
    starter_task="Upload three photographs that you took yourself. Give each a clear title, date, description, and the correct license. Check Commons:Project scope before uploading."
    ;;
  *data*|*database*|*fact*|*spreadsheet*|*structured*|*metadata*|*catalog*|*genealogy*)
    primary_name="Wikidata"
    primary_what="The shared structured-data project behind Wikipedia and many other sites. It stores facts as items and statements."
    primary_link="https://www.wikidata.org/wiki/Wikidata:Introduction"
    secondary_name="Wikipedia"
    secondary_what="The free encyclopedia, where you can use reliable sources to improve articles about the topics you know."
    secondary_link="https://en.wikipedia.org/wiki/Wikipedia:Contributing_to_Wikipedia"
    starter_task="Find one item about a topic you know, add one missing fact with a reliable source, and write a short edit summary. Do not change many items at once."
    ;;
  *book*|*text*|*document*|*manuscript*|*library*|*poetry*|*literature*)
    primary_name="Wikisource"
    primary_what="A free library of source texts that are public domain or freely licensed, with volunteers proofreading them."
    primary_link="https://en.wikisource.org/wiki/Wikisource:About"
    secondary_name="Wikimedia Commons"
    secondary_what="The media library for scans, images, audio, and other files that support free-knowledge projects."
    secondary_link="https://commons.wikimedia.org/wiki/Commons:First_steps"
    starter_task="Proofread one page of an existing text. Only add a new public-domain text after checking copyright and the project's help pages."
    ;;
  *language*|*translation*|*translate*|*dictionary*|*word*|*linguistic*)
    primary_name="Wiktionary"
    primary_what="A free dictionary with definitions, examples, translations, and pronunciation for words in many languages."
    primary_link="https://en.wiktionary.org/wiki/Wiktionary:Welcome,_newcomers"
    secondary_name="Translatewiki.net"
    secondary_what="A separate translation platform used to translate the interface of MediaWiki and other free software."
    secondary_link="https://translatewiki.net/wiki/Translating:Intro"
    starter_task="Add one missing word or improve one definition with an example sentence and a source. For software translation, read Translatewiki's introduction before starting."
    ;;
  *news*|*journalism*|*reporting*|*current*)
    primary_name="Wikinews"
    primary_what="A free news project written and reviewed by volunteers, with its own review process before publication."
    primary_link="https://en.wikinews.org/wiki/Wikinews:Welcome"
    secondary_name="Wikimedia Commons"
    secondary_what="The media library for free images and audio that can support news reporting."
    secondary_link="https://commons.wikimedia.org/wiki/Commons:First_steps"
    starter_task="Read the current review guidelines, then improve one existing article with a source. Pitch a new story in the newsroom before writing it."
    ;;
  *teach*|*education*|*lesson*|*course*|*training*|*learn*)
    primary_name="Wikiversity"
    primary_what="A free learning community with courses, lessons, and research projects created by volunteers."
    primary_link="https://en.wikiversity.org/wiki/Wikiversity:Welcome"
    secondary_name="Wikibooks"
    secondary_what="A free library of textbooks and manuals that anyone can edit."
    secondary_link="https://en.wikibooks.org/wiki/Wikibooks:Welcome"
    starter_task="Add one short, sourced learning resource or fix one broken lesson page. Check the welcome page for the expected format."
    ;;
  *travel*|*place*|*map*|*geography*|*city*|*destination*)
    primary_name="Wikivoyage"
    primary_what="A free travel guide with practical information about destinations, written by travellers."
    primary_link="https://en.wikivoyage.org/wiki/Wikivoyage:Welcome,_newcomers"
    secondary_name="Wikimedia Commons"
    secondary_what="The media library for free travel photos and maps."
    secondary_link="https://commons.wikimedia.org/wiki/Commons:First_steps"
    starter_task="Improve one destination page with a practical, up-to-date detail and a source. Or upload a photo you took yourself."
    ;;
  *code*|*tech*|*software*|*program*|*developer*|*tool*|*computer*|*engineering*)
    primary_name="MediaWiki"
    primary_what="The open-source software that runs Wikipedia and many other wikis. You can help with code, documentation, testing, or design."
    primary_link="https://www.mediawiki.org/wiki/How_to_contribute"
    secondary_name="Wikidata"
    secondary_what="The structured-data project, which also needs tools, queries, and technical volunteers."
    secondary_link="https://www.wikidata.org/wiki/Wikidata:Introduction"
    starter_task="Pick a good-first-task from the project's contribution page, set up the listed tools, and make one small documentation or code fix. Ask in the listed chat before starting."
    ;;
  *audio*|*music*|*sound*|*podcast*|*recording*|*pronunciation*)
    primary_name="Wikimedia Commons"
    primary_what="The shared media library, including free audio, music, pronunciation clips, and spoken-word recordings."
    primary_link="https://commons.wikimedia.org/wiki/Commons:First_steps"
    secondary_name="Wiktionary"
    secondary_what="The free dictionary, where pronunciation clips and audio examples can support entries."
    secondary_link="https://en.wiktionary.org/wiki/Wiktionary:Welcome,_newcomers"
    starter_task="Upload one recording you made yourself with the correct license and description. If you add pronunciation to Wiktionary, check that project's audio rules first."
    ;;
  *writ*|*research*|*history*|*historic*|*science*|*sport*|*culture*|*art*|*film*|*biography*|*politics*|*food*|*cook*|*nature*|*game*|*fashion*)
    primary_name="Wikipedia"
    primary_what="The free encyclopedia, with separate language editions and rules for sources, notability, and neutral tone."
    primary_link="https://en.wikipedia.org/wiki/Wikipedia:Contributing_to_Wikipedia"
    secondary_name="Wikisource"
    secondary_what="The free library of source texts, useful when you want to work with original documents."
    secondary_link="https://en.wikisource.org/wiki/Wikisource:About"
    starter_task="Improve one short article in your language by adding one reliable source and one clear sentence. Use the visual editor and an edit summary."
    ;;
  *)
    primary_name="Wikipedia"
    primary_what="The free encyclopedia, with separate language editions and rules for sources, notability, and neutral tone."
    primary_link="https://en.wikipedia.org/wiki/Wikipedia:Contributing_to_Wikipedia"
    secondary_name="Wikimedia Commons"
    secondary_what="The shared library of free photos, diagrams, audio, and video used by Wikipedia and other projects."
    secondary_link="https://commons.wikimedia.org/wiki/Commons:First_steps"
    starter_task="Make one small improvement to an article in your language: fix a typo, add a missing link, or add one reliable source. Use an edit summary."
    ;;
esac

if [ "$experience" = "new" ]; then
  task="$starter_task"
  note="One small edit is a real contribution. If it is reverted, ask why on the talk page instead of changing it back."
elif [ "$experience" = "some" ]; then
  task="$starter_task Then check the project's community portal for a cleanup list in your interest area."
  note="Keep edits focused. Small, sourced changes are easier for others to review."
else
  task="Choose one under-covered topic in your interest area and improve it with at least two reliable sources. Check local rules and get consensus before any batch or automated edit."
  note="Your experience is useful, but every Wikimedia project has its own rules. Read the local policies before importing habits from another project."
fi

cat <<EOF
Wikimedia project match
=======================
Interest  : $interest
Experience: $experience

Top match: $primary_name
What it is: $primary_what
Start here: $primary_link

Also consider: $secondary_name
What it is: $secondary_what
Start here: $secondary_link

Your first task
---------------
$task

Before you publish
------------------
- Use your own free account; do not share it.
- Add a short edit summary.
- Cite a reliable source for facts.
- Write in your own words; do not copy copyrighted text.
- For photos and audio, upload only your own work or clearly licensed files.
- Disclose paid or conflict-of-interest editing.
- If reverted, discuss it on the talk page. Do not edit war.

$note

Official pages may be in English. Look for a language selector or translate link.
EOF
