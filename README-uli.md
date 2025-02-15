Uli's Fork Of Raito
===================

This is my fork of [Raito](https://github.com/arnaudsm/raito).

## Issues And Investigations

[Here](issues/) is a list of open and closed issues!

## Install

See [INSTALL.md](INSTALL.md) for a description
on how to install a distribution release.

## Release

See [RELEASE.md](RELEASE.md) for a description
on how to create a distribution release.

## Update

### marked.min.js

Download [marked.min.js](https://raw.githubusercontent.com/markedjs/marked/master/marked.min.js) from github
and store it.

As of 2022-01-08, we are using version v4.0.9 of marked.min.js.

```
$ curl -so marked.min.js https://raw.githubusercontent.com/markedjs/marked/master/marked.min.js
```

### highlight.min.js

Determine the current version of highlight.js via [Github](https://github.com/highlightjs/highlight.js/releases)
or [highlightjs.org](https://highlightjs.org/): 11.4.0

Download [highlight.min.js](https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/highlight.min.js)
and [solarized-dark.min.css](https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/styles/base16/solarized-dark.min.css)
and store them.

As of 2022-01-08, we are using version 11.4.0 of highlight.min.js.

```
$ curl -so highlight.min.js https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/highlight.min.js
$ curl -so solarized-dark.min.css https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.4.0/styles/base16/solarized-dark.min.css
```
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

### Lists

Markdown

```markdown
- list item 1
- list item 2
- list item 3
```

Output

- list item 1
- list item 2
- list item 3

Difference: Within standard raito, a list shows
up like this:

![raito list](raito-list.png)

There is a different background, a frame and much more space consumption.
I don't like it.

### Checklists

Markdown

```markdown
- [x] Beer
- [ ] Pancakes
```

Output

- [x] Beer
- [ ] Pancakes

Difference

Within standard raito, a checklist shows
up like this:

![raito checklist](raito-checklist.png)

There is a different background, a frame and much more space consumption.
I don't like it.
