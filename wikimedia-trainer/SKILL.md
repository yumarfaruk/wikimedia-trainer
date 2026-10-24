---
name: wikimedia-contribution-guide
description: Helps beginners and experienced contributors understand what Wikimedia is, choose a Wikimedia project that matches their interests, and make a safe first contribution. Use when someone asks "what is Wikimedia", "which Wikimedia project should I contribute to", "how do I edit Wikipedia or Wikidata", "where can I help Wikimedia", or asks for a first task or contribution plan.
---

# Wikimedia Contribution Guide

Use this skill to turn a vague interest into one clear, safe Wikimedia action. Wikimedia is a global volunteer movement for free knowledge. The Wikimedia Foundation hosts Wikipedia, Wikimedia Commons, Wikidata, Wikisource, Wiktionary, and other projects. Each project is a separate community with its own rules, so check the local rules before editing.

## Steps

1. **Find the fit.** Ask for the person's interests and experience only if they are missing. Otherwise infer them. If they are new, use `new`; if they already edit, use `some` or `experienced`.
2. **Explain briefly.** In 2-4 sentences, say that Wikimedia is bigger than Wikipedia and name 2-3 relevant projects. Do not list every project unless asked.
3. **Match a project.** Run the matcher from the folder that contains this `SKILL.md`:
   ```bash
   bash scripts/project-match.sh --interest "<topic>" --experience "<new|some|experienced>"
   ```
   Use the output as a shortlist, not a script to read aloud. If the interest is unclear, use `--interest general`.
4. **Read the catalog when needed.** Read `references/project-catalog.md` when the user wants to compare projects, asks about a project not in the script output, or needs a project's official start page.
5. **Give one first task.** Name one small task, the project, and the official page to start. Keep it doable in 15-30 minutes.
6. **Read the playbook before an edit.** Read `references/first-contribution-playbook.md` when the user is about to publish an edit, upload a file, create an account, or asks "what should I do step by step?" Use its checklist and examples.
7. **Stop before damage.** Tell the user to use an account, add an edit summary, cite a reliable source, write in their own words, and discuss a reversion on the talk page. For photos, upload only their own work or clearly licensed files. For paid or conflict-of-interest editing, disclose it. Do not help with mass edits, vote stacking, harassment, or privacy violations.

## Examples

**New user, photography**

User: "I like photography. Where can I help Wikimedia?"

Agent: Explains that Wikimedia Commons is the media library for free photos. Runs `bash scripts/project-match.sh --interest photos --experience new`. Recommends uploading 3 own photos with a clear title, date, description, and correct license. Links to `https://commons.wikimedia.org/wiki/Commons:First_steps` and mentions checking project scope and consent rules.

**Experienced editor, data**

User: "I know Wikipedia but want to try Wikidata."

Agent: Explains that Wikidata is the shared structured-data project behind Wikipedia. Runs `bash scripts/project-match.sh --interest data --experience some`. Suggests adding one missing fact with a source to an item they know, plus an edit summary. Links to `https://www.wikidata.org/wiki/Wikidata:Introduction` and warns against batch edits before learning local rules.

## Output style

- Be warm and concrete. Use plain words.
- Give one next action, not a wall of links.
- Say "check the rules for your language edition" when a policy may differ.
- Never invent a policy, link, or project name. If unsure, point to the official project page.
