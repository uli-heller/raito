Uli's Fork Of Raito
===================

This is my fork of Raito.

## Install

Drop these files into your website root:

* index.html
* marked.min.js
* raito.css
* highlight.min.js
* solarized-dark.min.css
* navbar.md
* github_ribbon.md
* logo.svg
* README.md
* README-uli.md

## Update

### marked.min.js

Download [marked.min.js](https://raw.githubusercontent.com/markedjs/marked/master/marked.min.js) from github
and store it.

As of 2022-01-04, we are using version v4.0.8 of marked.min.js.

### highlight.min.js

Determine the current version of highlight.js via [Github](https://github.com/highlightjs/highlight.js/releases)
or [highlightjs.org](https://highlightjs.org/): 11.3.1

Download [highlight.min.js](https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/highlight.min.js)
and [solarized-dark.min.css](https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/styles/base16/solarized-dark.min.css)
and store them.

As of 2022-01-04, we are using version 11.3.1 of highlight.min.js.

## Features And Differences

### Relative URL Of An Image

Markdown

```md
![The logo](logo.svg)
```

Output

![The logo](logo.svg)

Difference: For standard raito, you have to specify "/logo.svg". Otherwise,
"#/" will be prepended to the svg link making it impossible to show the image.

### Link To An Image

Markdown

```md
[The logo](logo.svg)
````

Output

[The logo](logo.svg)

Difference: For standard raito, the link to the logo is broken. Activating the link
produces an error message like "Page not found". For my fork, the link works as expected.

### Subfolders

[subfolder-01/README.md](subfolder-01/README.md)

Difference: For standard raito, you cannot dive into hierarchies of folders.
For my fork,

- you can dive into subfolder-01
- and from there into subfolder-02
- and from there into subfolder-03

### Syntax Highlighting

```shell
if [ "${SHELL}" = "/bin/bash" ]; then
  echo BASH
fi  
```

Difference: "highlight.js" is activated by default!
