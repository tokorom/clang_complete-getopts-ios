" clang_complete-getopts-ios - clang_complete plugin that help iOS programming
" Version: 0.1.0
" Copyright (C) 2013 tokorom <http://www.tokorom.me/>

" Options  "{{{1

if !exists('g:clang_complete_getopts_ios_default_options')
  let g:clang_complete_getopts_ios_default_options = '-fblocks -fobjc-arc -D__IPHONE_OS_VERSION_MIN_REQUIRED=40300 -x objective-c -std=gnu99'
endif

if !exists('g:clang_complete_getopts_ios_sdk_directory')
  let g:clang_complete_getopts_ios_sdk_directory = '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk'
endif

if !exists('g:clang_complete_getopts_ios_ignore_directories')
  let g:clang_complete_getopts_ios_ignore_directories = ['^\.git', '\.xcodeproj', '^build', '\.lproj']
endif

" Public functions "{{{1

function! getopts#ios#getopts()
  call s:AddDefaultOptions()
  call s:AddSdkOptions()
  call s:AddPreCompiledHeaders()
  call s:AddCurrentDirectoryToIncludePathsRecursively()
endfunction

" Private functions "{{{1

function! s:AddCurrentDirectoryToIncludePathsRecursively()
  let dirs = s:GetDirectoriesRecursively("**")
  call s:AddIncludePathsToUserOptions(dirs)
endfunction

function! s:AddDefaultOptions()
  let b:clang_user_options .= ' ' . g:clang_complete_getopts_ios_default_options
endfunction

function! s:AddSdkOptions()
  let b:clang_user_options .= ' -F' . g:clang_complete_getopts_ios_sdk_directory . '/System/Library/Frameworks'
endfunction

function! s:AddPreCompiledHeaders()
  let files = split(glob("**/*.pch"), "\n")
  for file in files
    let opt = '-include "' . file . '"'
    let b:clang_user_options .= ' ' . opt
  endfor
endfunction

function! s:GetDirectoriesRecursively(dirname)
  let files = split(glob(a:dirname), "\n")
  let dirs = []
  for file in files
    if isdirectory(file) && !s:IsIgnoreDirectory(file)
      call add(dirs, file)
    endif
  endfor
  return dirs
endfunction

function! s:AddIncludePathsToUserOptions(dirs)
  let dirs = a:dirs
  for dir in dirs
    let opt = '-I"' . dir . '"'
    let b:clang_user_options .= ' ' . opt
  endfor
endfunction

function! s:IsIgnoreDirectory(dir)
  let dir = a:dir
  let ignore_dirs = g:clang_complete_getopts_ios_ignore_directories
  for ignore_dir in ignore_dirs
    if dir =~ ignore_dir
      return 1
    endif
  endfor
  return 0
endfunction
