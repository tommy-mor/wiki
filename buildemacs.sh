#https://www.emacswiki.org/emacs/GccEmacs

git clone git://git.savannah.gnu.org/emacs.git
cd emacs
./autogen.sh
./configure --with-native-compilation
make -j$(nproc)
