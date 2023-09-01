# OSX .files

Dotfiles for my Macbook work setup, inspired by my previous Linux dotfiles and workflows

## Gestures

I use my trackpad quite a lot on workbooks, and so just like it is important to have good keyboard shortcuts, I find it equally important to have smart gestures set up.

### Multitouch

I use Multitouch for this - I tried BTT but found that the gesture recognition/sensitivity was a bit off, even after trying to manually tweak the settings.

The most important is the three finger click for middle click. Other than that I have some browser controls as follows:

- Three finger
    - Down -> Close tab
    - Left -> Switch tabs left
    - Right -> Switch tabs right

### Mac gestures

I found that configuring the Mac's own gesture to open Mission Control to be Three Finger Swipe Up made the gestures from Multitouch work better - I suppose this somehow gives three finger gestures a bit of precedent over two finger swipes, etc.

Also, the swiping between full-screen applications is set to four finger swipes, of course.

## Keyboard shortcuts

I use Karabiner for most of my keyboard shortcut needs - config is found in `.config/karabiner/karabiner.json`.

## Vim

Simply open vim and it should automatically install everything the first time. If something is wrong, or nothing seemed to have been installed, run `:PlugInstall` from within vim.

