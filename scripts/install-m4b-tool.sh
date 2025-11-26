#!/bin/bash

# From: https://github.com/sandreas/m4b-tool?tab=readme-ov-file#recommended-high-audio-quality-sort-tagging

# FIRST INSTALL ONLY: if not already done, remove existing ffmpeg with default audio quality options
# check for ffmpeg with libfdk and uninstall if libfdk is not already available
[ -x "$(which ffmpeg)" ] && (ffmpeg -hide_banner -codecs 2>&1 | grep libfdk || brew uninstall ffmpeg)

# tap required repositories
brew tap sandreas/tap
brew tap homebrew-ffmpeg/ffmpeg

# check available ffmpeg options and which you would like to use
brew options homebrew-ffmpeg/ffmpeg/ffmpeg

# install ffmpeg with at least libfdk_aac for best audio quality
brew install homebrew-ffmpeg/ffmpeg/ffmpeg --with-fdk-aac

# install m4b-tool
brew install sandreas/tap/m4b-tool

# check installed m4b-tool version
m4b-tool --version