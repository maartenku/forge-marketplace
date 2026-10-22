# Feature interview (used by new-project and feature-define)

Ask only what the user's high-level expectations leave unclear: at most six questions per project and one or two per feature. Then write the notes in full. The user reviews them and does not draft them.

Per project, once:
1. The one-line promise: what this delivers and for whom, in a sentence a stranger could repeat.
2. The first user journey, from install or open to the first moment of value. It becomes `setup/user-journey.md`.
3. Does it need code? If not, the loop ends at Phase 1.
4. Hard constraints: no accounts, local only, must run on a specific host, a timebox, must sell.

Per feature, only when the expectations do not say:
5. What does the user see or get when it works? Behaviour, not implementation.
6. What is explicitly not part of it? The MVP cut.
7. Does it depend on another feature, a file or folder, or an external service?
8. How will we know it is done? This becomes the acceptance criteria: two to five observable statements.

Write each feature note from `templates/functional/feature.md`. Mark guesses with a visible note ("Assumption:" in prose, or an Obsidian `> [!question]` callout when the functional root is a vault).
