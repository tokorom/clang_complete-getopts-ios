clang_complete-getopts-ios
==========================

clang_complete plugin that help iOS programming.

# Required

* [clang_complete.vim](https://github.com/Rip-Rip/clang_complete)

# Install

## Install with Vundle

```
Bundle 'git://github.com/Rip-Rip/clang_complete.git'
Bundle 'git://github.com/tokorom/clang_complete-getopts-ios.git'
```

## Install with NeoBundle

```
NeoBundle 'git://github.com/Rip-Rip/clang_complete.git'
NeoBundle 'git://github.com/tokorom/clang_complete-getopts-ios.git'
```

# Options and defaults

```
let g:clang_complete_getopts_ios_default_options = '-fblocks -fobjc-arc -D __IPHONE_OS_VERSION_MIN_REQUIRED=40300'

let g:clang_complete_getopts_ios_sdk_directory = '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk'

let g:clang_complete_getopts_ios_ignore_directories = ["^\.git", "\.xcodeproj"]
```
