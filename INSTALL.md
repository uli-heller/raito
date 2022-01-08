# Install

Installation is easy, although this description
is pretty long. Basically, you download, verify and unpack
the distribution and that's it.

Onto the details:

- Download a distribution from [GITHUB](https://github.com/uli-heller/raito/releases/latest)
    - raito-v* ... standard layout
    - raito-dp-v* ... my layout
- Verify the distribution
    ```sh
    $ ls -1
    raito-dp-v0.6.tar.xz
    raito-dp-v0.6.tar.xz.sha256
    raito-dp-v0.6.tar.xz.ssh-sig

    $ sha256sum -c raito-dp-v0.6.tar.xz.sha256 
    raito-dp-v0.6.tar.xz: OK

    $ GITHUB_PUBKEY="$(curl -sq "https://github.com/uli-heller.keys")"
    $ echo "uli ${GITHUB_PUBKEY}" >allowed-signer
    $ $ ssh-keygen -Y verify -n file -f allowed-signer -s raito-dp-v0.6.tar.xz.ssh-sig -I uli <raito-dp-v0.6.tar.xz
    Good "file" signature for uli with RSA key SHA256:h7Xg0Eg5bOp/L0HswSMtwxs0lbNX0hOtRmBqX5qjseg

    $ rm allowed-signer
    ```
- Unpack the distribution to a temporary folder:
    ```sh
    $ mkdir /tmp/my-test
    $ xz -cd raito-dp-v0.6.tar.xz|(cd /tmp/my-test && tar --strip-components=1 -xf -)
    ```
- Start a simple python http server:
    ```sh
    $ python3 -m http.server 8080 -d /tmp/my-test/
    Serving HTTP on 0.0.0.0 port 8080 (http://0.0.0.0:8080/) ...
    ```
- Head your browser to [http://localhost:8080](http://localhost:8080)
- Customize
    - config.js or config-dp.js
    - top.html
    - navbar-dp.md
    - footer-dp.md
    - README.md
    - dp.css (for the styling)
    - *.svg (logos)
- Remove default content
    - README-uli.md
    - issues
    - CHANGELOG.md
    - LICENSE.md
    - ... and probably much more
- Keep essentials
    - index.html
    - marked.min.js
    - highlight.min.js
    - solarized-dark.min.css
- Stop the simple python http server by pressing Ctrl-C
- Copy the files and folders to your webroot
- Adjust `root` within config.js or config-dp.js
