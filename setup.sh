#!/bin/bash

rm ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings && ln -s ~/workspace/dotfiles/Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
rm ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap  && ln -s ~/workspace/dotfiles/Default\ \(Linux\).sublime-keymap  ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap
rm ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-mousemap  && ln -s ~/workspace/dotfiles/Default\ \(Linux\).sublime-mousemap  ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-mousemap
rm ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings && ln -s ~/workspace/dotfiles/Package\ Control.sublime-settings ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
rm ~/.config/terminator/config && ln -s ~/workspace/dotfiles/terminator_config ~/.config/terminator/config
