## 1.0.1

### Bug Fixes

* Install node.js from source on all platform families except Debian. This is
a workaround for issue mdxp/nodejs-cookbook#19 in the upstream `nodejs`
cookbook. Installing node.js from RPM is no longer possible on
Fedora/RHEL/CentOS as the packages are no longer maintained.

### New features

* test-kitchen 1.0 support

### Improvements

* A CHANGELOG!
* Pull request #1: Fix typo in README. (@streeter)
* Remove references to CentOS 5.5 support
* Add proper supports fields to metadata

## 1.0.0

* The initial release. Cookbooks was inspired by internal cookbook Opscode uses to
deploy our instance of `hubot`, but refactored/modenerized based on current
cookbook development best practices.
