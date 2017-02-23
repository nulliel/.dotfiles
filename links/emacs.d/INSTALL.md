This configuration uses various features introduced in Emacs 25. The following section details how to install the required dependencies on Fedora based distributions.

# Build Tools
```bash
dnf groupinstall "Development Tools"
dnf groupinstall "C Development Tools and Libraries"
```

# Emacs
Check [GitHub](https://github.com/emacs-mirror/emacs/releases) for the latest Emacs releases.

##### Dependencies
```bash
dnf install texinfo
dnf install gtk3-devel webkitgtk3-devel
dnf install libXpm-devel libjpeg-devel giflib-devel libtiff-devel
dnf install ncurses-devel
```


```bash
wget https://github.com/emacs-mirror/emacs-archive/emacs-25.1-rc1.tar.gz
tar zxf emacs-25.1-rc1.tar.gz
cd emacs-emacs-25.1-rc1
./autogen.sh
./configure --with-xwidgets
make
make install
```

#  Other Dependencies
These dependencies are not required to run Emacs, but may be necessary for this configuration to run as intended.

##### Fonts
```bash
dnf install epel-release
dnf install adobe-source-code-pro-fonts
```

##### Aspell
```bash
dnf install aspell aspell-en
```




requires...

font: source code pro

programs: the_silver_searcher
