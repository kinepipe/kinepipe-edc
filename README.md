# kinepipe-edc

This repository contains publication-oriented Agent Skills-style structures for clinical data capture and medical informatics workflows.

The current release is focused on reusable, non-operational methodological appendices associated with a manuscript on agentic AI-assisted construction of clinical data capture systems. These files are intended for scholarly review, adaptation, and transparent reporting. They are **not** distributed as installable or executable agent skills.

## Repository Contents

```text
kinepipe-edc/
|-- README.md
|-- demo/
|   |-- README.md
|   |-- README_es.md
|   `-- (Flutter source files...)
|-- docs/
|   |-- development_experience_en.md
|   `-- development_experience_es.md
|-- glossary/
|   |-- glossary_non_technical_en.md
|   `-- glossary_non_technical_es.md
|-- skills_published/
|   |-- README.md
|   |-- mdmake_publication_appendix.md
|   |-- clinical_data_capture_sync_publication.md
|   |-- document_conversion_publication.md
|   |-- clinical_software_development_publication.md
|   |-- field_resilience_failure_control_publication.md
|   `-- multilingual_path_encoding_compliance_publication.md
```

## Scope

This repository serves as a comprehensive methodological appendix and clinical demo showcase:

1. **Agent Skills Appendices**: The `skills_published/` directory contains rules and guidelines covering Markdown-based documentation, clinical data capture, document conversion, clinical software development, field resilience, and multilingual path compliance.
2. **Bilingual Non-Technical Glossary**: Explains key development and interaction terms in Spanish and English to aid non-technical researchers collaborating with AI agents:
   - **English**: [glossary_non_technical_en.md](glossary/glossary_non_technical_en.md)
   - **Spanish**: [glossary_non_technical_es.md](glossary/glossary_non_technical_es.md)
3. **Demo EDC - Interactive Flutter App**: The `demo/` folder contains a fully functional, editable cross-platform application illustrating role-based access, local SQLite caching, PDF clinical report exporting, and Bluetooth BLE Polar sensor data capture:
   - **English Guide**: [demo/README.md](demo/README.md)
   - **Spanish Guide**: [demo/README_es.md](demo/README_es.md)
4. **Agentic AI Construction Chronicle**: The `docs/` folder contains bilingual technical reports documenting the actual prompting process, success heuristics (atomic prompting, modular styling), and lessons learned (context degradation, early field testing deficits):
   - **English Document**: [docs/development_experience_en.md](docs/development_experience_en.md)
   - **Spanish Document**: [docs/development_experience_es.md](docs/development_experience_es.md)

For further context and reference standards regarding agentic AI, capabilities, and open-source automated harnesses, see the following resources:

1. The Agent Skills Directory. _Skills_. Accessed June 10, 2026. [https://www.skills.sh](https://www.skills.sh)
2. Affaan M. _ECC Tools - Open Agent Harness System for GitHub App Automation and Security_. ECC Tools. Accessed June 8, 2026. [https://ecc.tools](https://ecc.tools)

## Use

Readers may use these files as methodological examples for designing, reporting, or adapting AI-agent guidance in digital health and clinical research settings.

Before adapting the material, users should customize it according to local clinical workflows, data governance requirements, privacy constraints, institutional policies, technical environments, and journal requirements.

## Important Note

These files are publication-oriented artifacts. They do not certify software safety, regulatory compliance, medical device readiness, privacy compliance, or clinical validity. Any operational implementation must be reviewed by qualified human stakeholders.

## Citation

Citation details will be added after manuscript submission or publication.

---

## DOI

[![DOI](https://img.shields.io/badge/DOI-10.5281%2Fzenodo.20589697-blue)](https://doi.org/10.5281/zenodo.20589697)
