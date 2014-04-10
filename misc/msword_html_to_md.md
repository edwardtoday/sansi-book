Convert Microsoft Word HTML to GitHub Flavored Markdown
=======================================================

1. Save a Word documents as HTML
2. Convert encoding from `gb2312` to `utf8`. And fix the `charset` value in HTML metadata.
```bash
iconv -f gb2312 -t utf-8 input.html | sed -e "s/charset=gb2312/charset=utf8/g" | pbcopy
```
3. Cleanup the output html with [Dirty Markup](http://www.dirtymarkup.com/)
4. Convert the clean html with pandoc
```bash
pbpaste | pandoc -f html -t markdown_github -o output.md
```
