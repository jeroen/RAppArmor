Recent changes in CRAN prevent packages from including any non-standard files/dirs in the the root of the package. Therefore the debian dir has moved into the /tools/ directory. To build deb package from source, untar the source package and run:

#copy debian dir and build deb package
cp -Rf tools/debian .
debuild -uc -us

#Install the package
cd ..
sudo dpkg -i r-cran-rapparmor_*.deb

