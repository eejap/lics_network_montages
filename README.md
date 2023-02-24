# lics_network_montages
This set of shell scripts pulls produces montages of interferogram networks for ascending and descending frames across Iran using data pulled from the COMET LiCS Portal (Lazecky et al 2020, https://comet.nerc.ac.uk/comet-lics-portal/).

To make your own montages:
1. Create lists of ascending and descending frames to be montaged (*_frames_a.text and *_frames_d.txt)
2. Create a list of the network pngs for these frames in the order you want them to appear on the montage. Where there is a gap put null:
3. Edit parameters in network_montage_a.sh and network_montage_d.sh to fine tune your montage
e.g. plot_tile should be the size of your desired montage with the number of columsn and rows determined by the number of LiCS frames across your region E-W and N-S
