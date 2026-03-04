# Avalanches
[日本語のreadmeはこちら](./readme.md)

![GitHub total downloads](https://img.shields.io/github/downloads/Halo1234/Avalanches/total?style=flat-square&color=brightgreen)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/Halo1234/Avalanches?style=flat-square)

Avalanches is an integrated development environment based on KiriKiri2 / KiriKiriZ that strongly supports game development and operations.
It includes practical tools such as an SLG editor, a scenario converter, and tools for typing games. Avalanches also includes GOKI2 as the framework for the games it supports.

[Check the latest release](https://github.com/Halo1234/Avalanches/releases/latest)

---

## Table of Contents
* [Introduction](#Introduction)
* [System Requirements](#System. Requirements)
* [Directory Structure](#Directory Structure)
* [Recommended Software](#Recommended Software)
* [License](#License)
* [Contact Information](#Contact Information)

---

## Introduction
This development environment is built using multiple software components.
Utilizing the tools within `/tools/` enables efficient game data creation and conversion tasks. While the “Recommended Software” is not mandatory, installing it is recommended to utilize the full functionality.

---

## System Requirements
* **OS:** Windows 11 (64-bit) - Tested and confirmed to work

---

## Directory Structure

| Path | Description |
| :--- | :--- |
| `/doc/` | Manuals and documentation |
| `/dist/` | Output directory for generated master data |
| `/src/` | Complete source code set |
| `/src/goki2/` | GOKI2 (based on Kirikiri2) test and runtime environment. Launch tests with `run.bat`. |
| `/tools/` | **Various tools (details below)** |

### List of Included Tools
* **`game_editor`**: SLG editor (item/character editing)
* **`convgs`**: Scenario text -> Script conversion
* **`make`**: Master data creation
* **`make_roman_table`**: Creates romaji conversion tables for typing games
* **`make_word`**: Creates word data for typing games
* **`make_cgmem`**: Generates CG recall data

---

## Recommended Software

To facilitate smooth development, we recommend installing the following tools based on your needs.

### Essential (Development & Management)
* **[TortoiseGit](https://tortoisegit.org/)**: For repository retrieval and management
* **[Ruby](http://www.ruby-lang.org/ja/)**: Required to run tools (.rb files) (Confirmed working with v4.0.1)

### Creating Patch Installers
* **[TortoiseSVN](https://tortoisesvn.net/)**: For reading logs when creating patches
* **[SlikSVN](https://sliksvn.com/download/)**: Required as the client when creating patches
* **[NSIS](https://nsis.sourceforge.io/Download)**: For creating the installer (v3.11 tested)

### Data Input (Excel-Compatible Software)
* **Microsoft Office (Excel)**: Recommended for inputting `*.xls/xlsx` format data
* **[Apache OpenOffice](http://www.openoffice.org/ja/)**: Can be substituted with Calc (v4.1.2 tested)
* **[LibreOffice](http://ja.libreoffice.org/)**: May work, but not recommended (not tested)

---

## License
Licensing terms follow the **Kirikiri 2** license.

---

## Contact
* **Email:** [halosuke@gmail.com](mailto:halosuke@gmail.com)
* **Blog:** [http://halo.doorblog.jp/](http://halo.doorblog.jp/)
* **GitHub:** For bug reports and such, please go to [Issues](https://github.com/Halo1234/Avalanches/issues)
