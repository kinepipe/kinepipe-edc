---
title: "Appendix Rule 5: Multilingual Path and Encoding Compliance"
summary: "Publication-oriented, non-operational adaptation of a path, encoding, and multilingual text preservation rule for digital health research workflows."
document_type: "journal_appendix_rule"
language: "en"
version: "1.0"
date: "2026-06-08"
status: "draft"
included_in_published_skill_set: true
intended_use: "Supplementary manuscript appendix; customize according to needs."
---

# Appendix Rule 5: Multilingual Path and Encoding Compliance

## Publication Notice

This document is a **publication-oriented adaptation** of an Agent Skills-style rule. It is not an installable `SKILL.md` file. It documents a general rule for preserving multilingual text, file paths, proper names, clinical labels, and encoding integrity in health research or digital health projects.

All language examples, local paths, operating systems, cloud drives, institution names, and project-specific folder structures must be replaced with **customize according to needs**.

## Publication-Safe Skill Metadata

```yaml
---
name: multilingual-path-encoding-compliance
description: Preserve multilingual characters, exact file paths, proper names, clinical variables, and UTF-8 text integrity in health research and digital health workflows. Use when reading, writing, converting, moving, exporting, or documenting files that may contain accented characters, non-English text, local paths, cloud-synchronized folders, or multilingual clinical terminology.
---
```

## Purpose

The purpose of this rule is to prevent text corruption, duplicate folders, broken file references, and loss of meaning when AI-assisted workflows handle multilingual content or paths in health-related projects.

This is especially important when documents, variables, participant-facing materials, institutions, or clinical concepts use diacritics, non-English alphabets, locale-specific punctuation, or mixed-language terminology.

## Scope

This rule applies to:

- multilingual clinical documents;
- health research folders and file paths;
- Markdown, LaTeX, CSV, JSON, XML, code, and spreadsheet files;
- cloud-synchronized workspaces;
- document conversion workflows;
- scripts that read or write text;
- proper names, institution names, study variables, and clinical labels;
- AI-assisted editing or file management tasks.

## Core Principle

AI systems and scripts should preserve the exact spelling and encoding of user-provided paths, names, variables, and language-specific text unless the user explicitly requests a controlled transformation.

## Generalized Instructions

1. **Preserve literal paths.** Do not simplify or transliterate folder names because they contain spaces, accents, special characters, or non-English text.
2. **Use UTF-8 encoding.** Save Markdown, code, configuration, and data files using UTF-8 unless the target platform requires another encoding.
3. **Avoid ghost duplicates.** Do not create alternative folders with altered names to avoid encoding problems.
4. **Respect proper names.** Preserve the spelling of people, institutions, instruments, clinical variables, and abbreviations when publication policy permits their use.
5. **Detect mojibake and replacement characters.** Treat corrupted text, question marks, or replacement characters as signals requiring verification.
6. **Configure command-line output when needed.** Some environments require explicit configuration to display UTF-8 correctly. Customize according to needs.
7. **Use safe temporary locations.** In synchronized folders, avoid unnecessary temporary files, caches, or generated duplicates.
8. **Verify after writing.** Confirm that created files exist in the expected path and do not contain replacement characters.
9. **Document locale assumptions.** State the expected language, character set, date format, decimal format, and file-system context when relevant.
10. **Do not degrade language for convenience.** Removing accents or non-English characters may alter meaning, identity, or traceability.

## Customization Guidance for Users

Before adapting this rule, the user should define:

| Customization Area | Questions to Answer |
|---|---|
| Language and locale | Which languages, alphabets, date formats, and decimal formats are expected? |
| File systems | Which operating systems, cloud drives, or shared storage systems are used? |
| Encoding standard | Is UTF-8 required, or does the target platform require another encoding? |
| Path policy | Should exact user-provided paths always be preserved? |
| Temporary files | Where should temporary files be created to avoid cloud-sync conflicts? |
| Publication policy | Which proper names must be anonymized and which labels must remain exact? |
| Conversion tools | Which tools are known to preserve or corrupt multilingual text? |
| Verification | What automated or manual checks should confirm encoding integrity? |

## Instructions for AI Interpretation

When an AI system applies this rule:

1. Do not create alternate path names to avoid multilingual characters.
2. Do not remove accents, diacritics, non-English characters, or spaces unless explicitly instructed.
3. If text appears corrupted, verify the source before editing or rewriting.
4. Replace identifying names with **customize according to needs** when preparing publication material.
5. Preserve clinical variables and technical terms exactly unless the user defines a mapping.
6. Report any uncertainty about encoding, path validity, or duplicate folders.

## Validation Checklist

- [ ] The rule is generalized beyond one language, institution, or operating system.
- [ ] UTF-8 preservation is stated as the default.
- [ ] Local path examples are removed or replaced.
- [ ] Proper names and clinical variables are handled according to publication policy.
- [ ] Mojibake, replacement characters, and duplicate folders are treated as risks.
- [ ] Temporary-file guidance accounts for synchronized folders.
- [ ] The document is publication-oriented and non-operational.

## Limitations

This rule does not guarantee compatibility with all software, file systems, clinical data standards, or journal platforms. Encoding and path policies must be tested in the target environment and customized according to needs.

## References

1. Agent Skills. "Specification." Accessed 2026-06-08. <https://agentskills.io/specification>
2. Agent Skills. "Best practices for skill creators." Accessed 2026-06-08. <https://agentskills.io/skill-creation/best-practices>

