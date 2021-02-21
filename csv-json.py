import json
import csv
import sys

def convert(f):
  reader = next(csv.reader(open(f)))

  chapters = []
  subchapters = []
  chapter = {}
  
  for row in reader:
    if not chapter:
      chapter = {
        'ata2' : row[0],
        'chapter_name' : row[2]
      }
    elif chapter['ata2'] != row[0]:
      chapter['subchapters'] = subchapters
      subchapters = []

      chapters.append(chapter)
      chapter = {
        'ata2' : row[0],
        'chapter_name' : row[2]
      }

    subchapters.append(
      {
        'ata4' : row[1],
        'subchapter_name' : row[3]
      }
    )  

  print(json.dumps(chapters, indent=4))

   

if __name__ == '__main__':
  convert(sys.argv[1])