#!/usr/bin/env python3
import re, sys
from pathlib import Path

BLOCKED = {
    "ent","end","frame","mask","fmask","set","abicalls",
    "cpload","cprestore","type","size","file","loc","module",
    "option","mdebug"
}
blocked_re = re.compile(r"^\s*\.(cfi\w*|pdr)\b", re.I)

sec_re = re.compile(r"^\s*\.section\s+\.([A-Za-z0-9_\.]+)")
p2align_re = re.compile(r"^\s*\.p2align\s+(\d+)")
balign_re = re.compile(r"^\s*\.balign\b")
asciz_re = re.compile(r"^\s*\.asciz\b")
zero_re = re.compile(r"^\s*\.zero\s+(\d+)\b")
global_re = re.compile(r"^\s*\.global\b", re.I)

ALLOWED_PREFIXES = (
    ".text",".data",".globl",
    ".word",".half",".byte",".space",".float",".double",
    ".ascii",".asciiz",".align",".eqv",
)

def convert_section(line):
    m = sec_re.match(line)
    if not m: return None, None
    sec = m.group(1)
    if sec.startswith("text"):
        return ".text\n", "text"
    if sec.startswith(("rodata","rdata","data","sdata","sbss","bss")):
        # map all data-like to .data
        return ".data\n", "data"
    # unknown section: drop & keep segment unchanged
    return "", None

def main():
    if len(sys.argv) != 3:
        print(f"Usage: {Path(sys.argv[0]).name} in.s out.s", file=sys.stderr)
        sys.exit(2)
    src, dst = Path(sys.argv[1]), Path(sys.argv[2])

    seg = None  # "text" | "data" | None
    out = []

    for raw in src.read_text().splitlines(True):
        line = raw

        # Normalize .global → .globl early
        if global_re.match(line):
            line = global_re.sub(".globl", line)

        # Convert .asciz → .asciiz
        if asciz_re.match(line):
            line = asciz_re.sub(".asciiz", line)

        # Convert .zero N → .space N  (MARS-friendly)
        if zero_re.match(line):
            line = zero_re.sub(r".space \1", line)

        # Handle .section mapping (and update segment)
        changed, new_seg = convert_section(line)
        if changed is not None:
            if changed == "":
                line = ""
            else:
                line = changed
            if new_seg is not None:
                seg = new_seg

        # Track explicit .text / .data
        if re.match(r"^\s*\.text\b", line): seg = "text"
        if re.match(r"^\s*\.data\b", line): seg = "data"

        # Drop/convert alignments
        if p2align_re.match(line):
            n = p2align_re.match(line).group(1)
            # In text: drop; in data: keep as .align
            line = ("" if seg == "text" else f".align {n}\n")
        if balign_re.match(line):
            # No .balign in MARS; drop in text, drop in data too (rarely needed)
            line = ""

        # If an .align survived and we’re in text, drop it
        if seg == "text" and re.match(r"^\s*\.align\b", line):
            line = ""

        # Drop unsupported directives
        if line and line.lstrip().startswith("."):
            head = line.lstrip()[1:].split(None,1)[0].lower()
            if head in BLOCKED or blocked_re.match(line):
                line = ""

        # Keep instructions, labels, comments; and allowed simple directives
        if line:
            if not line.lstrip().startswith("."):
                out.append(line)
            else:
                if any(line.lstrip().startswith(p) for p in ALLOWED_PREFIXES):
                    out.append(line)
                # else: already dropped

    dst.write_text("".join(out))

if __name__ == "__main__":
    main()

