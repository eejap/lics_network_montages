#!/usr/bin/bash

# Written by Jessica Payne 10/03/2022
# Last edited by Jessica Payne 24/02/2023

# This script produces a montage of interferogram networks for ascending frames across Iran using data pulled from the COMET LiCS Portal (Lazecky et al 2020, https://comet.nerc.ac.uk/comet-lics-portal/).
# Output montage will be saved in $push_directory and stored in $working_directory/montages/$today;
# Pulled network.png images will be saved in $working_directory/ascending/$today

# change these variables
today=030323

working_directory=/nfs/a285/homes/eejap/datasets/lics/networks/iran
push_directory=/nfs/see-fs-02_users/eejap/public_html/lics_network_montage
ascending_frames=iran_frames_a.txt
ascending_frames_order=iran_frames_a_ordered.txt
montage_name=iran_networks_montage_a.png

#plot_title='Iran_Ascending_Networks'
plot_tile=9x9

# Make directory to store ascending networks for the region of interest if you have never run this script before
# mkdir $working_directory/ascending

########### Do not edit below ############
# Path where public LiCSAR products are stored
jasmin_path=gws-access.jasmin.ac.uk/public/nceo_geohazards/LiCSAR_products

# Make directory to store Iran ascending networks available on Portal today
mkdir $working_directory/ascending/$today

cp $ascending_frames_order $working_directory/ascending/$today/.

while IFS= read -r line; do
    first_digit="${line:0:1}"
    first_digits="${line:0:2}"
    if [[ "$first_digits" == 00 ]]
    then
        track=`echo $line | awk '{print substr($1,3,1)}'`
     elif [[ "$first_digit" == 1 ]]
    then
        track=`echo $line | awk '{print substr($1,1,3)}'`
    elif [[ "$first_digit" == 0 ]]
    then
        track=`echo $line | awk '{print substr($1,2,2)}'`
    fi
    wget -O $working_directory/ascending/$today/$line.png --no-check-certificate $jasmin_path/$track/$line/metadata/network.png
done < $ascending_frames

# Go to where the ascending networks are now stored and montage them into the order that they cover Iran (starting at NW, move E, begin new line, continue, finish SE)
cd /$working_directory/ascending/$today
montage @$ascending_frames_order -tile $plot_tile -geometry 4400x700+0+0 -title 'Iran Ascending Networks' $push_directory/$montage_name

# Store montage for future reference in dated directory alongside ascending/descending network pngs
mkdir $working_directory/montages/$today
cp $push_directory/$montage_name $working_directory/montages/$today/$montage_name

cd ~
