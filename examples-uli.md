# Uli's Examples

## highlight

### diff

```diff
@@ -181,8 +214,8 @@
         document.body.classList.add("loaded");
 
         // Clean Hash
-        //hash = "#" + hash.replace(/(README$)/, '')
-        //window.location.replace(hash);
+        hash = "#" + normalizePath(hash);
+        window.location.replace(hash);
     };
```

### csv

```csv
col1,col2,col3
1,2,3
11,22,33
111,222,333
```
