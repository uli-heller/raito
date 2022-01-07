02 - Load Javascript Within Element
===================================

I'd like to have these elements:

- top.md ... contains my logo
- navbar.md ... contains the navbar
- hide.html ... contains a button and javascript to hide "top.md"

Unfortunately, it doesn't seem to work.
The javascript function within hide.html cannot be
executed. Moving the function into index.html makes
this work ok!

config-dp.js
------------

```html
const config = {
        root: "",                              // Website Root URL. Eg: "/raito/"
        name: "Raito",
        elements: [ "top", "navbar", "hide.html" ],
        errorMessage: "Page not found",
        noHash: ["svg","png","jpg", "html"],            // for urls ending with these extensions, don't use hash urls
        hashBaseUrl:   "#/",
        noHashBaseUrl: "",
}

```

hide.html
---------

```html
<script>
  function toggleTop() {
    var top=document.getElementById("top");
    if (top.style.display === "none") {
      top.style.display = "block";
    } else {
      top.style.display = "none";
    }
  }
</script>

<button onclick="toggleTop()">Hide</button>
```




