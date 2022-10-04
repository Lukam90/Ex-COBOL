# coding: utf8

# ("", ""),

keywords = [
    ("accept", "ACCEPT"),
    ("advancing", "ADVANCING"),
    ("author", "AUTHOR"),
    (" by ", " BY "),
    ("data", "DATA"),
    ("delimited", "DELIMITED"),
    ("display", "DISPLAY"),
    ("division", "DIVISION"),
    ("end-string", "END-STRING"),
    ("identification", "IDENTIFICATION"),
    (" in ", " IN "),
    ("into", "INTO"),
    (" no ", " NO "),
    ("pic", "PIC"),
    ("procedure", "PROCEDURE"),
    ("program-id", "PROGRAM-ID"),
    ("run", "RUN"),
    ("section", "SECTION"),
    ("size", "SIZE"),
    ("space", "SPACE"),
    ("stop", "STOP"),
    ("string", "STRING"),
    ("with", "WITH"),
    ("working-storage", "WORKING-STORAGE")
]

# Modules

import sys
import re

# Arguments

filename = sys.argv[1]

# Reading

with open(filename, "r") as file:
    content = file.read()

    for keyword in keywords:
        lower = keyword[0]
        upper = keyword[1]

        if re.search(lower, content):
            content = re.sub(lower, upper, content)

    file.close()

# Writing

with open(filename, "w") as file:
    file.write(content)
    file.close()