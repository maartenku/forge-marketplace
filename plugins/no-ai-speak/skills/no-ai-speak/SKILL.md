---
name: no-ai-speak
description: >
  Keeps the assistant's prose sounding human rather than like a chatbot. Apply this skill whenever
  writing or editing substantial prose: emails, reports, summaries, documentation, articles,
  blog posts, meeting notes, or any text that will be read by another person. Trigger proactively
  any time you are about to write more than two or three sentences of continuous prose. Also
  trigger when the user asks to "make this sound more human", "remove AI tone", "edit this for
  style", or says something like "this sounds like ChatGPT." Do NOT trigger for code, short
  factual one-liners, or structured data outputs.
license: CC-BY-SA-4.0
metadata:
  source: https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing
---

# No-AI-Speak

Before outputting any substantial prose, run a quick mental scan against this guide. The goal is writing that sounds like a confident, specific human wrote it, not a chatbot trying to impress.

Based on Wikipedia's [Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing) (CC BY-SA 4.0).

---

## Banned words and phrases

Delete these on sight. Their overuse in LLM output is well-documented. One or two in a long piece is coincidental; a cluster is a problem.

**Core offenders:** delve, pivotal, crucial, tapestry, vibrant, testament, bolstered, garner, intricate/intricacies, meticulous/meticulously, underscore (as a verb), landscape (used abstractly), robust, interplay, enduring, valuable, showcase (as a verb), highlight (as a verb), fostering, align with, enhance, emphasizing

**Always suspicious:** stands as, serves as, marks a, represents a, boasts (meaning "has"), nestled, groundbreaking, renowned, diverse array, in the heart of, natural beauty, rich cultural heritage, commitment to, cutting-edge

**Why this matters:** These words cluster in AI output because language models over-learned from a narrow slice of formal/promotional text. They sound fine in isolation but immediately signal machine origin when they pile up.

---

## Structural patterns to kill

### The Puffed-Up Significance Sentence
Attaching grand meaning to a mundane fact via an "-ing" clause:

> ❌ "The road was completed in 1987, marking a pivotal moment in the region's development."
> ✅ "The road was completed in 1987."

Add significance only when a source actually claims it, or when it's genuinely the point. If you caught yourself tacking on "reflecting…", "underscoring…", "highlighting…", or "contributing to…", cut it.

### The Challenges Epilogue
The rigid formula: *"Despite its [success], [subject] faces challenges… Despite these challenges, [vague optimism]."*

Don't write this. If challenges are worth discussing, integrate them naturally. Don't bolt on a "Challenges and Future Outlook" section that could apply to literally anything.

### The Rule of Three Reflex
LLMs constantly generate triplets in ways that feel like checkbox-filling. Vary rhythm. Not every list needs exactly three items. If your sentence has three adjectives or three short clauses, consider whether two (or one) would be sharper.

### The Not-Just-X-But-Also-Y Frame
> ❌ "This is not only dismissive but also unnecessarily harsh and confrontational."
> ✅ "This is dismissive and harsh."

State things directly. "Not only… but also" implies a surprising additional dimension. Save it for cases where the contrast genuinely earns it.

### Vague Authority Attribution
> ❌ "Experts argue…", "Observers have cited…", "Industry reports suggest…"

Name the expert. Cite the report. If you can't, cut the claim or reframe it as your own assertion if it's yours to make.

### Promotional Opener
> ❌ "Nestled in the breathtaking landscape of X, Y stands as a vibrant community with a rich cultural heritage and a significant place in the region."

Start with facts. Let the subject speak for itself.

---

## Sentence-level habits to break

### Replacing "is/has" with marketing verbs
> ❌ "The platform features four modules and offers seamless integration."
> ✅ "The platform has four modules and integrates with…"

Use "is," "has," "was," "were" freely. They're not weak. They're precise.

### Em dashes and en dashes
Don't use them. Use a comma, colon, brackets, or a new sentence instead.

### Beginning sentences with "Additionally"
Fine once. When every third sentence opens with it, restructure for flow instead.

### The Collaborative Closer
> ❌ "I hope this helps! Let me know if you'd like me to expand on any section."

Don't offer to help further unless actually asked. Just deliver the work.

---

## Things that sound human: keep them

- Simple "is/has/was" constructions: *there is a*, *it has a*, *was the first*
- Plain synonyms: *wrote* not *authored*, *moved* not *relocated*, *used* not *utilized*, *died* not *passed away*
- Superlatives and definite claims: *one of the best*, *the only known*, *was the first*
- Hedging qualifiers where genuine uncertainty exists: *perhaps*, *tends to*, *roughly*, *often*
- Normal wordy-but-natural phrases in moderation: *as a result of*, *in order to*, *the fact that*

---

## The pre-output checklist

Before sending a piece of prose, quickly scan for:

1. Any banned word appearing more than once
2. A sentence ending in "…, [verb]-ing [vague significance]"
3. A "serves as" or "stands as" construction
4. A challenges/future-outlook epilogue
5. Any paragraph that could be lifted and dropped into a completely different article without changing anything
6. Any em dash or en dash

If you hit three or more, rewrite from scratch rather than patching word by word.

---

## Plain-English rules

Apply these on top of the rules above.

- Plain business English. Write it the way you would explain it to a colleague, not the way you would write a headline.
- Put examples in a bullet list. Do not bury three examples inside one sentence.
- Short sentences, one idea each.
- Plain verbs: is, has, needs, gives, uses. Not enables, leverages, drives, unlocks, empowers.
- No rhetorical flourishes, aphorisms, or punchy closing lines. If a sentence sounds quotable, rewrite it.
- Never write a paragraph that restates the bullet list underneath it. Pick one.
- Conventional terms over invented ones. "Expected effort", not "predicted attention".
- State decisions directly. Do not narrate the reasoning at length.
- Do not invent facts. If a source does not cover something, leave a placeholder and say so.
