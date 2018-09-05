# simplejump

## Overview

The simplest way to jump between directories.

## Installation

```bash
pip install xontrib-simplejump
```

## Motivation

I wanted a simple and efficient alternative to z, fasd and other jump scripts.

simplejump algorithm:

- **on directory change**: associate the base name to the full path of a dir in simplejump dict
- **on user search**: return the exact match or the smaller partial match from simplejump dict
- **on tabcomplete**: return the list of simplejump dict keys that match the command prefix
- **on shell init**:  load the dict from simplejump file or an empty dict
- **on shell exit**: store the dict in simplejump file using json format

simplejump design:
- keys/names are case insensitive, values/paths are case sensitive

simplejump vars:

- **simplejump file**: $SIMPLEJUMP_FILE
- **simplejump dict**: $SIMPLEJUMP_DICT

simplejump file:

- **simplejump file**: ~/.simplejump

## Example

```bash
simplejump [DIR]
```
