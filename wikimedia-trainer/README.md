# Wikimedia Contribution Guide

An Agent Skill that helps an AI agent explain Wikimedia and help people make a safe first contribution.

## What this skill does

This skill helps an AI agent explain what Wikimedia is and match a person to a Wikimedia project that fits their interests. It also gives one small, safe first task and the rules to follow before publishing.

## Example prompts

Try asking an agent:

- "What is Wikimedia, and how is it different from Wikipedia?"
- "I like photography. Where can I help Wikimedia?"
- "I already edit Wikipedia. How do I get started on Wikidata?"
- "Give me one safe first edit I can make today."
- "Explain Wikimedia projects to a complete beginner."
- "I speak two languages. How can I help with translation?"

## What is in this repo

- **`SKILL.md`** is the instruction card the agent always reads. It explains when to use the skill and the steps to follow.
- **`scripts/project-match.sh`** is a small program the agent can run to do one exact job: suggest Wikimedia projects and a first task based on an interest and experience level.
- **`references/project-catalog.md`** is extra reading the agent opens only when it needs to compare projects or find an official start page.
- **`references/first-contribution-playbook.md`** is extra reading the agent opens only when someone is ready to make an edit, upload a file, or asks for step-by-step help.
- **`README.md`** is this file.
- **`LICENSE`** is the MIT license.
- **`.gitignore`** keeps junk files out of the repo.

## Install with npx

Replace `YOUR_GITHUB_USERNAME` with your real GitHub username.

```bash
npx skills add YOUR_GITHUB_USERNAME/wikimedia-contribution-guide
```

## Check it before installing

This lists the skill without installing it:

```bash
npx skills add YOUR_GITHUB_USERNAME/wikimedia-contribution-guide --list
```

## Manual install for Claude Code

First, clone the repo:

```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/wikimedia-contribution-guide.git
```

### For one project

Copy the folder into the project's `.claude/skills/` folder:

```bash
mkdir -p .claude/skills
cp -r wikimedia-contribution-guide .claude/skills/wikimedia-contribution-guide
```

### For all your projects (personal)

Copy the folder into your home folder's `.claude/skills/` folder:

```bash
mkdir -p ~/.claude/skills
cp -r wikimedia-contribution-guide ~/.claude/skills/wikimedia-contribution-guide
```

On Windows PowerShell, use:

```powershell
New-Item -ItemType Directory -Force .claude\skills
Copy-Item -Recurse -Force wikimedia-contribution-guide .claude\skills\wikimedia-contribution-guide
```

For a personal install on Windows, replace `.claude\skills` with `$HOME\.claude\skills`.

## Other agents

Cursor, OpenCode, and other agents are supported through the `npx skills add` command. The skill uses the same `SKILL.md` format.

## Test that it works

1. Install the skill.
2. Start a new agent session.
3. Ask one of the example prompts, such as: **"I like photography. Where can I help Wikimedia?"**
4. The agent should explain Wikimedia, suggest Wikimedia Commons, and give one small first task. If it does, the skill is working.

You can also run the helper script directly:

```bash
bash scripts/project-match.sh --interest photos --experience new
```

On Windows, run that command in Git Bash.

## Hacktoberfest

Built for the Hacktoberfest hackathon. Contributions are welcome: new project links, clearer examples, translations, and small fixes. Please keep the advice accurate and beginner-friendly.

## License

MIT. See `LICENSE`.
