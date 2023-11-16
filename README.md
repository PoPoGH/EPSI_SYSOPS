# Flat Markdown Site
Simple single file site generated from a markdown content. 

## Prerequisites
Install pandoc using the appropriate package manager for your OS. For example, from ubuntu :
```
sudo apt update -y
sudo apt install -y pandoc
```

## Generate site
The site can be built with :
```
pandoc -s index.md --template _template_.html -o index.html
```

The downloadable docx file can be generated using :
```
pandoc -s index.md index.docx
```

## Authors
Quentin L