---
title: "Appendix Rule 2: Health Document Conversion for AI-Assisted Review"
summary: "Publication-oriented, non-operational adaptation of a document conversion rule for transforming health-related documents into structured Markdown."
document_type: "journal_appendix_rule"
language: "en"
version: "1.0"
date: "2026-06-08"
status: "draft"
included_in_published_skill_set: true
intended_use: "Supplementary manuscript appendix; customize according to needs."
---

# Appendix Rule 2: Health Document Conversion for AI-Assisted Review

## Publication Notice

This document is a **publication-oriented adaptation** of an Agent Skills-style rule. It is not an installable `SKILL.md` file and does not require a specific conversion tool. It describes a generalizable method for converting health, scientific, educational, or technical documents into structured Markdown for review, synthesis, or AI-assisted analysis.

All project-specific tools, local paths, file names, datasets, institutional templates, and private document sources must be replaced with **customize according to needs**.

## Publication-Safe Skill Metadata

```yaml
---
name: health-document-conversion
description: Convert health-related documents into structured Markdown for human review, AI-assisted analysis, knowledge-base preparation, or multi-format export. Use when working with protocols, reports, consent forms, clinical manuals, spreadsheets, slide decks, PDFs, Word documents, or other source files that must be interpreted or summarized safely.
---
```

## Purpose

The purpose of this rule is to support structured conversion of non-Markdown documents into Markdown while preserving meaning, hierarchy, tables, references, and health-domain context.

This rule is especially relevant when an AI system needs to inspect a document without loading the original binary file directly or when a source document must become a reusable, exportable, and auditable text artifact.

## Scope

This rule applies to:

- research protocols;
- clinical manuals;
- informed consent templates;
- data collection instruments;
- literature review notes;
- educational material;
- slide decks;
- spreadsheets;
- PDF reports;
- Word documents;
- structured files such as CSV, JSON, or XML;
- document packages prepared for AI review, RAG, or knowledge bases.

## Core Principle

Document conversion should preserve **structure before style**. The converted Markdown should maintain the source document's hierarchy and meaning while removing or anonymizing information that should not be exposed to AI systems or publication workflows.

## Generalized Instructions

1. **Identify the source format and purpose.** Determine whether the document is a protocol, instrument, table, report, slide deck, consent form, or mixed artifact.
2. **Select a default conversion path.** Use a reliable local conversion tool suitable for the format. Examples may include MarkItDown, Pandoc, OCR pipelines, spreadsheet parsers, or document-specific extractors. Customize according to needs.
3. **Preserve document hierarchy.** Convert titles, sections, subsections, lists, tables, captions, and references into explicit Markdown structures.
4. **Protect sensitive content.** Remove or replace personal data, patient data, local paths, institution-specific details, and unpublished identifiers before AI-assisted review.
5. **Flag uncertain extraction.** Mark OCR errors, broken tables, missing figures, unreadable sections, or low-confidence conversions for human review.
6. **Avoid blind summarization.** Do not compress the document until the extracted structure has been inspected.
7. **Retain traceability.** Include source file name placeholders, conversion date, version, and reviewer notes when publication policy permits.
8. **Validate tables and numeric content.** Tables, scales, scores, thresholds, and units should be checked manually after conversion.
9. **Create a clean Markdown output.** Remove extraction artifacts, repeated headers, broken line wrapping, and irrelevant metadata.
10. **Use Markdown as the reusable source.** Treat the converted document as a structured intermediate artifact for analysis, export, or AI interpretation.

## Customization Guidance for Users

Before adapting this rule, the user should define:

| Customization Area | Questions to Answer |
|---|---|
| Source formats | Which file types must be converted? |
| Preferred tools | Which local or institutional conversion tools are allowed? |
| Sensitive content | What information must be removed before AI review? |
| OCR policy | How should scanned or image-based documents be handled? |
| Table fidelity | Which tables require manual verification? |
| Citation handling | Should references be preserved, normalized, or exported separately? |
| Output destination | Will the Markdown be used for publication, RAG, NotebookLM-like tools, DOCX export, or internal review? |
| Quality threshold | What extraction errors require reprocessing or human correction? |

## Instructions for AI Interpretation

When an AI system applies this rule:

1. Do not assume that converted text is complete or error-free.
2. Preserve headings, tables, list order, score labels, units, and reference markers whenever possible.
3. Do not expose or invent personal, institutional, dataset, or local-path details.
4. Mark unclear text with a human-review note rather than silently correcting it.
5. Distinguish conversion output from interpretation or summary.
6. Recommend manual verification for clinical thresholds, scale scoring, consent language, and regulatory content.

## Validation Checklist

- [ ] The converted document is saved in UTF-8 Markdown.
- [ ] Headings follow a logical hierarchy.
- [ ] Tables are preserved or clearly marked for human review.
- [ ] Sensitive details are removed or replaced.
- [ ] OCR uncertainty is disclosed when relevant.
- [ ] Numeric values, units, and thresholds are not silently changed.
- [ ] The conversion method is described generically or marked as **customize according to needs**.
- [ ] The document is framed as a publication appendix, not as an executable conversion script.

## Limitations

This rule does not guarantee complete extraction fidelity. Scanned documents, complex tables, embedded figures, handwritten annotations, and institution-specific templates may require manual review or specialized tools.

## References

1. Agent Skills. "Specification." Accessed 2026-06-08. <https://agentskills.io/specification>
2. Agent Skills. "Best practices for skill creators." Accessed 2026-06-08. <https://agentskills.io/skill-creation/best-practices>

