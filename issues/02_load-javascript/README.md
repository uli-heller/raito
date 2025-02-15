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

First Try
---------

### config-dp.js

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

### hide.html

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

Another Try Based On StackOverflow
----------------------------------

### index.html

See [StackOverflow][002]:

```diff
diff --git a/index.html b/index.html
index 29e0dc2..02404a2 100644
--- a/index.html
+++ b/index.html
@@ -130,6 +130,17 @@
             });
     }
 
+    const setInnerHTML = function(elm, html) {
+      elm.innerHTML = html;
+      Array.from(elm.querySelectorAll("script")).forEach( oldScript => {
+        const newScript = document.createElement("script");
+        Array.from(oldScript.attributes)
+          .forEach( attr => newScript.setAttribute(attr.name, attr.value) );
+        newScript.appendChild(document.createTextNode(oldScript.innerHTML));
+        oldScript.parentNode.replaceChild(newScript, oldScript);
+      });
+    }
+
     const loadContent = async (hash) => {
         // Hash routing
         if (hash == '') hash = "/";
@@ -138,7 +149,7 @@
         //if (hash.slice(-3) == ".md") hash = hash.slice(0, -3);
 
         // Load Markdown
-        content.innerHTML = await renderMD(hash) || config.errorMessage || ''
+        setInnerHTML(content, await renderMD(hash) || config.errorMessage || '');
 
         // Reformat document
         document
@@ -174,7 +185,7 @@
         }
         if (!elementHtml) return
 
-        elementDiv.innerHTML = elementHtml;
+        setInnerHTML(elementDiv, elementHtml);
 
        if (isNavbar(element)) {
            handleNavbar(element)
```

### config-dp.js And hide.html

Same versions as in first try.

### Outcome

Lots of stange error messages show up within the browser console.
It doesn't work!

Final Try Based On StackOverflow
----------------------------------

### index.html

See [StackOverflow][001]:

```diff
diff --git a/index.html b/index.html
index 29e0dc2..e004337 100644
--- a/index.html
+++ b/index.html
@@ -17,7 +17,7 @@
 <link rel="stylesheet" href="solarized-dark.min.css">
 
 <!-- Configure me! -->
-<script src="config-dp.js?raito_version=v0.8"></script>
+<script src="config-dp.js?raito_version=v0.9pre"></script>
 
 <body>
     <div id="content"></div>
@@ -130,6 +130,35 @@
             });
     }
 
+    function nodeScriptReplace(node) {
+        if ( nodeScriptIs(node) === true ) {
+                node.parentNode.replaceChild( nodeScriptClone(node) , node );
+        }
+        else {
+                var i = -1, children = node.childNodes;
+                while ( ++i < children.length ) {
+                      nodeScriptReplace( children[i] );
+                }
+        }
+
+        return node;
+    }
+
+    function nodeScriptClone(node){
+        var script  = document.createElement("script");
+        script.text = node.innerHTML;
+
+        var i = -1, attrs = node.attributes, attr;
+        while ( ++i < attrs.length ) {
+              script.setAttribute( (attr = attrs[i]).name, attr.value );
+        }
+        return script;
+    }
+
+    function nodeScriptIs(node) {
+        return node.tagName === 'SCRIPT';
+    }
+
     const loadContent = async (hash) => {
         // Hash routing
         if (hash == '') hash = "/";
@@ -139,6 +168,7 @@
 
         // Load Markdown
         content.innerHTML = await renderMD(hash) || config.errorMessage || ''
+        nodeScriptReplace(content);
 
         // Reformat document
         document
@@ -175,6 +205,7 @@
         if (!elementHtml) return
 
         elementDiv.innerHTML = elementHtml;
+        nodeScriptReplace(elementDiv);
 
         if (isNavbar(element)) {
             handleNavbar(element)
```

### config-dp.js And hide.html

Same versions as in first try.

### Outcome

It works OK! But it looks ugly - we need some styling!

![hide](hide-button.png)

![unhide](unhide-button.png)

Here a first improvement:

![hide2](hide-button2.png)

![unhide2](unhide-button2.png)


Links And References
-----

- [StackOverflow: Can scripts be inserted with innerHTML?][001]
- [StackOverflow: Executing "script" elements inserted with .innerHTML][002]

[001]: https://stackoverflow.com/questions/1197575/can-scripts-be-inserted-with-innerhtml
[002]: https://stackoverflow.com/questions/2592092/executing-script-elements-inserted-with-innerhtml
