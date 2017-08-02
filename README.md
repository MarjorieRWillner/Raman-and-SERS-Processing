# Raman-and-SERS-Processing

This Matlab code can be used to analyze Raman and SERS maps. 

The main file, aa_ProcessSERS.m, needs to be in the same path as all the functions in order to run correctly. If you have already calculated the baseline using aa_ProcessSERS than you can use aa_1_ifBaselineExists to make additional maps and ratios. Using aa_1_ifBaselineExists is a faster option when processing large maps (>1000 spectra).

For the dimensions to be automatically extracted from the file name they must be in the form x=10;y=10;z=10#xs=10#ys=10#zs=12#es=0.5 with no other equal signs (=), colons (;) or pound signs/hastags (#). All other characters can be included. If you want do not want to follow this code, you can preset the map dimensions at the top of the code (set HW =1). If you want to enter the dimensions for each map leave HW = 0 . For each map a dialogue box will open, it will provide you with the total number of spectra and ask you for the map dimensions.  



[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.838227.svg)](https://doi.org/10.5281/zenodo.838227)
