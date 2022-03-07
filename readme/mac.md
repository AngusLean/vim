1. brew install --HEAD universal-ctags/universal-ctags/universal-ctags
2. Download GNU Global from https://www.gnu.org/software/global/download.html Uncompress and configure it with universal ctags

./configure --with-universal-ctags=/usr/local/bin/ctags and then make & make install

To check that gtags was installed correctly, you could run which gtags. It must point out to /usr/local/bin/gtags

Now, running the gtags --gtagslabel=new-ctags should not produce any errors!
3. pip3 install pygments
