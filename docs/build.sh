#!/usr/bin/env bash
#
# Build translated docs in _build/html
#
#sphinx-build -b html -D language=ru . _build/html/ru
#sphinx-build -b html -D language=es . _build/html/es
#sphinx-build -b html -D language=bg . _build/html/bg
sphinx-build -b html -D language=de . _build/html/de
#sphinx-build -b html -D language=fr . _build/html/fr
google-chrome _build/html/de/index.html
