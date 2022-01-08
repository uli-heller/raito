# Release

This needs to be simplified! I is just way too much work!

- Do some tests by running `./check-this.sh` and heading your browser to [localhost:8000](http://localhost:8000)
- Clean your folder: `git clean -ndx`, verify outout, `git clean -fdx`
- Test again by running `./check-this.sh` and heading your browser to [localhost:8000](http://localhost:8000)
- Execute `./create-distributions.sh` -> "raito-v0.5-11-g71a7c41.tar.xz" and "raito-dp-v0.5-11-g71a7c41.tar.xz"
- Test prerelease using my layout: `./check-distribution.sh raito-dp-v*xz` and [localhost:8000](http://localhost:8000)
- Test prerelease using standard layout: `./check-distribution.sh raito-v*xz` and [localhost:8000](http://localhost:8000)
- Clean again: `git clean -ndx`, verify output, `git clean -fdx`
- Merge to main: `git checkout main && git merge develop`
- Show at the last version tag: `git describe --tags`  -> `v0.5-11-g71a7c41`
- Select the next version tag: "v0.6"
- Verify and fix [CHANGELOG.md](CHANGELOG.md)
- Commit: `git commit -m "Preparing v0.6" .`
- Tag: `git tag v0.6`
- Test again by running `./check-this.sh` and heading your browser to [localhost:8000](http://localhost:8000)
- Execute `./create-distributions.sh` -> "raito-v0.6.tar.xz" and "raito-dp-v0.6.tar.xz"
- Test release using my layout: `./check-distribution.sh raito-dp-v*xz` and [localhost:8000](http://localhost:8000)
- Test release using standard layout: `./check-distribution.sh raito-v*xz` and [localhost:8000](http://localhost:8000)
- Publish: `git push; git push --tags`
- Upload the artifacts to [GITHUB](https://github.com/uli-heller/raito/tags) and create a release from the tag
- Clean again: `git clean -ndx`, verify output, `git clean -fdx`
- Prepare "develop" for the next cycle:
    - `git checkout develop`
    - `git merge main`
    - Prepare [CHANGELOG.md](CHANGELOG.md) - add stub for "v0.7pre"
    - `git commit -m "Preparing v0.7pre" .`
    - `git push`
