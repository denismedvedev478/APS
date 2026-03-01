import re
with open('report.log') as f:
    for n, line in enumerate(f, 1):
        m = re.search(r'\(\s*(\d+)\s+instead\s+of\s+(\d+)\s*\)', line)
        if m and int(m[1]) != int(m[2]):
            print(n)