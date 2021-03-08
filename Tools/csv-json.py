import json
import csv
import sys

def convert(f):
  reader = csv.reader(open(f))
  ata2s = {}
  chapters = []

  for row in reader:
    if row[0] not in ata2s:
      ata2s[row[0]] = {
        'ata2': row[0],
        'chapter_name': row[2],
        'subchapters': [] 
      }

    ata2s[row[0]]['subchapters'].append(
      {
        'ata4': row[1],
        'subchapter_name': row[3]
      }
    )

  for item in ata2s.items():
    chapters.append(item[1])

  print(json.dumps(chapters, indent=4))

if __name__ == '__main__':
  convert(sys.argv[1])